//
//  EAPageGameDiffer.m
//  EABook
//
//  Created by Mac06 on 12/11/2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAPageGameDiffer.h"


@implementation EAPageGameDiffer
+(CCScene *) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	EAPageGameDiffer *layer = [EAPageGameDiffer node];
	
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
    [self addBackGround:@"P0-2_game-different.jpg"];
    
    //加入按鈕
    tempObject = [CCSprite spriteWithFile:@"P0-2_game-who_return-buttun.png"];
    [tempObject setTag:20];
    [tempObject setPosition:ccp(80, 75)];
    [self addChild:tempObject];
    [tapObjectArray insertObject:tempObject atIndex:0];
    
    //加入array
    [tapObjectArray addObject:[self getChildByTag:20]];
}

#pragma 手勢處理
-(void) handleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    if (touchEnable && (tapObjectArray.count > 0)) {
        [self tapSpriteMovement:touchLocation];
    }
}

-(void) tapSpriteMovement:(CGPoint)touchLocation
{
    NSLog(@"Tap! %d", tapObjectArray.count);
    for (CCSprite* obj in tapObjectArray) {
        if (CGRectContainsPoint(obj.boundingBox, touchLocation)) {
            switch (obj.tag) {
                case 20:
                    [soundMgr playSoundFile:@"push.mp3"];
                    //delegate.EAGamePoint = gamepoint;
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPageGameZone scene] backwards:YES]];
                    break;
                case 1:
                    [soundMgr playSoundFile:@"push.mp3"];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPageMenu scene]]];
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
