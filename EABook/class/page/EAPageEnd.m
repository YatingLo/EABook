//
//  EAPageEnd.m
//  EABook
//
//  Created by gdlab on 12/10/31.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAPageEnd.h"
#import "EALayer.h"
#import "EAPageMenu.h"

@implementation EAPageEnd
+(CCScene *) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	EAPageEnd *layer = [EAPageEnd node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
    if (self = [super init]) {
        gamepoint = delegate.EAGamePoint;
        
        delegate = (AppController*) [[UIApplication sharedApplication] delegate];
        tapgestureRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)] autorelease];
        tapgestureRecognizer.numberOfTapsRequired = 1; //new add
        [delegate.navController.view addGestureRecognizer:tapgestureRecognizer];
        
        [soundDetect stopDetect];
        
        [self addChild:soundMgr];
        [self addObjects];
    }
    return self;
}

-(void) addObjects
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    int endNum;
    
    if (gamepoint)
        endNum = [gamepoint goToPageNum];
    else
        endNum = 1;
    
    tempObject = [CCSprite spriteWithFile:[NSString stringWithFormat:@"P5_Ending%d.jpg",endNum]];
    tempObject.position = ccp(size.width * 0.5, size.height * 0.5);
    [self addChild:tempObject];
    [soundMgr playSoundFile:[NSString stringWithFormat:@"P5_end%d_word.mp3",endNum]];
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
    NSLog(@"tap");
    [soundMgr playSoundFile:@"push.mp3"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPageMenu scene] backwards:YES]];
}

-(void) dealloc {
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
    
    [super dealloc];
}
@end
