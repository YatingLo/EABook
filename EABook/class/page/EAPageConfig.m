//
//  EAPageConfig.m
//  EABook
//
//  Created by gdlab on 12/10/27.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAPageConfig.h"
#import "EAPageMenu.h"

CCSpriteBatchNode *spriteSheet;

@implementation EAPageConfig
@synthesize configContent;

+ (BOOL) getVolumeState
{
    NSDictionary *tempDic = [[NSDictionary alloc] initWithContentsOfFile:HOME_PATH];
    BOOL state = [[tempDic objectForKey:KEY_VOLUME] boolValue];
    [tempDic release];
    return state;
}

+ (BOOL) getWordState
{
    NSDictionary *tempDic = [[NSDictionary alloc] initWithContentsOfFile:HOME_PATH];
    BOOL state = [[tempDic objectForKey:KEY_WORD] boolValue];
    [tempDic release];
    return state;
}

+(CCScene *) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	EAPageConfig *layer = [EAPageConfig node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
    if (self = [super init])
    {
        touchEnable = NO;
        
        tapObjectArray = [[NSMutableArray alloc] init];
        configContent = [self readConfig];//讀取原本的設定
        if (configContent) {
            NSLog(@"有設定檔");
        }
        
        delegate = (AppController*) [[UIApplication sharedApplication] delegate];
        tapgestureRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)] autorelease];
        tapgestureRecognizer.numberOfTapsRequired = 1; //new add
        [delegate.navController.view addGestureRecognizer:tapgestureRecognizer];
        
        [self addObjects];
    }
    return self;
}

-(void) addObjects
{
    [self addBackGround:@"P0-3_Option.jpg"];
    
    CCSprite *backBtn = [[CCSprite alloc] init];
    [backBtn setTextureRect: CGRectMake(0, 0, 200, 200)];
    [backBtn setPosition:ccp(50, 50)];
    [backBtn setTag:0];
    [backBtn setOpacity:0];
    [self addChild:backBtn];
    [tapObjectArray addObject:backBtn];
    [backBtn release];
    
    bool state = [[configContent objectForKey:KEY_VOLUME] boolValue];
    
     spriteSheet = [CCSpriteBatchNode
     batchNodeWithFile:@"P0-3_circle.png"];
     [self addChild:spriteSheet];
     
    CCSprite *volumeOn = [CCSprite spriteWithFile:@"P0-3_circle.png"];
    [volumeOn setPosition:LOCATION(630, 540)];
    [volumeOn setTag:1];
    volumeOn.visible = state;
    //[self addChild:volumeOn];
    [spriteSheet addChild:volumeOn];
    [tapObjectArray addObject:volumeOn];
    [volumeOn release];
    
    CCSprite *volumeOff = [[CCSprite alloc] initWithFile:@"P0-3_circle.png"];
    [volumeOff setPosition:LOCATION(810, 540)];
    [volumeOff setTag:2];
    volumeOff.visible = !state;
    //[self addChild:volumeOff];
    [spriteSheet addChild:volumeOff];
    [tapObjectArray addObject:volumeOff];
    [volumeOff release];
    
    state = [[configContent objectForKey:KEY_WORD] boolValue];
    
    CCSprite *wordOn = [[CCSprite alloc] initWithFile:@"P0-3_circle.png"];
    [wordOn setPosition:LOCATION(630, 400)];
    [wordOn setTag:3];
    wordOn.visible = state;
    //[self addChild:wordOn];
    [spriteSheet addChild:wordOn];
    [tapObjectArray addObject:wordOn];
    [wordOn release];
    
    CCSprite *wordOff = [[CCSprite alloc] initWithFile:@"P0-3_circle.png"];
    [wordOff setPosition:LOCATION(810, 400)];
    [wordOff setTag:4];
    wordOff.visible = !state;
    //[self addChild:wordOff];
    [spriteSheet addChild:wordOff];
    [tapObjectArray addObject:wordOff];
    [wordOff release];
}

#pragma 手勢處理
-(void) handleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    if (touchEnable) {
        [self tapSpriteMovement:touchLocation];
    }
    NSLog(@"tap");
}

-(void) tapSpriteMovement:(CGPoint)touchLocation
{
    NSLog(@"tap");
    
    for (CCSprite *tapObject in tapObjectArray) {
        if (CGRectContainsPoint(tapObject.boundingBox, touchLocation)) {
            NSLog(@"show config panel");
            NSLog(@"btn tag:%d",tapObject.tag);
            [soundMgr playSoundFile:@"push.mp3"];
            switch (tapObject.tag) {
                case 0:
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPageMenu scene] backwards:YES]];
                    break;
                case 1:
                case 2:
                    [self switchVolume];
                    break;
                case 3:
                case 4:
                    [self switchWord];
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


- (void) switchVolume
{
    if (configContent) {
        
        
        bool state = [[configContent objectForKey:KEY_VOLUME] boolValue];
        //bool state = YES;
        CCSprite *on = (CCSprite*)[spriteSheet getChildByTag:1];
        CCSprite *off = (CCSprite*)[spriteSheet getChildByTag:2];
        
        state = !state;
        NSLog(@"有東西%@", configContent);
        on.visible = state;
        off.visible = !state;
        [configContent setObject:[NSNumber numberWithBool:state] forKey:KEY_VOLUME];
        
    }
}

- (void) switchWord
{
    if (configContent) {
        
        
        bool state = [[configContent objectForKey:KEY_WORD] boolValue];
        //bool state = YES;
        
        CCSprite *on = (CCSprite*)[spriteSheet getChildByTag:3];
        CCSprite *off = (CCSprite*)[spriteSheet getChildByTag:4];
        
        state = !state;
        NSLog(@"有東西%@", configContent);
        on.visible = state;
        off.visible = !state;
        [configContent setObject:[NSNumber numberWithBool:state] forKey:KEY_WORD];
        
    }
}

-(void) onExit {
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
    [configContent writeToFile:HOME_PATH atomically:YES];
}
@end
