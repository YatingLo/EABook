//
//  SoundSensor.h
//  EBook ClickAnimate
//
//  Created by Mac06 on 12/10/1.
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import "cocos2d.h"
#import "EAAnimSprite.h"
#import "SoundManager.h"

@interface SoundSensor : CCNode
{
    float soundLimit,lowPassResults;
    AVAudioRecorder *recorder;
    BOOL _enable;
    EAAnimSprite *sprite;
    //SoundManager *_sManage;
    
    NSMutableArray *_moveObjects;
}
@property (nonatomic, retain) EAAnimSprite *sprite;
@property (nonatomic, retain) SoundManager *sManage;
@property (nonatomic, retain) NSMutableArray *moveObjects;
@property BOOL enable;

-(id) init;
-(void) update;
-(void) updateSprite:(id)object;
//-(void) enableFlag;
-(void) stopDetect;
@end
