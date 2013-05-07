//
//  EAPageGameZone.m
//  EABook
//
//  Created by Mac06 on 12/11/2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAPageGameZone.h"


@implementation EAPageGameZone
+(CCScene *) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	EAPageGameZone *layer = [EAPageGameZone node];
	
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
        
        [self addChild:soundMgr];
        [self addObjects];
    }
    return self;
}

-(void) addObjects
{
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"GameWho" fontName:@"Marker Felt" fontSize:64];
    // ask director for the window size
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    // position the label on the center of the screen
    label.position =  ccp( size.width /2 , size.height/2 );
    [self addChild:label];
    
    
    [self addBackGround:@"P0-2_Game.jpg"];
    
    NSLog(@"Tap! %d", tapObjectArray.count);
    
    tempObject= [CCSprite spriteWithFile:@"P0-2_game_different.jpg"];
    [tempObject setTag:3];
    [tempObject setPosition:LOCATION(93 + tempObject.boundingBox.size.width/2 + 20, 313 - tempObject.boundingBox.size.height/2 - 14)];
    [self addChild:tempObject];
    [tapObjectArray addObject:tempObject];
    
    tempObject = [CCSprite spriteWithFile:@"P0-2_game_who.jpg"];
    [tempObject setTag:4];
    [tempObject setPosition:LOCATION(534 + tempObject.boundingBox.size.width/2 + 22, 315 - tempObject.boundingBox.size.height/2 - 14)];
    [self addChild:tempObject];
    [tapObjectArray addObject:tempObject];
    
    //加入上下頁按鈕
    [self addReturn];
    
    //加入array
    [tapObjectArray addObject:[self getChildByTag:20]];
}

#pragma 手勢處理
-(void) handleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    if (_tapEnable && (tapObjectArray.count > 0)) {
        [self tapSpriteMovement:touchLocation];
    }
}

-(void) tapSpriteMovement:(CGPoint)touchLocation
{
    NSLog(@"Tap! %d", tapObjectArray.count);
    for (CCSprite* obj in tapObjectArray) {
        if (CGRectContainsPoint(obj.boundingBox, touchLocation)) {
            switch (obj.tag) {
                case 20: //回到menu
                    [soundMgr playSoundFile:@"push.mp3"];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeTR transitionWithDuration:TURN_DELAY scene:[EAPageMenu scene]]];
                    break;
                case 3: //differ
                    [soundMgr playSoundFile:SOUND_MCLICK];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipAngular transitionWithDuration:TURN_DELAY scene:[EAPageGameDiffer scene]]];
                    break;
                case 4: //who
                    [soundMgr playSoundFile:SOUND_MCLICK];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipAngular transitionWithDuration:TURN_DELAY scene:[EAPageGameWho scene]]];
                    break;
                default:
                    break;
            }
            break;
        }
    }
}

-(void) dealloc {
    
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
    //[delegate.navController.view removeGestureRecognizer:swipegestureRecognizerLeft];
    //[delegate.navController.view removeGestureRecognizer:swipegestureRecognizerRight];
    
    [super dealloc];
}

@end
