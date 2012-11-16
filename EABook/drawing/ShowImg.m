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
    }
    return self;
}

-(void) addObject
{
    CGSize size = [[CCDirector sharedDirector] winSize];
}

-(void) dealloc
{
    [super dealloc];
}
@end
