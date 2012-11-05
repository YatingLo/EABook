//
//  EAPageGame1.h
//  EABook
//
//  Created by gdlab on 12/10/31.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "EALayerGame.h"
#import "EAPage3-1.h"
#import "EAPage3-2.h"
#import "EAPage3-3.h"
#import "EAPage4.h"
#import "GameBoardDiffer.h"
#import "GameOoverMenu.h"

@interface EAPageGame1 : EALayerGame {
    NSMutableArray *layerButtons;
    GameBoardDiffer *differGame;
    GameOoverMenu *overMenu;
    
    NSMutableArray *stages;
    int stage;
}
+(CCScene *) scene;
@end
