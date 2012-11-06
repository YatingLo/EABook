//
//  EAPage2.h
//  EABook
//
//  Created by gdlab on 12/10/27.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "EALayer.h"
#import "EAAnimSprite.h"
#import "MotionSensor.h"
#import "EASoundDectectSprite.h"

#import "EAPageMenu.h"
#import "EAPage1.h"
#import "EAPage3-1.h"
#import "EAPage3-2.h"
#import "EAPage3-3.h"
#import "EAPage4.h"

@interface EAPage2 : EALayer {
    EAAnimSprite *horse;
    EAAnimSprite *sheep;
    EAAnimSprite *zibber;
    EAAnimSprite *windmil;
}

+(CCScene *) scene;
@end
