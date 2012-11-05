//
//  EAUpDownSprite.m
//  EABook
//
//  Created by Mac06 on 12/10/31.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAUpDownSprite.h"


@implementation EAUpDownSprite

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
    
    /*
    CCMoveBy *moveBy1 = [CCMoveBy actionWithDuration:0.5 position:ccp(0, 20)];//向上
    CCMoveBy *moveBy2 = [CCMoveBy actionWithDuration:0.5 position:ccp(0, -20)];//向下
    CCEaseInOut *ease1 = [CCEaseInOut actionWithAction:moveBy1 rate:0.5];//逆时针时摆动时先匀加速再匀减速运动
    CCEaseInOut *ease2 = [CCEaseInOut actionWithAction:moveBy2 rate:0.5];//顺时针时摆动时先匀加速再匀减速运动
    CCSequence *seq1 = [CCSequence actions:ease1, ease2, nil];//将两个摆动合成为一个动画
    */
    CCAnimate *action = [CCAnimate actionWithAnimation:pAnim];
    [self runAction:[CCSequence actions:
                     [CCDelayTime actionWithDuration:0.1f],
                     [CCRepeat actionWithAction:action times:repeatTime],
                     stopSound , NULL]];
}

-(void) startLoopAnimation
{
    
    NSLog(@"start animation");
    //CCCallFunc *switchIneraction = [CCCallFunc actionWithTarget:parent_ selector:@selector(switchInteraction)];
    CCCallFunc *stopSound = [CCCallFunc actionWithTarget:parent_ selector:@selector(stopSpriteMove)];
    
    //[self runAction:switchIneraction];
    
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
    
    CCMoveBy *moveBy1 = [CCMoveBy actionWithDuration:0.5 position:ccp(0, 20)];//向上
    CCMoveBy *moveBy2 = [CCMoveBy actionWithDuration:0.5 position:ccp(0, -20)];//向下
    CCEaseInOut *ease1 = [CCEaseInOut actionWithAction:moveBy1 rate:0.5];//逆时针时摆动时先匀加速再匀减速运动
    CCEaseInOut *ease2 = [CCEaseInOut actionWithAction:moveBy2 rate:0.5];//顺时针时摆动时先匀加速再匀减速运动
    CCSequence *seq1 = [CCSequence actions:ease1, ease2, nil];//将两个摆动合成为一个动画
    
    CCAnimate *action = [CCAnimate actionWithAnimation:pAnim];
    [self runAction:[CCSequence actions:
                     [CCDelayTime actionWithDuration:0.1f],
                     [CCRepeat actionWithAction:[CCSpawn actionOne:action two:seq1] times:2],
                     stopSound , NULL]];
    /*
    NSLog(@"loop anim");
    
    CCAnimation *pAnim = [CCAnimation animation];
    for(unsigned int i = 1; i < imgNum; i++)
    {
        NSString *name = [NSString stringWithFormat:@"%@_%d.png",imageName,i];
        [pAnim addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:name]];
    }
    [pAnim setDelayPerUnit:delayTime];
    
    CCMoveBy *moveBy1 = [CCMoveBy actionWithDuration:0.5 position:ccp(0, 20)];//向上
    CCMoveBy *moveBy2 = [CCMoveBy actionWithDuration:0.5 position:ccp(0, -20)];//向下
    CCEaseInOut *ease1 = [CCEaseInOut actionWithAction:moveBy1 rate:0.5];//逆时针时摆动时先匀加速再匀减速运动
    CCEaseInOut *ease2 = [CCEaseInOut actionWithAction:moveBy2 rate:0.5];//顺时针时摆动时先匀加速再匀减速运动
    CCSequence *seq1 = [CCSequence actions:ease1, ease2, nil];//将两个摆动合成为一个动画
    
    [self runAction:[CCRepeat actionWithAction:[CCSpawn actionOne:[CCAnimate actionWithAnimation:pAnim] two:seq1] times:2]];*/
}

@end
