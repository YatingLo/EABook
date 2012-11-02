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
    
    CCArray *tapObjectArray;
}
-(void) gameInit;
-(void) gameStart;
-(void) gamePause;
-(void) gameStop;
-(void) gameOver;
@end
