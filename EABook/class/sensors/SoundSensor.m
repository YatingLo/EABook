//
//  SoundSensor.m
//  EBook ClickAnimate
//
//  Created by Mac06 on 12/10/1.
//
//

#import "SoundSensor.h"

@implementation SoundSensor
@synthesize sprite;
@synthesize sManage;
@synthesize enable;

-(id) init
{
    if (self = [super init]) {
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        
        NSError *error;
        NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
        NSDictionary *settings = [NSDictionary
                                  dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithFloat:4100.0],
                                  AVSampleRateKey,
                                  [NSNumber numberWithInt:kAudioFormatAppleLossless],
                                  AVFormatIDKey,
                                  [NSNumber numberWithInt:1],
                                  AVNumberOfChannelsKey,
                                  [NSNumber numberWithInt:AVAudioQualityMax],
                                  AVEncoderAudioQualityKey,
                                  nil];
        recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
        if (recorder) {
            recorder.meteringEnabled = YES;
            [recorder record];
            //levelTimer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(audioLevelTimerCallback:) userInfo:nil repeats:YES];
            _enable = YES;
        } else {
            NSLog(@"ERROR:%@",[error description]);
        }
    }
    return self;
}

//檢查吹氣狀態
- (void)audioLevelTimerCallback:(NSTimer *) timer {
    _enable = YES;
#if 0
    [recorder updateMeters];
    double peakPowerForChannel = pow(10, 0.05*[recorder peakPowerForChannel:0]);
    lowPass = 0.05 * peakPowerForChannel + (1-0.05)*lowPass;
    //NSLog(@"%@",[NSString stringWithFormat:@"peakPower:%f\nLowPass:%f",lowPass, peakPowerForChannel]);
    if (lowPass>0.75) {
        _enable = !_enable;
        [self rotateObjectToAngle:(lowPass-0.05)/(1-0.05)];
    }
#endif
}

-(void) rotateObjectToAngle:(double) angle{
    [self runAction:[CCCallFunc actionWithTarget:parent_ selector:@selector(switchTouchInteraction)]];
    NSLog(@"sound animation start");
    for (sprite in _moveObjects) {
        [sprite startLoopAnimation];
        if (sprite.soundName && sManage) {
            [sManage playSoundFile:sprite.soundName];
        }
    }
}

-(void) update
{
    [recorder updateMeters];
    double peakPowerForChannel = pow(10, 0.05*[recorder peakPowerForChannel:0]);
    lowPass = 0.05 * peakPowerForChannel + (1-0.05)*lowPass;
    //NSLog(@"%@",[NSString stringWithFormat:@"peakPower:%f\nLowPass:%f",lowPass, peakPowerForChannel]);
    if (lowPass>0.75 && _enable == YES) {
        _enable = !_enable;
        levelTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(audioLevelTimerCallback:) userInfo:nil repeats:NO];
        [self rotateObjectToAngle:(lowPass-0.05)/(1-0.05)];
    }
    
#if 0
    //NSLog(@"sound update");
    [recorder updateMeters];
    
	//const double ALPHA = 0.05;
	double peakPowerForChannel = pow(10, (0.05 * [recorder peakPowerForChannel:0]));
    double avgPoserForChannel = pow(10, (0.05 * [recorder averagePowerForChannel:0]));
    double differ = peakPowerForChannel - avgPoserForChannel;
    
    //NSLog(@"Sound power: %f", peakPowerForChannel);
    //NSLog(@"Sound avg: %f", avgPoserForChannel);
	//NSLog(@"Sound differ: %f", differ);
    
    //Log 聲音內容
    //NSLog(@"Average input: %f Peak input: %f", [recorder averagePowerForChannel:0], [recorder peakPowerForChannel:0]);
    //NSLog(@"Average input: %f Peak input: %f", avgPoserForChannel, peakPowerForChannel);
    //NSLog(@"Differ: %f", differ);
    //NSLog(@"Average input: %d Peak input: %d", avgPoserForChannel, peakPowerForChannel);
    //if ((lowPassResults > soundLimit) & enable){
    /*
    if (differ > LIMIT_DIFFER) {
        //NSLog(@"soundEventSend");
        enable = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_SOUND object:self];
    }*/
    
    if (differ > LIMIT_DIFFER) {
        NSLog(@"soundEventSend");
        if (_enable) {
            _enable = !_enable;
            [self runAction:[CCCallFunc actionWithTarget:parent_ selector:@selector(switchTouchInteraction)]];
            NSLog(@"sound animation start");
            for (sprite in _moveObjects) {
                [sprite startLoopAnimation];
                if (sprite.soundName && sManage) {
                    [sManage playSoundFile:sprite.soundName];
                }
            }
        }
    }
    /*
    else{
        if (!enable)
        {
            
            [self runAction:[CCCallFunc actionWithTarget:parent_ selector:@selector(switchTouchInteraction)]];
            NSLog(@"sound animation end");
            for (sprite in _moveObjects) {
                [sprite stopAllActions];
                if (sprite.soundName && sManage) {
                    [sManage stopSound];
                }
            }
            
        }
    }
     */
#endif
}

-(void) dealloc
{
    [super dealloc];
    recorder = nil;
}

-(void) stopDetect
{
    recorder.meteringEnabled = NO;
    [recorder stop];
}

-(void) enableFlag
{
    _enable = YES;
}
@end
