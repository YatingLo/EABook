//
//  EAPageGameWho.h
//  EABook
//
//  Created by Mac06 on 12/11/2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "EALayer.h"
#import "EAPageGameZone.h"
@interface EAPageGameWho : EALayer {
    NSMutableArray *anims;
    NSMutableArray *showanims;
    CCSprite *animal;
    CCSprite *WinImage;
    CCSprite *ReturnBtn;
    CCProgressTimer *progressBar;
    int countTime;
    int imgcountTime;
    int showspritetag;
    int startX;
    int startY;
    BOOL isWinImage;
    BOOL isReturn;
}
+(CCScene *) scene;

@end
