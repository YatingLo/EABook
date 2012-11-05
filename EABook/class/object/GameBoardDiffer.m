//
//  GameBoardDiffer.m
//  EABook
//
//  Created by Mac06 on 12/11/2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameBoardDiffer.h"
#import "GameBoard.h"

@implementation GameBoardDiffer
@synthesize questNum, answerNum, stageNum, tapObjectArray;
-(id) init
{
    if (self = [super init])
    {
        tapObjectArray = [[NSMutableArray alloc] init];
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],@"colider.txt"]];
        stages = [[NSString stringWithContentsOfURL:url encoding:NSUnicodeStringEncoding error:nil] componentsSeparatedByString:@"\n"];
        
        //載入圖片
        [[CCTextureCache sharedTextureCache] addImage:@"P0-3_circle.png"];
    }
    return self;
}

-(void) removeGameObject:(int) objTag
{
    answerNum ++;
    numLaber.string = [NSString stringWithFormat:@"%d", answerNum];
    CCTexture2D *circle = [[CCTextureCache sharedTextureCache] textureForKey:@"P0-3_circle.png"];
    if (objTag == 31 || objTag == 41) {

        CCSprite *tempSprite = [CCSprite spriteWithTexture:circle];
        tempSprite.position = [self getChildByTag:31].position;
        tempSprite.scale = CIRCLE_SCALE;
        [self addChild:tempSprite];
        tempSprite = [CCSprite spriteWithTexture:circle];
        tempSprite.position = [self getChildByTag:41].position;
        tempSprite.scale = CIRCLE_SCALE;
        [self addChild:tempSprite];
        
        [tapObjectArray removeObject:[self getChildByTag:31]];
        [tapObjectArray removeObject:[self getChildByTag:41]];
        [self removeChildByTag:31 cleanup:YES];
        [self removeChildByTag:41 cleanup:YES];
    }
    else if (objTag == 32 || objTag == 42) {
        
        CCSprite *tempSprite = [CCSprite spriteWithTexture:circle];
        tempSprite.position = [self getChildByTag:32].position;
        tempSprite.scale = CIRCLE_SCALE;
        [self addChild:tempSprite];
        tempSprite = [CCSprite spriteWithTexture:circle];
        tempSprite.position = [self getChildByTag:42].position;
        tempSprite.scale = CIRCLE_SCALE;
        [self addChild:tempSprite];
        
        [tapObjectArray removeObject:[self getChildByTag:32]];
        [tapObjectArray removeObject:[self getChildByTag:42]];
        
        [self removeChildByTag:32 cleanup:YES];
        [self removeChildByTag:42 cleanup:YES];
    }
    else if (objTag == 33 || objTag == 43) {
        
        CCSprite *tempSprite = [CCSprite spriteWithTexture:circle];
        tempSprite.position = [self getChildByTag:33].position;
        tempSprite.scale = CIRCLE_SCALE;
        [self addChild:tempSprite];
        tempSprite = [CCSprite spriteWithTexture:circle];
        tempSprite.position = [self getChildByTag:43].position;
        tempSprite.scale = CIRCLE_SCALE;
        [self addChild:tempSprite];
        
        [tapObjectArray removeObject:[self getChildByTag:33]];
        [tapObjectArray removeObject:[self getChildByTag:43]];
        [self removeChildByTag:33 cleanup:YES];
        [self removeChildByTag:43 cleanup:YES];
    }
    else if (objTag == 34 || objTag == 44) {
        
        CCSprite *tempSprite = [CCSprite spriteWithTexture:circle];
        tempSprite.position = [self getChildByTag:34].position;
        tempSprite.scale = CIRCLE_SCALE;
        [self addChild:tempSprite];
        tempSprite = [CCSprite spriteWithTexture:circle];
        tempSprite.position = [self getChildByTag:44].position;
        tempSprite.scale = CIRCLE_SCALE;
        [self addChild:tempSprite];
        
        [tapObjectArray removeObject:[self getChildByTag:34]];
        [tapObjectArray removeObject:[self getChildByTag:44]];
        [self removeChildByTag:34 cleanup:YES];
        [self removeChildByTag:44 cleanup:YES];
    }
}

-(NSArray*) setGameObecjts:(NSString*) stage
{
    NSArray *temp;
    NSString *img;
    
    temp = [stage componentsSeparatedByString:@"//"];
    
    //下方顯示文字
    numLaber = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", questNum] fontName:@"Arial-BoldMT" fontSize:70];
    numLaber.position = ccp(550, 140);
    numLaber.color = ccc3(47, 168, 225);
    [self addChild:numLaber];
    
    numLaber = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", answerNum] fontName:@"Arial-BoldMT" fontSize:70];
    numLaber.position = ccp(470, 140);
    numLaber.color = ccc3(47, 168, 225);
    numLaber.tag = 50;
    [self addChild:numLaber];
    
    //左邊的圖
    img = [temp objectAtIndex:0];
    CCSprite *q1 = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.jpg",img]]; 
    q1.position = ccp(100 + q1.boundingBox.size.width/2 + 2, 255 + q1.boundingBox.size.height/2 - 6);
    [self addChild:q1];
    //右邊的圖
    img = [img stringByReplacingCharactersInRange:NSMakeRange(20, 1) withString:@"B"];
    q1 = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.jpg",img]];
    q1.position = ccp(100 + q1.boundingBox.size.width/2 + 449, 255 + q1.boundingBox.size.height/2 - 6);
    [self addChild:q1];
    
    //觸碰區設定
    objects = [[[temp objectAtIndex:1] componentsSeparatedByString:@"*"] mutableCopy];
    [objects removeObjectAtIndex:4];
    int i = 0;
    for (NSString *string in objects) {
        ++i;
        CCSprite *ob = [CCSprite node]; //左邊的觸碰區
        NSArray *des = [string componentsSeparatedByString:@","];
        [ob setTextureRect:CGRectMake(0, 0, [des[0] integerValue], [des[1] integerValue])];
        ob.position = ccp([des[2] integerValue], [des[3] integerValue]);
        ob.tag = 30 + i;
        [self addChild:ob];
        [tapObjectArray addObject:ob];
        
        CCSprite *ob2 = [CCSprite node]; //右邊的觸碰區
        ob2.textureRect = ob.textureRect;
        ob2.position = ccpAdd(ccp(447, 0), ob.position);
        ob2.tag = 40 + i;
        [self addChild:ob2];
        [tapObjectArray addObject:ob2];
        //NSLog(@"%@",des.description);
    }
    
    return temp;
}

-(void) gameStart
{
    questNum = 4;
    answerNum = 0;
    countDown = GAME_TIME;
    [self setGameObecjts:[stages objectAtIndex:stageNum]];
}

-(void) dealloc
{
    [super dealloc];
}
@end
