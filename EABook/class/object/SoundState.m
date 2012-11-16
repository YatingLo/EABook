//
//  SoundState.m
//  EABook
//
//  Created by Mac06 on 12/11/16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "SoundState.h"


@implementation SoundState
-(id) init
{
    wordState = effectState = YES;
    return self;
}

-(void) setSoundState:(BOOL)word effect:(BOOL)effect;
{
    wordState = word;
    effectState = effect;
}
-(BOOL) getWordState
{
    return wordState;
}
-(BOOL) getEffectState
{
    return effectState;
}
@end
