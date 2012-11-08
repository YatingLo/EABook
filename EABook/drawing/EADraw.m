//
//  EADraw.m
//  EABook
//
//  Created by Mac06 on 12/11/8.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EADraw.h"

@implementation EADraw
+(CCScene *) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	EADraw *layer = [EADraw node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
    if (self = [super init]) {
        gamepoint = delegate.EAGamePoint;
        tapObjectArray = [[NSMutableArray alloc] init];
        
        delegate = (AppController*) [[UIApplication sharedApplication] delegate];
        tapgestureRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)] autorelease];
        tapgestureRecognizer.numberOfTapsRequired = 1; //new add
        [delegate.navController.view addGestureRecognizer:tapgestureRecognizer];
        
        //[self addChild:soundMgr];
        [self addObjects];
    }
    return self;
}

-(void) addObjects
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *image = [CCSprite spriteWithFile:@"GAME_speedboat.jpg"];
    image.position = ccp(size.width/2, size.height/2);
    image.tag = 40;
    [self addChild:image];
    
    
    //加入array
    [tapObjectArray addObject:image];
}


#pragma 手勢處理
-(void) handleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    if (touchEnable && (tapObjectArray.count > 0)) {
        
        [self tapSpriteMovement:touchLocation];
    }
}

-(void) tapSpriteMovement:(CGPoint)touchLocation
{
    NSLog(@"Location x:%f y:%f",touchLocation.x, touchLocation.y);
    //NSLog(@"Tap! %d", tapObjectArray.count);
    for (CCSprite* obj in tapObjectArray) {
        if (CGRectContainsPoint(obj.boundingBox, touchLocation)) {
            NSLog(@"Tap! %d", obj.tag);
            switch (obj.tag) {
                case 40: //回到menu
                    tempObject = (EAAnimSprite*)obj;
                    CGPoint inSpriteLocation = ccpSub(touchLocation, ccpSub(tempObject.position, ccp(tempObject.boundingBox.size.width/2, tempObject.boundingBox.size.height/2)));
                    //ccpSub(touchLocation, tempObject.position);
                    NSLog(@"Location In Sprite x:%f y:%f",inSpriteLocation.x, inSpriteLocation.y);
                    UIColor *clickColor = [self getPixelColorAtLocation:inSpriteLocation];
                    CCLOG(@"%@", clickColor.description);
                    //[soundMgr playSoundFile:@"push.mp3"];
                    break;
                default:
                    break;
            }
            break;
        }
    }
}

#pragma 圖像處理
- (UIColor*) getPixelColorAtLocation:(CGPoint)point {
	UIColor* color = nil;
    UIImage* image = [self convertSpriteToImage:(CCSprite*)[self getChildByTag:40]];
    CGImageRef inImage = image.CGImage;
	//CGImageRef inImage = self.image.CGImage;
	// Create off screen bitmap context to draw the image into. Format ARGB is 4 bytes for each pixel: Alpa, Red, Green, Blue
    
    CGContextRef cgctx = [EADraw createARGBBitmapContextFromImage:inImage];
	//CGContextRef cgctx = [self createARGBBitmapContextFromImage:inImage];
	if (cgctx == NULL) { return nil; /* error */ }
	
    size_t w = CGImageGetWidth(inImage);
	size_t h = CGImageGetHeight(inImage);
	CGRect rect = {{0,0},{w,h}};
	
	// Draw the image to the bitmap context. Once we draw, the memory
	// allocated for the context for rendering will then contain the
	// raw image data in the specified color space.
	CGContextDrawImage(cgctx, rect, inImage);
	
	// Now we can get a pointer to the image data associated with the bitmap
	// context.
	unsigned char* data = CGBitmapContextGetData (cgctx);
	if (data != NULL) {
		//offset locates the pixel in the data from x,y.
		//4 for 4 bytes of data per pixel, w is width of one row of data.
		int offset = 4*((w*round(point.y))+round(point.x));
		int alpha =  data[offset];
		int red = data[offset+1];
		int green = data[offset+2];
		int blue = data[offset+3];
		NSLog(@"offset: %i colors: RGB A %i %i %i  %i",offset,red,green,blue,alpha);
		color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
	}
	
	// When finished, release the context
	CGContextRelease(cgctx);
	// Free image data memory for the context
	if (data) { free(data); }
	
	return color;
}

+ (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef) inImage {
    
    CGContextRef    context = NULL;
	CGColorSpaceRef colorSpace;
	void *          bitmapData;
	int             bitmapByteCount;
	int             bitmapBytesPerRow;
	
	// Get image width, height. We'll use the entire image.
	size_t pixelsWide = CGImageGetWidth(inImage);
	size_t pixelsHigh = CGImageGetHeight(inImage);
	
	// Declare the number of bytes per row. Each pixel in the bitmap in this
	// example is represented by 4 bytes; 8 bits each of red, green, blue, and
	// alpha.
	bitmapBytesPerRow   = (pixelsWide * 4);
	bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
	
	// Use the generic RGB color space.
	colorSpace = CGColorSpaceCreateDeviceRGB();
    
	if (colorSpace == NULL)
	{
		fprintf(stderr, "Error allocating color space\n");
		return NULL;
	}
	
	// Allocate memory for image data. This is the destination in memory
	// where any drawing to the bitmap context will be rendered.
	bitmapData = malloc( bitmapByteCount );
	if (bitmapData == NULL)
	{
		fprintf (stderr, "Memory not allocated!");
		CGColorSpaceRelease( colorSpace );
		return NULL;
	}
	
	// Create the bitmap context. We want pre-multiplied ARGB, 8-bits
	// per component. Regardless of what the source image format is
	// (CMYK, Grayscale, and so on) it will be converted over to the format
	// specified here by CGBitmapContextCreate.
	context = CGBitmapContextCreate (bitmapData,
									 pixelsWide,
									 pixelsHigh,
									 8,      // bits per component
									 bitmapBytesPerRow,
									 colorSpace,
									 kCGImageAlphaPremultipliedFirst);
	if (context == NULL)
	{
		free (bitmapData);
		fprintf (stderr, "Context not created!");
	}
	
	// Make sure and release colorspace before returning
	CGColorSpaceRelease( colorSpace );
	
	return context;
}

#pragma 離開處理
-(void) dealloc {
    
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
    //[delegate.navController.view removeGestureRecognizer:swipegestureRecognizerLeft];
    //[delegate.navController.view removeGestureRecognizer:swipegestureRecognizerRight];
    
    [super dealloc];
}
#pragma 圖像轉換
-(CCSprite *) convertImageToSprite:(UIImage *) image {
    
    //CCTexture2D *texture = [[CCTexture2D alloc] initWithImage:image];
    CCTexture2D *texture = [[CCTexture2D alloc] initWithCGImage:image.CGImage resolutionType:kCCResolutioniPad];
    CCSprite    *sprite = [CCSprite spriteWithTexture:texture];
    [texture release];
    return sprite;
}

-(UIImage *) convertSpriteToImage:(CCSprite *)sprite {
    
    CGPoint p = sprite.anchorPoint;
    
    [sprite setAnchorPoint:ccp(0,0)];
    
    CCRenderTexture *renderer = [CCRenderTexture renderTextureWithWidth:sprite.contentSize.width height:sprite.contentSize.height];
    
    [renderer begin];
    
    [sprite visit];
    
    [renderer end];
    
    [sprite setAnchorPoint:p];
    
    return [renderer getUIImage];
    
    //return [UIImage imageWithData:[renderer getUIImageAsDataFromBuffer:kCCImageFormatPNG]];
}
@end
