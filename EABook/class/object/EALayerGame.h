//
//  EALayerGame.h
//  EABook
//
//  Created by Mac06 on 12/11/2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "EALayer.h"
#import "GameBoardDiffer.h"

@interface EALayerGame : EALayer {
    CCProgressTimer *progressBar;
}
-(void) exitGame;
@end
