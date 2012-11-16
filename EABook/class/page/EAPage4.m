//
//  EAPage4.m
//  EABook
//
//  Created by Mac06 on 12/10/30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAPage4.h"


@implementation EAPage4
+(CCScene *) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	EAPage4 *layer = [EAPage4 node];
	
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
        
        [soundDetect stopDetect];
        
        [self addChild:soundMgr];
        [self addObjects];
    }
    return self;
}

-(void) addObjects
{
    //加入背景，一定要先背景再載入sprite圖片的資源檔
    [self addBackGround:@"P4_bug.jpg"];
    
    //載入圖片
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"P4.plist"];
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"P4.png"];
    [self addChild:spriteSheet];
    
    //加入互動物件
    NSString *tempName;
    
    tempName = @"P4_beetle";
    tempObject = [EAAnimSprite spriteWithName:tempName];
    //tempObject.soundName = [NSString stringWithFormat:@"%@.mp3",tempName];
    tempObject.wordimageName = [NSString stringWithFormat:@"%@_word.png",@"P4_rhinoceros"];
    tempObject.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    tempObject.tag = 3;
    tempObject.imgNum = 2;
    tempObject.delayTime = 0.2f;
    tempObject.repeatTime = 4;
    [tempObject setPosition:LOCATION(725, 400)];
    [self addChild:tempObject];
    
    tempName = @"P4_butterfly";
    tempObject = [EAAnimSprite spriteWithName:tempName];
    //tempObject.soundName = [NSString stringWithFormat:@"%@.mp3",tempName];
    tempObject.wordimageName = [NSString stringWithFormat:@"%@_word.png",tempName];
    tempObject.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    tempObject.tag = 4;
    tempObject.imgNum = 2;
    tempObject.delayTime = 0.1f;
    tempObject.repeatTime = 4;
    [tempObject setPosition:LOCATION(125, 200)];
    [self addChild:tempObject];
    
    tempName = @"P4_ladybug";
    tempObject = [EAAnimSprite spriteWithName:tempName];
    //tempObject.soundName = [NSString stringWithFormat:@"%@.mp3",tempName];
    tempObject.wordimageName = [NSString stringWithFormat:@"%@_word.png",tempName];
    tempObject.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    tempObject.tag = 5;
    tempObject.imgNum = 2;
    tempObject.delayTime = 0.1f;
    tempObject.repeatTime = 4;
    [tempObject setPosition:LOCATION(125, 575)];
    [self addChild:tempObject];
    
    //加入上下頁按鈕
    [self addPre];
    [self addNext];
    
    //加入array
    [tapObjectArray addObject:[self getChildByTag:0]];
    [tapObjectArray addObject:[self getChildByTag:1]];
    [tapObjectArray addObject:[self getChildByTag:5]];
    [tapObjectArray addObject:[self getChildByTag:4]];
    [tapObjectArray addObject:[self getChildByTag:3]];
    
    [swipeObjectArray addObject:[self getChildByTag:3]];
    [swipeObjectArray addObject:[self getChildByTag:4]];
    [swipeObjectArray addObject:[self getChildByTag:5]];

    //soundDetect.sprite = windmil;
    
}

#pragma mark 手勢
-(void) handleTap:(UITapGestureRecognizer*) recognizer
{
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    if (touchEnable && tapObjectArray) {
        [self tapSpriteMovement:touchLocation];
    }
}

-(void) handleSwipe:(UISwipeGestureRecognizer *)recognizer
{
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    if (touchEnable && swipeObjectArray) {
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
                    [soundMgr playSoundFile:@"push.mp3"];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPage3_1 scene] backwards:YES]];
                    break;
                case 1:
                    //下一頁
                    [soundMgr playSoundFile:@"push.mp3"];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPageGame2 scene]]];
                    break;
                case 3:
                case 4:
                case 5:
                case 6:
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
            [tempObject startAnimation];
            //[soundMgr playSoundFile:tempObject.soundName];
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
