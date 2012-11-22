//
//  EAPageGame2.m
//  EABook
//
//  Created by gdlab on 12/10/31.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EAPageGame2.h"


@implementation EAPageGame2
+(CCScene *) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	EAPageGame2 *layer = [EAPageGame2 node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init{
	if(self = [super init]){
        //gamepoint = delegate.EAGamePoint;
        
        tapgestureRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)] autorelease];
        tapgestureRecognizer.numberOfTapsRequired = 1; //new add
        [delegate.navController.view addGestureRecognizer:tapgestureRecognizer];
        
        countTime = 0;
        imgcountTime=0;
        showspritetag = 0;
        startX = 690;
        startY = 370;
        isWinImage = FALSE;//答對答錯畫面是否消失，消失才能啟動場景出現隨機動物畫面和Touch功能
        isEixt = FALSE;
        anims =[[NSMutableArray alloc]init];
        showanims = [[NSMutableArray alloc]init];
        
        [soundDetect stopDetect];
        
        [self addObjects];
        
        [self schedule:@selector(callEveryFrame:) interval:1];
        [soundMgr playTime];
    }
    return self;
}

-(void)addObjects{
    [self addBackGround:@"P0-2_game-who.jpg"];
    
    ReturnBtn = [CCSprite spriteWithFile:@"P0-2_game-who_return-buttun.png"];
    ReturnBtn.position = ccp(55, 75);
    //[self addChild:ReturnBtn];
    
    //加入四個動物到陣列以便做Touch並加到場景中，設定tag值
    //NSString *tempName;
    
    tempName = @"zebra";
    CCSprite *anim = [CCSprite spriteWithFile:[NSString stringWithFormat:@"GAME_who_%@.jpg",tempName]];
    anim.position = ccp(startX, startY);
    anim.tag=3;
    [self addChild:anim];
    [showanims addObject:anim];
    
    tempName =@"peacock";
    anim = [CCSprite spriteWithFile:[NSString stringWithFormat:@"GAME_who_%@.jpg",tempName]];
    anim.position = ccp(startX,startY-180);
    anim.tag=4;
    [self addChild:anim];
    [showanims addObject:anim];
    
    tempName =@"elephant";
    anim = [CCSprite spriteWithFile:[NSString stringWithFormat:@"GAME_who_%@.jpg",tempName]];
    anim.position = ccp(startX+150,startY);
    anim.tag=5;
    [self addChild:anim];
    [showanims addObject:anim];
    
    tempName =@"crab";
    anim = [CCSprite spriteWithFile:[NSString stringWithFormat:@"GAME_who_%@.jpg",tempName]];
    anim.position = ccp(startX+150,startY-180);
    anim.tag=6;
    [self addChild:anim];
    [showanims addObject:anim];
    
    //同樣將相同四種動物加入陣列中，以便隨機取出加到場景中，設定相同tag值做答案確認
    NSArray *images = [NSArray arrayWithObjects:@"P2_zibber_0.png",@"P3-1_peacock_0.png",@"P3-2_elephant_0.png",@"P3-3_Crab_0.png", nil];
    for (int i=0; i<images.count; i++) {
        NSString *image = [images objectAtIndex:i];
        CCSprite *sprite = [CCSprite spriteWithFile:image];
        sprite.tag = i+3;
        printf("sprite tag:%i\n",sprite.tag);
        [sprite setOpacity:0];
        [anims addObject:sprite];
    }
    
    CCSprite *progressBackGround = [CCSprite spriteWithFile:@"P0-2_game-different_time-bar1.png"];
    [progressBackGround setPosition:ccp(512, 690)];
    //[progressBackGround setZOrder:1];
    [self addChild:progressBackGround];
    
    CCSprite *progressBarSprite = [CCSprite spriteWithFile:@"P0-2_game-different_time-bar2.png"];
    progressBar = [CCProgressTimer progressWithSprite:progressBarSprite];
    [progressBar setPosition:ccp(564, 687)];
    [progressBar setType:kCCProgressTimerTypeBar];
    [progressBar setMidpoint:ccp(0, 0)];
    [progressBar setBarChangeRate:ccp(1, 0)];
    [progressBar setPercentage:100];
    //[progressBar setZOrder:2];
    [self addChild:progressBar];
}

