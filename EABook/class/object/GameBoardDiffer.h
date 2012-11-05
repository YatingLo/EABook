//
//  GameBoardDiffer.h
//  EABook
//
//  Created by Mac06 on 12/11/2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameBoard.h"
#define GAME_TIME 15 //遊戲進行時間
#define CIRCLE_SCALE 0.5f //紅色圈圈的縮放比例
#define DEBUG_BLACK NO

@interface GameBoardDiffer : GameBoard {
    int questNum;
    int answerNum;
    int stageNum;
    
    NSMutableArray *objects;
    NSArray *stages;
    
    CCLabelTTF *numLaber;
}

@property int questNum, answerNum, stageNum;

-(NSArray*) setGameObecjts:(NSString*) stage;
-(void) removeGameObject:(int) objTag;

@end
