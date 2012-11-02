//
//  EALayerGame.m
//  EABook
//
//  Created by Mac06 on 12/11/2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EALayerGame.h"
#import "EALayer.h"

@implementation EALayerGame
-(id) init
{
    if (self = [super init])
    {
        CCSprite *progressBackGround = [CCSprite spriteWithFile:@"P0-2_game-different_time-bar1.png"];
        [progressBackGround setPosition:ccp(512, 690)];
        [progressBackGround setZOrder:1];
        [self addChild:progressBackGround];
        
        CCSprite *progressBarSprite = [CCSprite spriteWithFile:@"P0-2_game-different_time-bar2.png"];
        progressBar = [CCProgressTimer progressWithSprite:progressBarSprite];
        [progressBar setPosition:ccp(564, 687)];
        [progressBar setType:kCCProgressTimerTypeBar];
        [progressBar setMidpoint:ccp(0, 0)];
        [progressBar setBarChangeRate:ccp(1, 0)];
        [progressBar setPercentage:0];
        [progressBar setZOrder:2];
        [self addChild:progressBar];
    }
    return self;
}
-(void) exitGame
{
    
}
-(void) dealloc
{
    [super dealloc];
}
@end
