//
//  EAPage2.m
//  EABook
//
//  Created by gdlab on 12/10/27.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAPage2.h"
#import "EAPageMenu.h"

@implementation EAPage2

+(CCScene *) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	EAPage2 *layer = [EAPage2 node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
    if (self = [super init]) {
        
        tapObjectArray = [[NSMutableArray alloc] init];
        swipeObjectArray = [[NSMutableArray alloc] init];
        swipeDirection = UISwipeGestureRecognizerDirectionDown;
        gamepoint = delegate.EAGamePoint;
        [gamepoint addTypeA];
        NSLog(@"game point: %@", gamepoint.description);
        
        //手勢
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
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(soundMove) name:EVENT_SOUND object:soundDetect];
        
        //重力
        motionDetect = [[MotionSensor alloc] init];
        
        [self addChild:motionDetect];
        [self addChild:soundDetect];
        [self addChild:soundMgr];
        [self addObjects];
    }
    return self;
}

-(void) addObjects
{
    //加入背景，一定要先背景再載入sprite圖片的資源檔
    [self addBackGround:@"P2_Background.jpg"];
    
    //載入圖片
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"P2.plist"];
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"P2.png"];
    [self addChild:spriteSheet];
    
    //加入上下頁按鈕
    
    //加入互動物件
    windmil = [EAAnimSprite spriteWithName:@"P2_Windmill"];
    windmil.tag = 5;
    windmil.imgNum = 6;
    windmil.repeatTime = 2;
    [windmil setPosition:LOCATION(832, 190)];
    [self addChild:windmil];
    
    horse = [EAAnimSprite spriteWithName:@"P2_horse"];
    sheep.wordsoundName = @"P2_horse_word.mp3";
    sheep.soundName = @"P2_horse.mp3";
    horse.tag = 2;
    horse.imgNum = 7;
    horse.repeatTime = 2;
    [horse setPosition:LOCATION(775, 380)];
    [self addChild:horse];
    
    sheep = [EAAnimSprite spriteWithName:@"P2_sheep"];
    sheep.wordsoundName = @"P2_goat_word.mp3";
    sheep.soundName = @"P2_goat.mp3";
    sheep.tag = 3;
    sheep.imgNum = 2;
    sheep.repeatTime = 2;
    sheep.delayTime = 1.0f;
    [sheep setPosition:LOCATION(580, 625)];
    [self addChild:sheep];
    
    zibber = [EAAnimSprite spriteWithName:@"P2_zibber"];
    zibber.wordsoundName = @"P2_Zebra_word.mp3";
    zibber.soundName = @"P2_Zebra.mp3";
    zibber.tag = 4;
    zibber.imgNum = 5;
    zibber.repeatTime = 2;
    [zibber setPosition:LOCATION(150, 450)];
    [self addChild:zibber];
    
    [tapObjectArray addObject:zibber];
    [tapObjectArray addObject:sheep];
    [tapObjectArray addObject:horse];
    [swipeObjectArray addObject:zibber];
    [swipeObjectArray addObject:sheep];
    [swipeObjectArray addObject:horse];
    
    //聲音測試
    //[soundMgr playWordSoundFile:@"P3-1_owl_word.mp3"];
}

-(void) draw
{
    if (soundEnable) {
        [soundDetect update];
        [motionDetect update];
    }
}

-(void) handleTap:(UITapGestureRecognizer*) recognizer
{
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    if (touchEnable) {
        [self tapSpriteMovement:touchLocation];
    }
}

-(void) handleSwipe:(UISwipeGestureRecognizer *)recognizer
{
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    if (touchEnable) {
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
                    
                    break;
                case 1:
                    
                    break;
                case 2:
                    
                    break;
                case 3:

                    break;
                case 4:
                    
                    break;
                case 5:
                    
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
    //NSLog(@"list Direction %dl",swipeDirection);
    //NSLog(@"swipe Direction %d",direction);
    for (tempObject in swipeObjectArray) {
        if (CGRectContainsPoint(tempObject.boundingBox, touchLocation)) {
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
            }
        }
    }
}

-(void) dealloc {
    [super dealloc];
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
}
@end
