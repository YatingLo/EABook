//
//  MotionSensor.m
//  EBook ClickAnimate
//
//  Created by Mac06 on 12/10/1.
//
//

#import "MotionSensor.h"


@implementation MotionSensor
@synthesize sprite, sprite2;
@synthesize moveObjects;
@synthesize sManage;
@synthesize switchDelegate;

-(id) init
{
    if (self = [super init]) {
        animAble = YES;
        motionMgr = [[CMMotionManager alloc] init];
        
        if (motionMgr.isDeviceMotionAvailable) {
            motionMgr.accelerometerUpdateInterval = 1.0/10.0;
            [motionMgr startAccelerometerUpdates];
            if (![motionMgr isAccelerometerActive])
            {
                printf("accelerometer is hot active");
            }
        }
        else
        {
            NSLog(@"Thise device has no accelerometer.");
        }
    }
    return self;
}

-(void) update
{
    if ([motionMgr isAccelerometerActive]) {
        _acData = motionMgr.accelerometerData;
        if (fabsf(_acData.acceleration.y) > LIMIT || fabs(_acData.acceleration.x) > LIMIT )
        {
            int i = 1;
            
            if (animAble) {
                //[self runAction:[CCCallFunc actionWithTarget:parent_ selector:@selector(switchTouchInteraction)]];
                animAble = !animAble;
                for (sprite in moveObjects) {
                    [sprite startLoopAnimation];
                }
            }
            for (sprite in moveObjects)
            {
                if (sprite.position.x > 30 && sprite.position.x < 1000 && sprite.position.y > 30 && sprite.position.y < 730) {
                    [sprite setPosition:CGPointMake((sprite.position.x + _acData.acceleration.y*2*i), (sprite.position.y - _acData.acceleration.x*3*i))];
                    sprite.rotation += _acData.acceleration.y*10;
                    i++;
                }
                else
                {
                    if (sprite.position.x < 30) {
                        [sprite setPosition:CGPointMake(31, sprite.position.y)];
                    }
                    else if (sprite.position.x > 1000)
                    {
                        [sprite setPosition:CGPointMake(999, sprite.position.y)];
                    }
                    else if (sprite.position.y > 730)
                    {
                        [sprite setPosition:CGPointMake(sprite.position.x, 729)];
                    }
                    else if (sprite.position.y < 30)
                    {
                        [sprite setPosition:CGPointMake(sprite.position.x, 31)];
                    }
                }
            }
        }
        else
        {
            
            if (!animAble) {
                animAble = !animAble;
                for (sprite in moveObjects) {
                    [sprite stopAllActions];
                }
            }
        }
        //NSLog(@"Accelerometer\n----------\nx:%+.2f\ny:%+.2f\nz:%+.2f",_acData.acceleration.x, _acData.acceleration.y, _acData.acceleration.z);
    }
}

-(void) dealloc
{
    [motionMgr dealloc];
    [super dealloc];
}
@end
