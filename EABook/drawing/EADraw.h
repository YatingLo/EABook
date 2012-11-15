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
#import "EAPageGameZone.h"

@interface EADraw : EALayer {
    CCSpriteFloodFill * sprite;
	ccColor4B Colors[9];
    NSArray *cavas;
    
    BOOL drawAble;
    NSInteger canvasImageNum;
    NSUInteger SelectedCrayon;
}
+(CCScene *) scene;
@end
