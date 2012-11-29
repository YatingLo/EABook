//
//  SoundManager.m
//  EABook
//
//  Created by gdlab on 12/10/29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "SoundManager.h"

@implementation SoundManager

-(id) init
{
    if (self = [super init]) {
        
    }
    return self;
}

-(void) playLoopSound:(NSString*) soundName
{
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],soundName]];
    
    NSLog(@"play loop");
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    if (audioPlayer) {
        audioPlayer.numberOfLoops = 1;
        [audioPlayer play];
    }
}

-(void) playSoundFile:(NSString*) soundName
{
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],soundName]];
    
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    if (audioPlayer && !audioPlayer.isPlaying) {
        NSLog(@"sound play");
        audioPlayer.numberOfLoops = 0;
        [audioPlayer play];
    }
}

-(void) playTime
{
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],SOUND_GTIME]];
    
    timePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    timePlayer.numberOfLoops = -1;
    [timePlayer play];
}

-(void) stopTime
{
    if(timePlayer && [timePlayer isPlaying])
    {
        [timePlayer stop];
    }
}

//會switch ON and OFF
-(void) playWordSoundFile:(NSString*) soundName
{
    //切換互動狀態
    //[self runAction:[CCCallFunc actionWithTarget:parent_ selector:@selector(switchInteraction)]];
    [self runAction:[CCCallFuncND actionWithTarget:parent_ selector:@selector(switchInteractionElse:data:) data:0]];
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],soundName]];
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    if (audioPlayer) {
        audioPlayer.numberOfLoops = 0;
        [audioPlayer play];
        [self schedule:@selector(PlayWordSound:) interval:1];
    }
}

-(void) playSound
{
    if (audioPlayer && !audioPlayer.isPlaying) {
        [audioPlayer play];
    }
}

-(void) stopSound
{
    //[audioPlayer stop];
    if (audioPlayer && audioPlayer.isPlaying) {
        [audioPlayer stop];
    }
    if(timePlayer && [timePlayer isPlaying])
    {
        [timePlayer stop];
    }
}

-(void) PlayWordSound:(ccTime)dt{
    
    if (![audioPlayer isPlaying]) {
        printf("\nplaydone");
        [self unschedule:@selector(PlayWordSound:)];
        audioPlayer = Nil;
        
        //[[NSNotificationCenter defaultCenter] postNotificationName:WORD_STOP object:self];
        //切換互動狀態
        [self runAction:[CCCallFunc actionWithTarget:parent_ selector:@selector(removeWordImage)]];
        [self runAction:[CCCallFuncND actionWithTarget:parent_ selector:@selector(switchInteractionElse:data:) data:0]];
    }
}

-(void) dealloc
{
    [super dealloc];
    [audioPlayer dealloc];
}

@end
