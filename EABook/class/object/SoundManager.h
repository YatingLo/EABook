//
//  SoundManager.h
//  EABook
//
//  Created by gdlab on 12/10/29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <AVFoundation/AVFoundation.h>

@interface SoundManager : CCNode {
    //BOOL isPlay;
    AVAudioPlayer *audioPlayer;
}

-(void) playLoopSound:(NSString*) soundName;
-(void) playSoundFile:(NSString*) soundName;
-(void) playWordSoundFile:(NSString*) soundName;
-(void) stopSound;
-(void) playSound;
-(void) PlayWordSound:(ccTime)dt;

@end
