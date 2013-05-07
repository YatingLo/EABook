//
//  EAPage3-2.m
//  EABook
//
//  Created by Mac06 on 12/10/30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAPage3-2.h"


@implementation EAPage3_2
+(CCScene *) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	EAPage3_2 *layer = [EAPage3_2 node];
	
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
        swipeObjectArray = [[NSMutableArray alloc] init];
        moveObjectArray = [[NSMutableArray alloc] init];
        
        //手勢
        //pangestureRecognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)] autorelease];
        //[delegate.navController.view addGestureRecognizer:pangestureRecognizer];
        
        delegate = (AppController*) [[UIApplication sharedApplication] delegate];
        tapgestureRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)] autorelease];
        tapgestureRecognizer.numberOfTapsRequired = 1; //new add
        [delegate.navController.view addGestureRecognizer:tapgestureRecognizer];
        
        swipegestureRecognizerRight = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)]autorelease];
        [swipegestureRecognizerRight setDirection:UISwipeGestureRecognizerDirectionRight];
        
        swipegestureRecognizerLeft = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)]autorelease];
        [swipegestureRecognizerLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
        
        [delegate.navController.view addGestureRecognizer:swipegestureRecognizerRight];
        [delegate.navController.view addGestureRecognizer:swipegestureRecognizerLeft];
        
        //音量
        soundDetect = [[SoundSensor alloc] init];
        soundDetect.sManage = soundMgr;
        [self addChild:soundDetect];
        
        //重力
        //motionDetect = [[MotionSensor alloc] init];
        //motionDetect.sManage = soundMgr;
        //[self addChild:motionDetect];
        
        [self addChild:soundMgr];
        [self addObjects];
    }
    return self;
}

-(void) addObjects
{
    //加入背景，一定要先背景再載入sprite圖片的資源檔
    [self addBackGround:@"P3-2_greenplace.jpg"];
    
    //載入圖片
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"P3-2.plist"];
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"P3-2.png"];
    [self addChild:spriteSheet];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"P3-2_lion.plist"];
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"P3-2_lion.png"];
    [self addChild:spriteSheet];
    
    //加入互動物件
    NSString *tempName;
    
    tempName = @"P3-2_grass";//草五株
    tempObject = [EASoundDectectSprite spriteWithName:tempName];//5
    //tempObject.tag = 5;
    tempObject.imgNum = 2;
    tempObject.delayTime = 0.2f;
    tempObject.repeatTime = 3;
    [tempObject setPosition:LOCATION(300, 240)];
    [self addChild:tempObject];
    [moveObjectArray addObject:tempObject];
    
    tempObject = [EASoundDectectSprite spriteWithName:tempName];//4
    //tempObject.tag = 5;
    //tempObject.scale = 1.2f;
    tempObject.imgNum = 2;
    tempObject.delayTime = 0.25f;
    tempObject.repeatTime = 3;
    [tempObject setPosition:LOCATION(590, 280)];
    [self addChild:tempObject];
    [moveObjectArray addObject:tempObject];
    
    tempObject = [EASoundDectectSprite spriteWithName:tempName];//3
    //tempObject.tag = 5;
    //tempObject.scale = 1.2f;
    tempObject.imgNum = 2;
    tempObject.delayTime = 0.3f;
    tempObject.repeatTime = 3;
    [tempObject setPosition:LOCATION(100, 350)];
    [self addChild:tempObject];
    [moveObjectArray addObject:tempObject];
    
    tempObject = [EASoundDectectSprite spriteWithName:tempName];//2
    //tempObject.tag = 5;
    tempObject.scale = 1.2f;
    tempObject.imgNum = 2;
    tempObject.delayTime = 0.2f;
    tempObject.repeatTime = 3;
    [tempObject setPosition:LOCATION(250, 600)];
    [self addChild:tempObject];
    [moveObjectArray addObject:tempObject];
    
    tempObject = [EASoundDectectSprite spriteWithName:tempName];//1
    //tempObject.tag = 5;
    tempObject.scale = 1.2f;
    tempObject.imgNum = 2;
    tempObject.delayTime = 0.3f;
    tempObject.repeatTime = 3;
    [tempObject setPosition:LOCATION(150, 650)];
    [self addChild:tempObject];
    [moveObjectArray addObject:tempObject];
    
    tempName = @"P3-2_tree";//樹兩棵
    tempObject = [EASoundDectectSprite spriteWithName:tempName];
    tempObject.imgNum = 4;
    tempObject.delayTime = 0.5f;
    //tempObject.repeatTime = 2;
    [tempObject setPosition:LOCATION(260, 180)];
    [self addChild:tempObject];
    [moveObjectArray addObject:tempObject];
    
    tempObject = [EASoundDectectSprite spriteWithName:tempName];
    tempObject.imgNum = 4;
    tempObject.delayTime = 0.8f;
    //tempObject.repeatTime = 2;
    [tempObject setFlipX:YES];
    [tempObject setPosition:LOCATION(640, 220)];
    [self addChild:tempObject];
    [moveObjectArray addObject:tempObject];
    soundDetect.moveObjects = moveObjectArray;
    
    tempName = @"P3-2_water";
    tempObject = [EAAnimSprite spriteWithName:tempName];
    tempObject.tag = 7;
    tempObject.imgNum = 4;
    tempObject.delayTime = 0.2f;
    tempObject.repeatTime = 6;
    [tempObject setPosition:LOCATION(530, 670)];
    [self addChild:tempObject];
    
    //動物們～～
    tempName = @"P3-2_elephant";
    tempObject = [EAAnimSprite spriteWithName:tempName];
    tempObject.soundName = [NSString stringWithFormat:@"%@.mp3",tempName];
    tempObject.wordimageName = [NSString stringWithFormat:@"%@_word.png",tempName];
    tempObject.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    tempObject.tag = 3;
    tempObject.imgNum = 3;
    tempObject.delayTime = 0.2f;
    tempObject.repeatTime = 6;
    [tempObject setPosition:LOCATION(640, 560)];
    [self addChild:tempObject];
    
    tempName = @"P3-2_giraffe";
    tempObject = [EAAnimSprite spriteWithName:tempName];
    tempObject.soundName = [NSString stringWithFormat:@"%@.mp3",tempName];
    tempObject.wordimageName = [NSString stringWithFormat:@"%@_word.png",tempName];
    tempObject.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    tempObject.tag = 4;
    tempObject.imgNum = 4;
    tempObject.delayTime = 0.2f;
    tempObject.repeatTime = 4;
    [tempObject setPosition:LOCATION(445, 260)];
    [self addChild:tempObject];
    
    tempName = @"P3-2_lion";
    tempObject = [EAAnimSprite spriteWithName:tempName];
    tempObject.soundName = [NSString stringWithFormat:@"%@.mp3",tempName];
    tempObject.wordimageName = [NSString stringWithFormat:@"%@_word.png",tempName];
    tempObject.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    tempObject.tag = 5;
    tempObject.imgNum = 2;
    tempObject.delayTime = 0.2f;
    tempObject.repeatTime = 2;
    [tempObject setPosition:ccp(245, 295)];
    [self addChild:tempObject];
    
    //加入上下頁按鈕
    [self addPre];
    [self addNext];
    
    //加入array
    [tapObjectArray addObject:[self getChildByTag:0]];
    [tapObjectArray addObject:[self getChildByTag:1]];
    [tapObjectArray addObject:[self getChildByTag:4]];
    [tapObjectArray addObject:[self getChildByTag:3]];
    [tapObjectArray addObject:[self getChildByTag:5]];
    
    [swipeObjectArray addObject:[self getChildByTag:5]];
    [swipeObjectArray addObject:[self getChildByTag:4]];
    [swipeObjectArray addObject:[self getChildByTag:3]];
    
    //soundDetect.sprite = (EAAnimSprite*)[self getChildByTag:3];
}

