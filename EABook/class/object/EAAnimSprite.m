//
//  EAAnimSprite.m
//  EbookAnimal
//
//  Created by gdlab on 12/10/26.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAAnimSprite.h"


@implementation EAAnimSprite
@synthesize imageName, soundName, wordimageName, wordsoundName;
@synthesize imgNum, repeatTime;
@synthesize delayTime;

+ (id)spriteWithName:(NSString*)name
{
    EAAnimSprite *sprite = [[[self alloc] initWithName:name] autorelease];
    return sprite;
}
- (id)initWithName:(NSString*)name
{
    imageName = name;
    animImageFrames = [NSMutableArray array];
    repeatTime = 1;
    NSString *fullImagName;
    
    fullImagName = [NSString stringWithFormat:@"%@_%d.png",name,0];
    NSLog(@"fileName-------%@",fullImagName);
    if (self = [self initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:fullImagName]]) {
        imgNum = 0;
        delayTime = 0.3f;
        soundName = nil;
        wordimageName = Nil;
        wordsoundName = Nil;
    }
    return self;
}

-(void) firstFram
{
    NSString *fullImagName = [NSString stringWithFormat:@"%@_%d.png",imageName,0];
    [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:fullImagName]];
}

-(void) startAnimation
{
    NSLog(@"start animation");
    CCCallFunc *switchIneraction = [CCCallFunc actionWithTarget:parent_ selector:@selector(switchInteraction)];
    CCCallFunc *stopSound = [CCCallFunc actionWithTarget:parent_ selector:@selector(stopSpriteMove)];
    
    [self runAction:switchIneraction];
    
    CCAnimation *pAnim = [CCAnimation animation];
    if (imgNum < 3) {
        for(unsigned int i = 1; i < imgNum; i++)
        {
            NSString *name = [NSString stringWithFormat:@"%@_%d.png",imageName,i];
            [pAnim addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:name]];
        }
        NSString *name = [NSString stringWithFormat:@"%@_%d.png",imageName,0];
        [pAnim addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:name]];
    }
    else
    {
        for(unsigned int i = 1; i < imgNum; i++)
        {
            NSString *name = [NSString stringWithFormat:@"%@_%d.png",imageName,i];
            [pAnim addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:name]];
        }
    }
    [pAnim setDelayPerUnit:delayTime];
    pAnim.restoreOriginalFrame = YES;
    
    CCAnimate *action = [CCAnimate actionWithAnimation:pAnim];
    [self runAction:[CCSequence actions:
                    [CCDelayTime actionWithDuration:0.1f],
                    [CCRepeat actionWithAction:action times:repeatTime],
                    stopSound , NULL]];
}
    
-(void) startLoopAnimation
{
    NSLog(@"Loop Animation Start");
    CCAnimation *pAnim = [CCAnimation animation];
    if (imgNum < 3) {
        for(unsigned int i = 1; i < imgNum; i++)
        {
            NSString *name = [NSString stringWithFormat:@"%@_%d.png",imageName,i];
            [pAnim addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:name]];
        }
        NSString *name = [NSString stringWithFormat:@"%@_%d.png",imageName,0];
        [pAnim addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:name]];
    }
    else
    {
        for(unsigned int i = 1; i < imgNum; i++)
        {
            NSString *name = [NSString stringWithFormat:@"%@_%d.png",imageName,i];
            [pAnim addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:name]];
        }
    }
    [pAnim setDelayPerUnit:delayTime];
    
    CCCallFunc *stopSound = [CCCallFunc actionWithTarget:parent_ selector:@selector(stopSpriteMove)];
    CCAnimate *action = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:pAnim] times:2];
    //[self runAction:action];
    [self runAction:[CCSequence actions:
                     [CCDelayTime actionWithDuration:0.1f],
                     [CCRepeat actionWithAction:action times:repeatTime],
                     stopSound , NULL]];
}

@end
