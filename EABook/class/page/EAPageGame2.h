//
//  EAPageGame2.h
//  EABook
//
//  Created by gdlab on 12/10/31.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "EALayer.h"
#import "EAPage4.h"
#import "EAPageEnd.h"

@interface EAPageGame2 : EALayer {
    NSMutableArray *anims;
    NSMutableArray *showanims;
    CCSprite *animal;
    CCSprite *WinImage;
    CCSprite *ReturnBtn;
    CCSprite *MenuImage;
    CCSprite *ExitBtn;
    CCProgressTimer *progressBar;
    NSString *tempName;
    int countTime;
    int imgcountTime;
    int showspritetag;
    int startX;
    int startY;
    BOOL isWinImage;
    BOOL isEixt;
}
+(CCScene *) scene;
@end
