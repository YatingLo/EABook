//
//  EALayer.m
//  EbookAnimal
//
//  Created by Mac06 on 12/10/25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EALayer.h"

@implementation EALayer
@synthesize gamepoint;
//@synthesize tapObjectArray, swipeObjectArray;

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if (self=[super init])
    {
        delegate = (AppController*) [[UIApplication sharedApplication] delegate];// new add
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];//清掉沒有用到的frames
        gamepoint = delegate.EAGamePoint;
        
        //[gamepoint addTypeB];
        NSLog(@"gamePoint %@", [gamepoint goToPage]);
        
        _soundEnable = NO;
        _panEnable = NO;
        _swipeEnable = NO;
        _tapEnable = NO;
        
        [self runAction:[CCSequence actionOne:[CCDelayTime actionWithDuration:1.5f] two:[CCCallFunc actionWithTarget:self selector:@selector(moveAtBegin)]]];//打開互動鎖
        
        soundMgr = [[SoundManager alloc] init];
        soundMgr.switchDelegate = self;
        
        NSLog(@"Layer");
	}
	return self;
}

-(void) moveAtBegin
{
    [self switchInteraction:ALL];
}

-(void) switchInteraction:(int)type
{
    switch (type) {
        case TAP:
            NSLog(@"switchInteraction:tap");
            _tapEnable = !_tapEnable;
            break;
        case SWIPE:
            NSLog(@"switchInteraction:swipe");
            _swipeEnable = !_swipeEnable;
            break;
        case PAN:
            NSLog(@"switchInteraction:pan");
            _panEnable = !_panEnable;
            break;
        case SOUND:
            NSLog(@"switchInteraction:sound");
            _soundEnable = !_soundEnable;
            break;
        default:
            NSLog(@"switchInteraction:ALL");
            _tapEnable = !_tapEnable;
            _swipeEnable = !_swipeEnable;
            _panEnable = !_panEnable;
            _soundEnable = !_soundEnable;
        break;
    }
}

-(void) switchInteractionElse:(int) type
{
    NSLog(@"switch ELSE");
    switch (type) {
        case TAP:
            NSLog(@"switchInteractionElse:tap");
            _panEnable = !_panEnable;
            _swipeEnable = !_swipeEnable;
            _soundEnable = !_soundEnable;
            break;
        case SWIPE:
            NSLog(@"switchInteractionElse:swipe");
            _tapEnable = !_tapEnable;
            _panEnable = !_panEnable;
            _soundEnable = !_soundEnable;
            break;
        case PAN:
            NSLog(@"switchInteractionElse:pan");
            _tapEnable = !_tapEnable;
            _swipeEnable = !_swipeEnable;
            _soundEnable = !_soundEnable;
            break;
        case SOUND:
            NSLog(@"switchInteractionElse:sound");
            _tapEnable = !_tapEnable;
            _swipeEnable = !_swipeEnable;
            _panEnable = !_panEnable;
            break;
        default:
            break;
    }
}

-(void) stopSpriteMove
{
    NSLog(@"EALayer stopSpriteMove");
    //[self switchInteraction];
    [soundMgr stopSound];
}

//來回swipe動作
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

-(void) addWordImage:(NSString*)imageName music:(NSString*)musicName
{
    [soundMgr stopSound];
    
    WordImageNode = [[CCNode alloc] init];
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *tt = [CCSprite spriteWithFile:imageName];
    tt.position = ccp(size.width/2, size.height/2);
    
    CCSprite *spCloseButton = [[CCSprite spriteWithFile:@"closewordbutton.png"] retain];
    spCloseButton.position = ccpSub(tt.position, ccp(tt.textureRect.size.width/2-5, -tt.textureRect.size.height/2+5));
    spCloseButton.tag = 2;
    [WordImageNode addChild:tt];
    
    if (musicName) {
        MusicButton = [[MusicBtnSprite alloc]init];
        //MusicButton = [[CCSprite spriteWithFile:@"closewordbutton.png"] retain];
        MusicButton.position = ccpSub(tt.position, ccp(-tt.textureRect.size.width/2+5, -tt.textureRect.size.height/2+5));
        MusicButton.tag = 20;
        //[MusicButton setTextureRect:CGRectMake(0, 0, 70, 70)];
        [WordImageNode addChild:MusicButton];
    }
    
    [WordImageNode addChild:spCloseButton];
    
    if (WordImageNode.children.count > 1) {
        [self addChild:WordImageNode];
        tapButtons = tapObjectArray;
        tapObjectArray = [[NSMutableArray alloc] init];
        [tapObjectArray addObject:spCloseButton];
        if (musicName) {
            NSLog(@"%@",MusicButton.description);
            [tapObjectArray addObject:MusicButton];
            
            //[self schedule:@selector(checkMusicPlay:) interval:0.5];
        }
    }    else
        NSLog(@"Word Image 創建不成功");
}

