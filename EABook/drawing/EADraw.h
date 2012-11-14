//
//  EADraw.h
//  EABook
//
//  Created by Mac06 on 12/11/8.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "EALayer.h"
#import "CCSpriteFloodFill.h"

@interface EADraw : EALayer {
    CCSpriteFloodFill * sprite;
	ccColor4B Colors[8];
	NSUInteger SelectedCrayon;
    CCArray *cavas;
}
+(CCScene *) scene;
@end
