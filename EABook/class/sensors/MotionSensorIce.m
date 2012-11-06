//
//  MotionSensorEgg.m
//  EABook
//
//  Created by Mac06 on 12/10/31.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "MotionSensorIce.h"


@implementation MotionSensorIce

-(void) update
{
    if ([motionMgr isAccelerometerActive]) {
        _acData = motionMgr.accelerometerData;
        if (fabsf(_acData.acceleration.y) > LIMIT || fabs(_acData.acceleration.x) > LIMIT )
        {
            if (sprite) {
                if (animAble) {
                    [self runAction:[CCCallFunc actionWithTarget:parent_ selector:@selector(switchTouchInteraction)]];
                    [sprite startLoopAnimation];
                    animAble = !animAble;
                    if (sprite.soundName && sManage) {
                        [sManage playLoopSound:sprite.soundName];
                    }
                }
                if (sprite.position.x > 30 && sprite.position.x < 1000 && sprite.position.y > 30 && sprite.position.y < 730) {
                    [sprite setPosition:CGPointMake((sprite.position.x + _acData.acceleration.y*10), sprite.position.y)];
                    if (sprite2) {
                        [sprite2 setPosition:CGPointMake((sprite2.position.x + _acData.acceleration.y*10), sprite2.position.y)];
                    }
                }
                else
                {
                    if (sprite.position.x <= 30) {
                        [sprite setPosition:CGPointMake((sprite.position.x+3), sprite.position.y)];
                        [sprite2 setPosition:CGPointMake((sprite2.position.x+3), sprite2.position.y)];
                    }
                    else if (sprite.position.x >= 1000)
                    {
                        [sprite setPosition:CGPointMake((sprite.position.x-3), sprite.position.y)];
                        [sprite2 setPosition:CGPointMake((sprite2.position.x-3), sprite2.position.y)];
                    }
                }
            }
        }
        else
        {
            if (sprite) {
                if (!animAble) {
                    [sprite firstFram];
                    [self runAction:[CCCallFunc actionWithTarget:parent_ selector:@selector(switchTouchInteraction)]];
                    animAble = !animAble;
                    //[sprite stopAllActions];
                    if (sprite.soundName && sManage) {
                        [sManage stopSound];
                    }
                }
            }
        }
        NSLog(@"Accelerometer\n----------\nx:%+.2f\ny:%+.2f\nz:%+.2f",_acData.acceleration.x, _acData.acceleration.y, _acData.acceleration.z);
    }
}

@end
