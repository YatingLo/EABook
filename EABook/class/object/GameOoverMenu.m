//
//  GameOoverMenu.m
//  EABook
//
//  Created by Mac06 on 12/11/2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameOoverMenu.h"


@implementation GameOoverMenu
-(id) init
{
    if (self = [super init])
    {
        CGSize size = [[CCDirector sharedDirector] winSize];
        CCSprite *tempSprite = [CCSprite spriteWithFile:@"P0-2_game_end.png"]; //background
        [tempSprite setPosition:ccp(size.width/2, size.height/2)];
        [self addChild:tempSprite];
    }
    return self;
}

-(void) addThreeObject
{
    tapArray = [[CCArray alloc] init];
    
    int num = 20;
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *button = [CCSprite spriteWithFile:@"P0-2_game_next.png"]; //下一關
    [button setPosition:ccp(210, size.height/2 - num)];
    [button setTag:23];
    [self addChild:button];
    [tapArray insertObject:button atIndex:0];
    
    button = [CCSprite spriteWithFile:@"P0-2_game_again.png"]; //再一次
    [button setPosition:ccp(size.width/2, size.height/2 - num)];
    [button setTag:24];
    [self addChild:button];
    [tapArray insertObject:button atIndex:0];
    
    button = [CCSprite spriteWithFile:@"P0-2_game_exit.png"]; //離開
    [button setPosition:ccp(820, size.height/2 - num)];
    [button setTag:25];
    [self addChild:button];
    [tapArray insertObject:button atIndex:0];
    
}

-(void) addTwoObject
{
    tapArray = [[CCArray alloc] init];
    
    int num = 20;
    int numX = 200;
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *button = [CCSprite spriteWithFile:@"P0-2_game_next.png"]; //下一關
    [button setPosition:ccp(size.width/2 - numX, size.height/2 - num)];
    [button setTag:23];
    [self addChild:button];
    [tapArray insertObject:button atIndex:0];
    
    button = [CCSprite spriteWithFile:@"P0-2_game_exit.png"]; //離開
    [button setPosition:ccp(size.width/2 + numX, size.height/2 - num)];
    [button setTag:25];
    [self addChild:button];
    [tapArray insertObject:button atIndex:0];
}

-(void) dealloc
{
    [super dealloc];
}
@end
