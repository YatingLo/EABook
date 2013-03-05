//
//  MusicBtnSprite.m
//  EABook
//
//  Created by Mac04 on 13/2/26.
//
//

#import "MusicBtnSprite.h"

@implementation MusicBtnSprite
@synthesize BtnCircle;
- (id)init{
    if((self = [super init]))
    {
        NSString *tempName;
        tempName = @"musicbutton";
        BtnCircle = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@_outcircle.png",tempName]];
        BtnCircle.position = ccp(35, 35);
        [self addChild:BtnCircle];
        
        BtnSprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@_inbasic.png",tempName]];
        BtnSprite.position = ccp(35, 35);
        [self addChild:BtnSprite];
        
        [self setContentSize:BtnCircle.contentSize];
       
    }
    return self;
}

-(void)startCircle{
    CCRotateTo *cirlceRun = [CCRotateBy actionWithDuration:0.5 angle:60];
    [BtnCircle runAction:[CCRepeatForever actionWithAction:cirlceRun]];
}
-(void)stopCircle{
    [BtnCircle stopAllActions];
    CCRotateTo *circleStop = [CCRotateTo actionWithDuration:0.5 angle:0];
    [BtnCircle runAction:circleStop];
}
@end
