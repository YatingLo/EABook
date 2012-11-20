//
//  EADraw.m
//  EABook
//
//  Created by Mac06 on 12/11/8.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EADraw.h"

#define gapY 25

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
        tapArray = [[NSMutableArray alloc] init];
        SelectedCrayon = -1;
        
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
    [self addBackGround:@"P0-1_game-drawcolor_background.jpg"];
    
    //界面按鈕
    int tagNum = 3;
    tempObject = [CCSprite spriteWithFile:@"P0-1_game-drawcolor_backbuttun.png"]; //離開
    tempObject.tag = tagNum++;
    tempObject.position = ccp(65, 65);
    tempObject.zOrder = 2;
    [self addChild:tempObject];
    [tapObjectArray addObject:tempObject];
    
    tempObject = [CCSprite spriteWithFile:@"P0-1_game-drawcolor_filebuttun.png"]; //瀏覽畫作
    tempObject.tag = tagNum++;
    tempObject.position = ccp(65+108*(tagNum-4), 65);
    tempObject.zOrder = 2;
    [self addChild:tempObject];
    [tapObjectArray addObject:tempObject];
    
    tempObject = [CCSprite spriteWithFile:@"P0-1_game-drawcolor_savebuttun.png"]; //存檔
    tempObject.tag = tagNum++;
    tempObject.position = ccp(65+108*(tagNum-4), 65);
    tempObject.zOrder = 2;
    [self addChild:tempObject];
    [tapObjectArray addObject:tempObject];
    
    tempObject = [CCSprite spriteWithFile:@"P0-1_game-drawcolor_eraserbuttun.png"]; //橡皮擦
    tempObject.tag = tagNum++;
    tempObject.position = ccp(948, 480);
    //tempObject.zOrder = 2;
    [self addChild:tempObject];
    [tapObjectArray addObject:tempObject];
    
    tempObject = [CCSprite spriteWithFile:@"P0-1_game-drawcolor_clearbuttun.png"]; //清空
    tempObject.tag = tagNum++;
    tempObject.position = ccp(948, 340);
    //tempObject.zOrder = 2;
    [self addChild:tempObject];
    [tapObjectArray addObject:tempObject];
    
    //色鉛筆們
    int cpenNum = 1;
    int gapX = 85;
    CGPoint firstPenPosition = ccp(380, 5);
    
    while (cpenNum < 9) {
        tempObject = [CCSprite spriteWithFile:[NSString stringWithFormat:@"P0-1_game-drawcolor_pen0%d.png",cpenNum++]]; //色鉛筆1
        tempObject.tag = tagNum++;
        tempObject.position = ccpAdd(firstPenPosition, ccp(gapX*(cpenNum-2), 0)) ;
        tempObject.zOrder = 2;
        [self addChild:tempObject];
        [tapObjectArray addObject:tempObject];
    }
    tapArray = tapObjectArray;
    
    //蠟筆顏色8個由左到右
    Colors[0] = ccc4(255, 0, 0, 255);       //red
    Colors[1] = ccc4(255, 128, 0, 255);     //orange
    Colors[2] = ccc4(255, 255, 0, 255);     //yellow
    Colors[3] = ccc4(0, 128, 0, 255);    //green
    Colors[4] = ccc4(0, 191, 255, 255);    //sky blue
    Colors[5] = ccc4(139, 0, 255, 255);     //violet
    Colors[6] = ccc4(255, 0, 255, 255);    //magneta
    Colors[7] = ccc4(0, 0, 255, 255);    //blue
    Colors[8] = ccc4(254, 254, 254, 255);    //white
    
    //加入著色的圖
    canvasImageNum = 7;
    [self addDrawCanvas:canvasImageNum];
}

-(void) addDrawCanvas:(int) canvasNum
{
        cavas = [NSArray arrayWithObjects:@"GAME_119car.png",
                 @"GAME_cementtrunk.png",
                 //@"GAME_helicopter.png",
                 @"GAME_jeep.png",
                 @"GAME_lect.png",
                 @"GAME_sailboat.png",
                 @"GAME_speedboat.png",
                 @"GAME_taxi.png",
                 @"GAME_train.png",
                 @"GAME_watercar.png",nil];
    
    CGSize s = [[CCDirector sharedDirector] winSize];
    NSString *imageName = [cavas objectAtIndex:canvasNum];
    UIImage * image = [UIImage imageNamed:imageName];
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
    sprite = [CCSpriteFloodFill spriteWithImage:image];
    
    [sprite setPosition:ccp(s.width * 0.5, s.height * 0.5)];
    sprite.tag = 50;
    [self addChild:sprite];
    [tapObjectArray addObject:sprite];
}

#pragma 手勢處理
-(void) handleTap:(UITapGestureRecognizer *)recognizer {
    if (touchEnable && (tapObjectArray.count > 0)) {
        //if (drawAble)
        //{
            //著色辨識
            ccColor4B pcolor = [sprite.mutableTexture pixelAt:[recognizer locationInView:recognizer.view]];
            CCLOG(@"A:%d R:%d G:%d B:%d",pcolor.a, pcolor.r, pcolor.g, pcolor.b);
            drawAble = NO;
            for (int i = 0; i < 9; i++) {
                if (ccc4FEqual(ccc4FFromccc4B(pcolor), ccc4FFromccc4B(Colors[i]))) {
                    NSLog(@"可以Draw");
                    drawAble = YES;
                    break;
                }
            }
        //}
        
        //cocos2d 物件
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
        [self tapSpriteMovement:touchLocation];
    }
}

