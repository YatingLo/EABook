//
//  SoundState.h
//  EABook
//
//  Created by Mac06 on 12/11/16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SoundState : CCNode {
    BOOL wordState;
    BOOL effectState;
}

-(void) setSoundState:(BOOL)word effect:(BOOL)effect;
-(BOOL) getWordState;
-(BOOL) getEffectState;
@end