-(void) draw
{
    if (_soundEnable) {
        [soundDetect update];
    }
}

#pragma mark 手勢
-(void) handleTap:(UITapGestureRecognizer*) recognizer
{
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    if (_tapEnable) {
        [self tapSpriteMovement:touchLocation];
    }
}

-(void) handleSwipe:(UISwipeGestureRecognizer *)recognizer
{
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    if (_swipeEnable) {
        [self swipeSpriteMovement:touchLocation direction:recognizer.direction];
    }
}

-(void) tapSpriteMovement:(CGPoint)touchLocation
{
    NSLog(@"tap");
    for (tempObject in tapObjectArray) {
        if (CGRectContainsPoint(tempObject.boundingBox, touchLocation)) {
            NSLog(@"btn tag:%d",tempObject.tag);
            switch (tempObject.tag) {
                case 0:
                    //上一頁
                    [soundMgr playSoundFile:SOUND_PNEXT];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPage2 scene] backwards:YES]];
                    break;
                case 1:
                    //下一頁
                    [soundMgr playSoundFile:SOUND_PNEXT];
                    //[[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPage4 scene]]];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipAngular transitionWithDuration:TURN_DELAY scene:[EAPageGame1 scene]]];
                    break;
                case 2://Word image 的叉叉
                    [soundMgr stopSound];
                    [self removeWordImage];
                    break;
                case 3:
                case 4:
                case 5:
                    [self addWordImage:tempObject.wordimageName];
                    [soundMgr playWordSoundFile:tempObject.wordsoundName];
                    break;
                default:
                    break;
            }
            break;
        }
    }
}

-(void) swipeSpriteMovement:(CGPoint)touchLocation direction:(UISwipeGestureRecognizerDirection) direction
{
    NSLog(@"swipe");
    for (tempObject in swipeObjectArray) {
        if (CGRectContainsPoint(tempObject.boundingBox, touchLocation)) {
            if (!tempObject.isTouch) {
                [soundMgr playSoundFile:tempObject.soundName];
            }
            [tempObject startAnimation];
            if (tempObject.tag == 3) {
                tempObject = (EAAnimSprite*)[self getChildByTag:7];
                [tempObject startAnimation];
            }
            /*swipe 來回兩次
             //當前一次與本次同一物件進入
             if (tempObject == touchedSprite) {
             //當前一次與本次方向不同時進入
             if (swipeDirection != direction) {
             NSLog(@"swipe twice");
             touchedSprite = Nil;
             //動畫播放
             [tempObject startAnimation];
             }
             else
             {
             swipeDirection = direction;
             }
             }
             else
             {
             touchedSprite = tempObject;
             swipeDirection = direction;
             }*/
        }
    }
}

-(void) dealloc {
    
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
    [delegate.navController.view removeGestureRecognizer:swipegestureRecognizerLeft];
    [delegate.navController.view removeGestureRecognizer:swipegestureRecognizerRight];
    
    [super dealloc];
}
@end
