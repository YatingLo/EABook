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
#import "AppDelegate.h"
#import "EALayerProtocol.h"

@interface SoundManager : CCNode {
    //BOOL isPlay;
    AVAudioPlayer *audioPlayer;
    AVAudioPlayer *timePlayer;
    AppController *delegate;
    //兒歌增加
    AVAudioPlayer *musicPlayer;
}

@property (nonatomic,retain)AVAudioPlayer *musicPlayer;
@property (nonatomic, assign) id switchDelegate;

-(void) playLoopSound:(NSString*) soundName;
-(void) playSoundFile:(NSString*) soundName;
-(void) playTime;
-(void) stopTime;

-(void) playWordSoundFile:(NSString*) soundName;
-(void) stopSound;
-(void) playSound;
//兒歌增加
-(void) playMusicFile:(NSString*) soundName;
@end
