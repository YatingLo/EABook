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

-(id) init
{
    if (self = [super init]) {
        soundLimit = 0.06f;
        _enable = YES;
        _moveObjects = [[NSMutableArray alloc] init];
        NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
        
        
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        
        NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithFloat: 44100.0],                 AVSampleRateKey,
                                  [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                                  [NSNumber numberWithInt: 1],                         AVNumberOfChannelsKey,
                                  [NSNumber numberWithInt: AVAudioQualityLow],         AVEncoderAudioQualityKey,
                                  nil];
        
        NSError *error;
        
        recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
        
        if (recorder) {
            [recorder prepareToRecord];
            recorder.meteringEnabled = YES;
            [recorder record];

        } else
            NSLog(@"%@",[error description]);
    }
    return self;
}

-(void) update
{
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
            [self runAction:[CCCallFunc actionWithTarget:parent_ selector:@selector(switchInteraction)]];
            _enable = !_enable;
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
