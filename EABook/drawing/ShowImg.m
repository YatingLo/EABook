//
//  ShowImg.m
//  EABook
//
//  Created by Mac06 on 12/11/16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ShowImg.h"


@implementation ShowImg
@synthesize tapArray;

- (id) init
{
    if (self = [super init]) {
        tapArray = [[NSMutableArray alloc] init];
        [self addObject];
    }
    return self;
}

- (id) initWithImage:(NSString*)imageName
{
    if (self = [super init]) {
        tapArray = [[NSMutableArray alloc] init];
        [self addObject];
        
        float scal = 0.5;
        CGSize size = [[CCDirector sharedDirector] winSize];
        tempObject = [CCSprite spriteWithFile:[HOME_PATH stringByAppendingString:[NSString stringWithFormat:@"/%@",imageName]]];
        tempObject.position = ccp(size.width*0.5, size.height*0.5);
        tempObject.scale = scal;
        [self addChild:tempObject];
    }
    return self;
}

-(void) addObject
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    tempObject = [CCSprite spriteWithFile:@"P0-1_game-drawcolor_fileshow.png"];
    tempObject.position = ccp(size.width*0.5, size.height*0.5);
    [self addChild:tempObject];
    
    //刪除
    tempObject = [[[CCSprite alloc] init] autorelease];
    tempObject.textureRect = CGRectMake(0, 0, 95, 95);
    tempObject.tag = 17;
    tempObject.position = ccp(228, 302);
    tempObject.visible = NO;
    [self addChild:tempObject];
    [tapArray addObject:tempObject];
    
    tempObject = [[[CCSprite alloc] init] autorelease];
    tempObject.textureRect = CGRectMake(0, 0, 95, 95);
    tempObject.tag = 18;
    tempObject.position = ccp(803, 302);
    tempObject.visible = NO;
    [self addChild:tempObject];
    [tapArray addObject:tempObject];
}

-(void) dealloc
{
    [super dealloc];
}
@end
