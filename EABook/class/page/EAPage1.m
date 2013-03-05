//
//  EAPage1.m
//  EABook
//
//  Created by gdlab on 12/10/27.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAPage1.h"

@implementation EAPage1
+(CCScene *) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	EAPage1 *layer = [EAPage1 node];
	
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
        moveObjectArray = [[[NSMutableArray alloc] init] retain];
        
        eggEnable = YES;
        
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
        /*
        swipegestureRecognizerUp = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)]autorelease];
        [swipegestureRecognizerLeft setDirection:UISwipeGestureRecognizerDirectionUp];
        
        swipegestureRecognizerDown = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)]autorelease];
        [swipegestureRecognizerLeft setDirection:UISwipeGestureRecognizerDirectionDown];
        
        [delegate.navController.view addGestureRecognizer:swipegestureRecognizerUp];
        [delegate.navController.view addGestureRecognizer:swipegestureRecognizerDown];
         */
        [delegate.navController.view addGestureRecognizer:swipegestureRecognizerRight];
        [delegate.navController.view addGestureRecognizer:swipegestureRecognizerLeft];
        
        //音量
        if (soundDetect)
        {
            [soundDetect stopDetect];
        }
        
        //重力
        motionDetect = [[MotionSensor alloc] init];
        motionDetect.sManage = soundMgr;
        [self addChild:motionDetect];
        
        [self addChild:soundMgr];
        [self addObjects];
    }
    return self;
}

-(void) addObjects
{
    //加入背景，一定要先背景再載入sprite圖片的資源檔
    [self addBackGround:@"P1_Background.jpg"];
    
    //載入圖片
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"P1.plist"];
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"P1.png"];
    [self addChild:spriteSheet];
    
    //加入上下頁按鈕
    [self addPre];
    [self addNext];
    
    //加入互動物件
    NSString *tempName;
    
    tempName = @"P1_cow";
    cow = [EAAnimSprite spriteWithName:tempName];
    cow.soundName = [NSString stringWithFormat:@"%@.mp3",tempName];
    cow.wordimageName = [NSString stringWithFormat:@"%@_EN&CH.jpg",tempName];
    cow.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    cow.tag = 4;
    cow.imgNum = 7;
    cow.delayTime = 0.1f;
    cow.repeatTime = 3;
    [cow setPosition:LOCATION(250, 350)];
    [self addChild:cow];
    
    tempName = @"P1_pig";
    pig = [EAAnimSprite spriteWithName:tempName];
    pig.soundName = [NSString stringWithFormat:@"%@.mp3",tempName];
    pig.wordimageName = [NSString stringWithFormat:@"%@_EN&CH.jpg",tempName];
    pig.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    pig.wordmusicName = @"pig.mp3";
    pig.tag = 5;
    pig.imgNum = 4;
    pig.repeatTime = 3;
    pig.delayTime = 0.2f;
    [pig setPosition:LOCATION(830, 250)];
    [self addChild:pig];
    
    tempName = @"P1_chicken";
    chicken = [EAAnimSprite node];
    [chicken setTextureRect:CGRectMake(0, 0, 130, 130)];
    chicken.soundName = [NSString stringWithFormat:@"%@.mp3",tempName];
    chicken.wordimageName = [NSString stringWithFormat:@"%@_EN&CH.jpg",tempName];
    chicken.wordsoundName = [NSString stringWithFormat:@"%@_word.mp3",tempName];
    chicken.wordmusicName = @"eagle_chick.mp3";
    chicken.tag = 3;
    chicken.visible = NO;
    [chicken setPosition:LOCATION(450, 640)];
    [self addChild:chicken];
    
    tempName = @"P1_egg";
    
    egg = [EAAnimSprite spriteWithName:tempName];
    egg.tag = 6;
    egg.imgNum = 6;
    egg.delayTime = 0.5f;
    egg.visible = YES;
    [egg setPosition:LOCATION(750, 570)];
    [egg setRotation:-15];
    
    [tapObjectArray addObject:[self getChildByTag:0]];
    [tapObjectArray addObject:[self getChildByTag:1]];
    [tapObjectArray addObject: chicken];
    [tapObjectArray addObject: pig];
    [tapObjectArray addObject: cow];
    
    [swipeObjectArray addObject: chicken];
    [swipeObjectArray addObject: cow];
    [swipeObjectArray addObject: pig];
}