-(void) checkMusicPlay:(ccTime)dt{
    NSLog(@"music is play %d",soundMgr.musicPlayer.isPlaying);
    if (soundMgr.musicPlayer && soundMgr.musicPlayer.isPlaying) {
        [MusicButton startCircle];
    }
    else if (soundMgr.musicPlayer && !soundMgr.musicPlayer.isPlaying){
        [MusicButton stopCircle];
        [self unschedule:@selector(checkMusicPlay:)];
    }
}

//等待實作！！
-(void) addWordImage:(NSString*)imageName
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *tt = [CCSprite spriteWithFile:imageName];
    tt.position = ccp(size.width/2, size.height/2);
    
    CCSprite *spCloseButton = [[CCSprite spriteWithFile:@"closewordbutton.png"] retain];
    spCloseButton.position = ccpSub(tt.position, ccp(tt.textureRect.size.width/2-5, -tt.textureRect.size.height/2+5));
    spCloseButton.tag = 2;
    
    WordImageNode = [[CCNode alloc] init];
    [WordImageNode addChild:tt];
    [WordImageNode addChild:spCloseButton];
    
    if (WordImageNode.children.count == 2) {
        [self addChild:WordImageNode];
        tapButtons = tapObjectArray;
        
        tapObjectArray = [[NSMutableArray alloc] init];
        [tapObjectArray addObject:spCloseButton];
    }
    else
        NSLog(@"Word Image 創建不成功");
}
-(void) removeWordImage
{
    if (WordImageNode != NULL)
    {
        if(soundMgr.musicPlayer.isPlaying)
        {
            [soundMgr.musicPlayer stop];
        }
        
        [self removeChild:WordImageNode cleanup:YES];
        WordImageNode = NULL;
        [tapObjectArray dealloc];
        tapObjectArray = tapButtons;
        [self switchInteractionElse:TAP];
    }
}
-(void) addPre
{
    tempObject = [EAAnimSprite spriteWithFile:@"pushbutton_left.png"];
    tempObject.soundName = @"push.mp3";
    tempObject.tag = 0;
    tempObject.position = LOCATION(60, 60);
    [self addChild:tempObject];
}
-(void) addNext
{
    tempObject = [EAAnimSprite spriteWithFile:@"pushbutton_right.png"];
    tempObject.soundName = @"push.mp3";
    tempObject.tag = 1;
    tempObject.position = LOCATION(964, 60);
    [self addChild:tempObject];
}
-(void) addReturn
{
    tempObject = [EAAnimSprite spriteWithFile:@"pushbutton_return.png"];
    tempObject.soundName = @"push.mp3";
    tempObject.tag = 20;
    tempObject.position = ccp(60, 70);
    [self addChild:tempObject];
}

-(void) addBackGround:(NSString*)imageName
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    CCSprite *backGround = [CCSprite spriteWithFile:imageName];
    backGround.position = ccp(size.width/2, size.height/2);
    [self addChild:backGround];
}

-(void) onExitTransitionDidStart
{
    delegate.EAGamePoint = gamepoint;
    _tapEnable = NO;
    _swipeEnable = NO;
    _panEnable = NO;
    [self stopAllActions];
    //[self stopSpriteMove];
}

-(void) onExit//
{
    [self stopSpriteMove];
    if (soundDetect) {
        [soundDetect stopDetect];
        soundDetect = Nil;
    }
}

-(void) dealloc
{
    NSLog(@"EALayer dealloc");
    [self stopSpriteMove];
    [super dealloc];
    gamepoint = Nil;
    tempObject = Nil;
    tapObjectArray = Nil;
    swipeObjectArray = Nil;
    moveObjectArray = Nil;
    if (soundDetect) {
        [soundDetect stopDetect];
        soundDetect = Nil;
    }
}

@end
