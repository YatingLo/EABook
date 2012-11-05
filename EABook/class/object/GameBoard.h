//
//  GameBoard.h
//  EABook
//
//  Created by Mac06 on 12/11/2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameBoard : CCNode {
    //NSMutableArray *tapObjectArray;
    
    int countDown;
}
@property int countDown;
@property (nonatomic, readonly) NSMutableArray *tapObjectArray;
-(void) gameInit;
-(void) gameStart;
@end