-(void) tapSpriteMovement:(CGPoint)touchLocation
{
    for (CCSprite* obj in tapObjectArray) {
        if (CGRectContainsPoint(obj.boundingBox, touchLocation)) {
            NSLog(@"Tap! %d", obj.tag);
            switch (obj.tag) {
                case 3: //離開
                    [soundMgr playSoundFile:@"push.mp3"];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPageGameZone scene] backwards:YES]];
                    break;
                case 4: //瀏覽畫作
                    drawAble = NO;
                    [soundMgr playSoundFile:@"push.mp3"];
                    gallery = [[[DrawGallery alloc] init] autorelease];
                    gallery.zOrder = 3;
                    
                    //讀取檔案列表加入遊覽
                    fileMgr = [[[FileOps alloc] init] autorelease];
                    [gallery addObject:[fileMgr getDirList]];
                    tapObjectArray = gallery.tapArray;
                    
                    [self addChild:gallery];
                    break;
                case 5: //存檔
                    [soundMgr playSoundFile:@"push.mp3"];
                    fileMgr = [[[FileOps alloc] init] autorelease];
                    [fileMgr saveSpriteToPNG:(CCSprite*)[self getChildByTag:50]];
                    break;
                case 6: //橡皮擦
                    //[soundMgr playSoundFile:@"push.mp3"];
                    if(SelectedCrayon != -1)
                    {
                        [self getChildByTag:(SelectedCrayon + 8)].position = ccpSub([self getChildByTag:(SelectedCrayon + 8)].position, ccp(0,gapY));
                    }
                    SelectedCrayon = 8;
                    break;
                case 7: //清空，重新載圖
                    [soundMgr playSoundFile:@"push.mp3"];
                    [self addDrawCanvas:canvasImageNum];
                    break;
                case 50:
                    if (drawAble) {
                        if (SelectedCrayon!=-1) {
                            CCLOG(@"著色");
                            [self switchInteraction];
                            [sprite fillFromPoint:touchLocation withColor:Colors[SelectedCrayon]];
                            [self runAction:[CCSequence actionOne:[CCDelayTime actionWithDuration:0.5] two:[CCCallFunc actionWithTarget:self selector:@selector(switchInteraction)]]];
                        }
                    }
                    break;
                case 16: //gallery  關閉
                    [soundMgr playSoundFile:@"push.mp3"];
                    drawAble = YES;
                    [self removeChild:gallery cleanup:YES];
                    tapObjectArray = tapArray;
                    break;
                case 17: //showImage 返回
                    [soundMgr playSoundFile:@"push.mp3"];
                    [self removeChild:imageShow cleanup:YES];
                    tapObjectArray = gallery.tapArray;
                    break;
                case 18: //showImage 刪除圖片
                    [soundMgr playSoundFile:@"push.mp3"];
                    fileMgr = [[[FileOps alloc] init] autorelease];
                    [fileMgr deleteImage:gallery.selectedImageName];
                    [self removeChild:imageShow cleanup:YES];
                    
                    //讀取檔案列表加入遊覽
                    fileMgr = [[[FileOps alloc] init] autorelease];
                    gallery.zOrder = 3;
                    [gallery init];
                    [gallery addObject:[fileMgr getDirList]];
                    tapObjectArray = gallery.tapArray;
                    break;
                default:
                    break;
            }
            if (obj.tag < 16 & obj.tag > 7) {
                CCLOG(@"色鉛筆");
                if(SelectedCrayon != -1)
                {
                    [self getChildByTag:(SelectedCrayon + 8)].position = ccpSub([self getChildByTag:(SelectedCrayon + 8)].position, ccp(0,gapY));
                }
                SelectedCrayon = obj.tag - 8;
                obj.position = ccpAdd(obj.position, ccp(0, gapY));
                
                /*
                if (obj.tag == 10) {
                    [self switchInteraction];
                    [self runAction:[CCSequence actionOne:[CCDelayTime actionWithDuration:2.0f] two:[CCCallFunc actionWithTarget:self selector:@selector(switchInteraction)]]];
                }*/
                
            }
            //gallery 可點擊的圖片
            else if (obj.tag < 36 & obj.tag > 29)
            {
                fileMgr = [[[FileOps alloc] init] autorelease];
                gallery.selectedImageName = [[fileMgr getDirList] objectAtIndex:(obj.tag -30)];
                //NSLog(@"image name:%@",gallery.selectedImageName);
                
                imageShow = [[ShowImg alloc] initWithImage:gallery.selectedImageName];
                imageShow.zOrder = 4;
                [self addChild:imageShow];
                tapObjectArray = imageShow.tapArray;
            }
            break;
        }
    }
}

#pragma 離開處理
-(void) dealloc {
    
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
    
    [super dealloc];
}

#pragma 私有方法

@end
