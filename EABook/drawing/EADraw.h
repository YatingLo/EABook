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

@interface EADraw : EALayer {
    
}
+(CCScene *) scene;
+(CGContextRef) createARGBBitmapContextFromImage:(CGImageRef) inImage;
@end
