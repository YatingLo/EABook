//
//  DrawGallery.h
//  EABook
//
//  Created by Mac06 on 12/11/16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface DrawGallery : CCLayer {
    CCSprite *tempObject;
    CGPoint imagePosition[6];
    float imagScal;
    
}
@property (nonatomic, retain) NSMutableArray *tapArray;
@property (nonatomic, retain) NSString *selectedImageName;

-(void) addObject:(NSArray*)fileList;


@end
