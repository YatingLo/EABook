//
//  DrawGallery.m
//  EABook
//
//  Created by Mac06 on 12/11/16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "DrawGallery.h"


@implementation DrawGallery
@synthesize tapArray;

- (id) init
{
    if (self = [super init]) {
        tapArray = [[NSMutableArray alloc] init];
        [self addObject];
    }
    return self;
}

-(void) addObject
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    //背景
    tempObject = [CCSprite spriteWithFile:@"P0-1_game-drawcolor_filesdetail.png"];
    tempObject.position = ccp(size.width*0.5, size.height*0.5);
    [self addChild:tempObject];
    //關閉btn
    tempObject = [[[CCSprite alloc] init] autorelease];
    [tempObject setTextureRect:CGRectMake(0, 0, 100, 100)];
    [tempObject setPosition:ccp(945, 605)];
    [tempObject setTag:16];
    tempObject.visible = NO;
    [self addChild:tempObject];
    [tapArray addObject:tempObject];
    //方格View
    CGRect ImageSize = CGRectMake(0, 0, 240, 155);
    int gapX = 282;
    int gapY = 180;
    int startX = 107 + ImageSize.size.width * 0.5;
    int startYUp = 569 - ImageSize.size.height * 0.5;
    int startYDown = 569 - gapY;
    
    int i = 0;
    while (i < 3) {
        imagePosition[i] = ccp(startX + gapX*i, startYUp);
        imagePosition[(i+3)] = ccp(startX + gapX*i, startYDown);
        i++;
    }
    
    for (int i = 0; i<6; i++) {
        CCLOG(@"image %d 的位置 Ｘ:%f, Y:%f", i,imagePosition[i].x,imagePosition[i].y);
    }
}

-(void) dealloc
{
    [super dealloc];
}
@end
