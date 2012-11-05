//
//  EAPageGameDiffer.m
//  EABook
//
//  Created by Mac06 on 12/11/2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAPageGameDiffer.h"


@implementation EAPageGameDiffer
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	EAPageGameDiffer *layer = [EAPageGameDiffer node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
    if (self = [super init]) {
        gamepoint = delegate.EAGamePoint;
        tapObjectArray = [[NSMutableArray alloc] init];
        layerButtons = [[NSMutableArray alloc] init];
        
        delegate = (AppController*) [[UIApplication sharedApplication] delegate];
        tapgestureRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)] autorelease];
        tapgestureRecognizer.numberOfTapsRequired = 1; //new add
        [delegate.navController.view addGestureRecognizer:tapgestureRecognizer];
        
        stages = [[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3],[NSNumber numberWithInt:4],nil] retain];
        NSLog(@"%@",stages.description);
        stage = 0;
        [self swapStages];
        NSLog(@"%@",stages.description);
        
        [self addChild:soundMgr];
        [self addObjects];
        
        [self runAction:[CCSequence actionOne:[CCDelayTime actionWithDuration:1.5f] two:[CCCallFunc actionWithTarget:self selector:@selector(gameStart)]]];
        //[self gameStart];
    }
    return self;
}

-(void) swapStages
{
    for (int i = 0; i < 4; i++) {
        int a = arc4random()%5;
        int b = arc4random()%5;
        id temp;
        
        temp = [stages objectAtIndex:a];
        [stages replaceObjectAtIndex:a withObject:[stages objectAtIndex:b]];
        [stages replaceObjectAtIndex:b withObject:temp];
    }
}

-(void) gameStart
{
    differGame = [GameBoardDiffer node];
    [self addChild:differGame];
    
    differGame.stageNum = [[stages objectAtIndex:stage] intValue]; //設定關卡值
    [differGame gameStart]; //設定遊戲界面
    tapObjectArray = [[layerButtons arrayByAddingObjectsFromArray:differGame.tapObjectArray] mutableCopy];
    
    progressBar.percentage = 100;
    [self schedule:@selector(countDown) interval:1.0f];
}

-(void) gameOver
{
    [self unschedule:@selector(countDown)];
    CCSprite *endImage;
    if (differGame.answerNum == differGame.questNum) {
        endImage = [CCSprite spriteWithFile:@"P0-2_game_win.png"];
    }
    else
    {
        endImage = [CCSprite spriteWithFile:@"P0-2_game_lose.png"];
    }
    endImage.tag = 2;
    endImage.position = ccp(512, 384);
    [self addChild:endImage];
    
    [self runAction:[CCSequence actionOne:[CCDelayTime actionWithDuration:1.0f] two:[CCCallFunc actionWithTarget:self selector:@selector(addMenu)]]];
}

-(void) addMenu
{
    [self removeChildByTag:2 cleanup:YES];//清結果圖片
    [self removeChild:differGame cleanup:YES];//清結束得遊戲
    
    overMenu = [GameOoverMenu node];
    if (stage == (STAGE_NUM-1)) {
        [overMenu addTwoObject];
    }
    else
    {
        [overMenu addThreeObject];
    }
    [self addChild:overMenu];
    
    tapObjectArray = [[layerButtons arrayByAddingObjectsFromArray:overMenu.tapArray] mutableCopy];
}

-(void) countDown
{
    NSLog(@"countdown");
    if (differGame.countDown > -1) {
        differGame.countDown --;
        progressBar.percentage -= 3;
    }
    else
    {
        [self gameOver];
    }
}

-(void) addObjects
{
    [self addBackGround:@"P0-2_game-different.jpg"];
    
    //加入按鈕
    tempObject = [CCSprite spriteWithFile:@"P0-2_game-who_return-buttun.png"];
    [tempObject setTag:20];
    [tempObject setPosition:ccp(80, 75)];
    [self addChild:tempObject];
    [tapObjectArray insertObject:tempObject atIndex:0];
    
    //返回鍵加入觸碰偵測array
    [tapObjectArray addObject:[self getChildByTag:20]];
    //記下layer上的按鈕們（返回鍵）
    layerButtons = tapObjectArray;
}

#pragma 手勢處理
-(void) handleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    if (touchEnable && (tapObjectArray.count > 0)) {
        [self tapSpriteMovement:touchLocation];
    }
}

-(void) tapSpriteMovement:(CGPoint)touchLocation
{
    //NSLog(@"Tap! %d", tapObjectArray.count);
    for (CCSprite* obj in tapObjectArray) {
        if (CGRectContainsPoint(obj.boundingBox, touchLocation)) {
            NSLog(@"Tap! %d", obj.tag);
            switch (obj.tag) {
                case 20:
                    [soundMgr playSoundFile:@"push.mp3"];
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPageGameZone scene] backwards:YES]];
                    break;
                case 31:
                case 32:
                case 33:
                case 34:
                case 41:
                case 42:
                case 43:
                case 44:
                    [differGame removeGameObject:obj.tag];
                    tapObjectArray = [[layerButtons arrayByAddingObjectsFromArray:differGame.tapObjectArray] mutableCopy];
                    if (differGame.answerNum == differGame.questNum) {
                        [self gameOver];
                    }
                    break;
                case 23://下一關
                    [self removeChild:overMenu cleanup:NO];
                    tapObjectArray = layerButtons;
                    if (stage < (STAGE_NUM-1)) {
                        stage ++;
                        [self gameStart];
                    }
                    break;
                case 24://再來一次
                    [self removeChild:overMenu cleanup:NO];
                    tapObjectArray = layerButtons;
                    
                    [self gameStart];
                    break;
                case 25://離開
                    [self removeChild:overMenu cleanup:NO];
                    tapObjectArray = layerButtons;
                    
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:TURN_DELAY scene:[EAPageGameZone scene] backwards:YES]];
                    break;
                default:
                    break;
            }
            break;
        }
    }
}

-(void) dealloc {
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
    
    [super dealloc];
}
@end