-(void) handleTapFrom:(UITapGestureRecognizer *)recognizer{
    //NSLog(@"Tap");
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    [self selectSpriteForTouch:touchLocation];
    
}

-(void) selectSpriteForTouch:(CGPoint)touchLocation{
    
    if (CGRectContainsPoint(ExitBtn.boundingBox, touchLocation)&&isEixt) {
        [soundMgr stopTime];
        [soundMgr playSoundFile:SOUND_PUSH];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionRotoZoom transitionWithDuration:TURN_DELAY scene:[EAPageEnd scene]]];
    }
    else if (isWinImage){
        for (CCSprite *sprite in showanims) {
            
            [soundMgr stopTime];
            
            if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) {
                NSLog(@"sprite tag -----%d",sprite.tag);
                [soundMgr stopTime];
                //若出現在場景的圖片和選取圖片tag值相同則出現答對畫面，反之則否
                if (sprite.tag ==showspritetag) {
                    isWinImage = FALSE;
                    [animal stopAllActions];
                    [self removeChild:animal cleanup:YES];
                    tempName =@"P0-2_game_win.png";
                    [self checkAnswer:tempName];
                    [soundMgr playSoundFile:SOUND_GSUCES];
                }
                else if(sprite.tag != showspritetag){
                    isWinImage = FALSE;
                    [animal stopAllActions];
                    [self removeChild:animal cleanup:YES];
                    tempName =@"P0-2_game_lose.png";
                    [self checkAnswer:tempName];
                    [soundMgr playSoundFile:SOUND_GFAIL];
                }
                
                
            }
        }
    }
}

//設置答對答錯畫面
-(void) checkAnswer :(NSString *)WinImageName{
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    WinImage = [CCSprite spriteWithFile:WinImageName];
    WinImage.position = ccp(winSize.width/2, winSize.height/2);
    [self addChild:WinImage];
    [self schedule:@selector(showWinImage:) interval:1];
}

//設置答對答錯畫面出現時間
-(void) showWinImage:(ccTime)dt{
    
    [self unschedule:@selector(callEveryFrame:)];
    
    if (imgcountTime<2) {
        imgcountTime++;
    }
    else{
        [self removeChild:WinImage cleanup:YES];
        imgcountTime = 0;
        [self unschedule:@selector(showWinImage:)];
        [self showExit];
        isEixt = TRUE;
        countTime=0;
        //[self schedule:@selector(callEveryFrame:) interval:1];
    }
}

//隨機選擇動物圖片到場景中
-(void) setImageFromAnims{
    
    NSUInteger index =arc4random()%anims.count;
    animal =[anims objectAtIndex:index];
    animal.position =ccp(300, 350);
    showspritetag = animal.tag;
    NSLog(@"animal=%d",showspritetag);
    CCFadeTo *fadeOut =[CCFadeTo actionWithDuration:10 opacity:255];
    [self addChild:animal];
    [animal runAction:fadeOut];
    
}

//設置場景中動物圖片出現時間
- (void) callEveryFrame:(ccTime)dt
{
    
    countTime += 1;
    //CCLOG(@"countTime : %i",countTime);
    progressBar.percentage -=10;
    
    if (countTime==1) {
        [progressBar setPercentage:100];
        [self setImageFromAnims];
        
    }
    else if (countTime==2) {
        isWinImage = TRUE;
    }
    else if(countTime>10){
        [progressBar setPercentage:0];
        [animal stopAllActions];
        [animal setOpacity:0];
        [self removeChild:animal cleanup:YES];
        isWinImage = FALSE;
        countTime=0;
        [self unschedule:@selector(callEveryFrame:)];
        tempName =@"P0-2_game_lose.png";
        [self checkAnswer:tempName];
        
    }
    
}

//顯示離開畫面
-(void) showExit{
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    MenuImage = [[CCSprite alloc]initWithFile:@"P0-2_game_end.png"];
    MenuImage.position =ccp(size.width/2, size.height/2);
    [self addChild:MenuImage];
    
    ExitBtn = [[CCSprite alloc]initWithFile:@"P0-2_game_exit.png"];
    ExitBtn.position =ccp(512, 350);
    [self addChild:ExitBtn];
    
}
-(void)dealloc{
    printf("Guess Who dealloc");
    [delegate.navController.view removeGestureRecognizer:tapgestureRecognizer];
    [anims removeAllObjects];
    [showanims removeAllObjects];
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}
@end
