//
//  EAPageGameDiffer.h
//  EABook
//
//  Created by Mac06 on 12/11/2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "EALayer.h"
#import "EAPageGameZone.h"
#import "GameOoverMenu.h"
#import "EALayerGame.h"
#import "GameBoardDiffer.h"

@interface EAPageGameDiffer : EALayerGame {
    NSMutableArray *layerButtons;
    GameBoardDiffer *differGame;
    GameOoverMenu *overMenu;
    
    NSMutableArray *stages;
    int stage;
    
    int endEnable; //只執行一次gameover的flag
}
+(CCScene *) scene;

-(void) swapStages;
@end
