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
#import "DrawGallery.h"
#import "ShowImg.h"
#import "FileOps.h"

@interface EADraw : EALayer {
    CCSpriteFloodFill * sprite;
	ccColor4B Colors[9];
    NSArray *cavas;
    
    BOOL drawAble;
    int canvasImageNum;
    NSUInteger SelectedCrayon;
    
    DrawGallery *gallery;
    ShowImg *imageShow;
    NSMutableArray *tapArray;
    FileOps *fileMgr;
}
+(CCScene *) scene;
@end