-(void) draw
{
    if (_soundEnable && moveObjectArray.count > 0) {
        [motionDetect update];
    }
}

#pragma 手勢區
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
    NSLog(@"swipe");
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    if (_swipeEnable) {
        [self swipeSpriteMovement:touchLocation direction:recognizer.direction];
    }
}
#pragma mark 手勢
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
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPageMenu scene] backwards:YES]];
                    break;
                case 1:
                    //下一頁
                    [soundMgr playSoundFile:SOUND_PNEXT];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPage2 scene]]];
                    break;
                case 2://Word image 的叉叉
                    [soundMgr stopSound];
                    [self removeWordImage];
                    [self switchInteractionElse:NULL data:TAP];
                    break;
                case 6: //蛋tap消失
                    [tapObjectArray removeObject:tempObject];
                    [moveObjectArray removeObject:tempObject];
                    [self removeChild:tempObject cleanup:NO];
                    motionDetect.moveObjects = moveObjectArray;
                    break;
                case 3:
                case 4:
                case 5:
                    if (tempObject.wordmusicName) {
                        [self addWordImage:tempObject.wordimageName music:tempObject.wordmusicName];
                        wordMusicName = tempObject.wordmusicName;
                    }
                    else
                    {
                        [self addWordImage:tempObject.wordimageName];
                    }
                    [soundMgr playWordSoundFile:tempObject.wordsoundName];
                    break;
                case 20:
                    //停掉字卡語音，如果沒有在播音樂的話播放音樂
                    [soundMgr stopSound];
                    if (soundMgr.musicPlayer.isPlaying) {
                        [soundMgr.musicPlayer stop];
                    }
                    else
                    {
                        [self schedule:@selector(checkMusicPlay:) interval:0.5];
                        [soundMgr playMusicFile:wordMusicName];
                    }
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
    CGRect temp = tempObject.boundingBox;
    for (tempObject in swipeObjectArray) {
        
        if (tempObject.tag == 3) {
            temp.origin.x = tempObject.boundingBox.origin.x - 100;
            temp.origin.y = tempObject.boundingBox.origin.y;
            temp.size.width = tempObject.boundingBox.size.width + 200;
            temp.size.height = tempObject.boundingBox.size.height;
        }
        else
        {
            temp.origin.x = tempObject.boundingBox.origin.x - 50;
            temp.size.width = tempObject.boundingBox.size.width + 100;
            temp.origin.y = tempObject.boundingBox.origin.y;
            temp.size.height = tempObject.boundingBox.size.height;
        }
        
        if (CGRectContainsPoint(temp, touchLocation)) {
            [soundMgr playSoundFile:tempObject.soundName];
            if (tempObject.tag == 3) {
                if (moveObjectArray.count < 5) {
                    [gamepoint addTypeA];
                    
                    NSString *tempName = @"P1_egg";
                    egg = [EAAnimSprite spriteWithName:tempName];
                    egg.tag = 6;
                    egg.imgNum = 6;
                    egg.delayTime = 0.5f;
                    egg.visible = YES;
                    [egg setPosition:LOCATION(750, 570)];
                    [egg setRotation:-15];
                    [moveObjectArray addObject:egg];
                    [tapObjectArray insertObject:egg atIndex:0];
                    [self addChild:egg];
                    
                    motionDetect.moveObjects = moveObjectArray;
                    CCRotateTo *rotate = [CCRotateTo actionWithDuration:0.1 angle:480 + 100 * moveObjectArray.count];
                    CCMoveTo *move = [CCMoveTo actionWithDuration:0.1 position:ccp(600+50 * motionDetect.moveObjects.count, 200)];
                    [egg runAction:[CCSpawn actions:rotate, move, nil]];
                }
            }
            else
            {
                switch (tempObject.tag) {
                    case 4:
                        [gamepoint addTypeB];
                        break;
                    case 5:
                        [gamepoint addTypeC];
                        break;
                    default:
                        break;
                }
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
    [super dealloc];
    
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
    [delegate.navController.view removeGestureRecognizer:swipegestureRecognizerLeft];
    [delegate.navController.view removeGestureRecognizer:swipegestureRecognizerRight];
    //[delegate.navController.view removeGestureRecognizer:swipegestureRecognizerUp];
    //[delegate.navController.view removeGestureRecognizer:swipegestureRecognizerDown];
    tempObject = nil;
}
@end
