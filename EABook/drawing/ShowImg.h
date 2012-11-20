//
//  ShowImg.h
//  EABook
//
//  Created by Mac06 on 12/11/16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ShowImg : CCLayer {
    CCSprite *tempObject;
}
@property (nonatomic, retain) NSMutableArray *tapArray;

- (id) initWithImage:(NSString*)imageName;
@end
