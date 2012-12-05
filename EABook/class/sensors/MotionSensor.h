//
//  MotionSensor.h
//  EBook ClickAnimate
//
//  Created by Mac06 on 12/10/1.
//
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import "cocos2d.h"
#import "EAAnimSprite.h"
#import "SoundManager.h"

#define LIMIT 0.9

@interface MotionSensor : CCNode
{
    CMMotionManager *motionMgr;
    CMAccelerometerData *_acData;
    
    BOOL animAble;
    
    EAAnimSprite *sprite;
    EAAnimSprite *sprite2;
    SoundManager *sManage;
    
    NSMutableArray *moveObjects;
}

@property (nonatomic, retain) CMAccelerometerData *acData;
@property (nonatomic, retain) EAAnimSprite *sprite, *sprite2;
@property (nonatomic, retain) NSMutableArray *moveObjects;
@property (nonatomic, retain) SoundManager *sManage;

-(id) init;
-(void) update;
@end
