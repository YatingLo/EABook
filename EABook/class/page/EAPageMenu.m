//
//  EAPageMenu.m
//  EABook
//
//  Created by gdlab on 12/10/26.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAPageMenu.h"
#import "AppDelegate.h"


@implementation EAPageMenu
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	EAPageMenu *layer = [EAPageMenu node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

//
-(id) init
{
    if (self = [super init]) {
        tapObjectArray = [[NSMutableArray alloc] init];
        gamepoint = [[GamePoint alloc] init];
        
        if (gamepoint) {
            NSLog(@"%@", gamepoint.description);
        }
        
        delegate = (AppController*) [[UIApplication sharedApplication] delegate];
        tapgestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        tapgestureRecognizer.numberOfTapsRequired = 1; //new add
        [delegate.navController.view addGestureRecognizer:tapgestureRecognizer];
        
        //音量不能刪 刪了沒聲音
        soundDetect = [[SoundSensor alloc] init];
        [soundDetect stopDetect];
        
        //音效狀態設定
        if (!delegate.BookSoundState) {
            delegate.BookSoundState = [[SoundState alloc] init];
            
            NSMutableDictionary *configContent = [self readConfig];//讀取原本的設定
            
            [delegate.BookSoundState setSoundState:[[configContent objectForKey:KEY_WORD] boolValue]
                                            effect:[[configContent objectForKey:KEY_VOLUME] boolValue]];
        }
        NSLog(@"effect:%d word:%d",[delegate.BookSoundState getEffectState], [delegate.BookSoundState getWordState]);
        
        [self addChild:soundMgr];
        [self addObjects];
    }
    return self;
}

-(void) addObjects
{
    [self addBackGround:@"P0_Cover.jpg"];
    //載入圖片
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"P0.plist"];
    
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"P0.png"];
    [self addChild:spriteSheet];
    
    CCSprite *btnback;
    btnback= [CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"P0_start.png"]];
    
    [btnback setTag:0];
    [btnback setPosition:LOCATION(155 , 670)];
    [spriteSheet addChild:btnback];
    [tapObjectArray addObject:btnback];
    
    btnback = [[CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"P0_map.png"]] autorelease];
    [btnback setTag:1];
    [btnback setPosition:LOCATION(400 , 670)];
    [spriteSheet addChild:btnback];
    [tapObjectArray addObject:btnback];
    
    btnback = [[CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"P0_game.png"]] autorelease];
    [btnback setTag:2];
    [btnback setPosition:LOCATION(640 , 670)];
    [spriteSheet addChild:btnback];
    [tapObjectArray addObject:btnback];
    
    btnback = [[CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"P0_option.png"]] autorelease];
    [btnback setTag:3];
    [btnback setPosition:LOCATION(870 , 670)];
    [spriteSheet addChild:btnback];
    [tapObjectArray addObject:btnback];
}

#pragma 手勢處理
-(void) handleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    if (touchEnable) {
        [self tapSpriteMovement:touchLocation];
    }
}

-(void) tapSpriteMovement:(CGPoint)touchLocation
{
    //NSLog(@"Tap! %d", tapObjectArray.count);
    for (CCSprite* obj in tapObjectArray) {
        if (CGRectContainsPoint(obj.boundingBox, touchLocation)) {
            [soundMgr playSoundFile:@"push.mp3"];
            switch (obj.tag) {
                case 0:
                    NSLog(@"開始");
                    
                    delegate.EAGamePoint = gamepoint;
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPage1 scene]]];
                    break;
                case 1:
                    NSLog(@"地圖");
                    //[soundMgr playSoundFile:@"push.mp3"];
                    delegate.EAGamePoint = gamepoint;
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPageMap scene]]];
                    break;
                case 2:
                    NSLog(@"遊戲");
                    //[soundMgr playSoundFile:@"push.mp3"];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPageGameZone scene]]];
                    break;
                case 3:
                    NSLog(@"設定");
                    //[soundMgr playSoundFile:@"push.mp3"];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPageConfig scene]]];
                    break;
                default:
                    break;
            }
            break;
        }
    }
}

- (NSMutableDictionary*) readConfig
{
    NSMutableDictionary *temp;
    NSFileManager *fMgr = [[NSFileManager alloc] init];
    
    if ([fMgr fileExistsAtPath:HOME_PATH]) {
        temp = [[NSMutableDictionary alloc] initWithContentsOfFile:HOME_PATH];
        CCLOG(@"有設定檔:%@", temp.description);
    }
    else
    {
        CCLOG(@"未取得文件");
        NSArray *content = [[NSArray alloc] initWithObjects:[NSNumber numberWithBool:YES], [NSNumber numberWithBool:YES], nil];
        NSArray *keys = [[NSArray alloc] initWithObjects:KEY_WORD, KEY_VOLUME, nil];
        temp = [[NSMutableDictionary alloc] initWithObjects:content forKeys:keys];
        
        [temp writeToFile:HOME_PATH atomically:YES];
        [content release];
        [keys release];
    }
    
    //[fMgr release];
    return temp;
}

-(void) dealloc {
    [super dealloc];
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
}
@end
