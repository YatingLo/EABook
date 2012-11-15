//
//  EADraw.m
//  EABook
//
//  Created by Mac06 on 12/11/8.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EADraw.h"

#define BLACK ccc4(3, 3, 3, 255)
#define GRAY ccc4(129, 129, 129, 255)
#define CLEAR ccc4(0, 0, 0, 0)
#define WHITE ccc4(254, 254, 254, 255)
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
    tempObject.zOrder = 2;
    [self addChild:tempObject];
    [tapObjectArray addObject:tempObject];
    
    tempObject = [CCSprite spriteWithFile:@"P0-1_game-drawcolor_clearbuttun.png"]; //清空
    tempObject.tag = tagNum++;
    tempObject.position = ccp(948, 340);
    tempObject.zOrder = 2;
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
    
    //蠟筆顏色8個由左到右
    Colors[0] = ccc4(255, 0, 0, 255);       //red
    Colors[1] = ccc4(255, 128, 0, 255);     //orange
    Colors[2] = ccc4(255, 255, 0, 255);     //yellow
    Colors[3] = ccc4(0, 128, 0, 255);    //green
    Colors[4] = ccc4(0, 191, 255, 255);    //sky blue
    Colors[5] = ccc4(139, 0, 255, 255);     //violet
    Colors[6] = ccc4(255, 0, 255, 255);    //magneta
    Colors[7] = ccc4(0, 0, 255, 255);    //blue
    Colors[8] = ccc4(255, 255, 255, 255);    //white
    
    //加入著色的圖
    canvasImageNum = 7;
    [self addDrawCanvas:canvasImageNum];
    
    //加入array
    //[tapObjectArray addObject:image];
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
        //著色辨識
        ccColor4B pcolor = [sprite.mutableTexture pixelAt:[recognizer locationInView:recognizer.view]];
        //CCLOG(@"A:%d R:%d G:%d B:%d",pcolor.a, pcolor.r, pcolor.g, pcolor.b);
        drawAble = YES;
        if (ccc4FEqual(ccc4FFromccc4B(pcolor), ccc4FFromccc4B(BLACK))   ||
            ccc4FEqual(ccc4FFromccc4B(pcolor), ccc4FFromccc4B(GRAY))    ||
            ccc4FEqual(ccc4FFromccc4B(pcolor), ccc4FFromccc4B(CLEAR)))
        {
            drawAble = NO;
        }
    
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
                    //[soundMgr playSoundFile:@"push.mp3"];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPageGameZone scene] backwards:YES]];
                    break;
                case 4: //瀏覽畫作
                    //[soundMgr playSoundFile:@"push.mp3"];
                    break;
                case 5: //存檔
                    //[soundMgr playSoundFile:@"push.mp3"];
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
                    //[soundMgr playSoundFile:@"push.mp3"];
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
            break;
        }
    }
}

#pragma 離開處理
-(void) dealloc {
    
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
    //[delegate.navController.view removeGestureRecognizer:swipegestureRecognizerLeft];
    //[delegate.navController.view removeGestureRecognizer:swipegestureRecognizerRight];
    
    [super dealloc];
}

#pragma 私有方法

@end
