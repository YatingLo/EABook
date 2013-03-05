//
//  EAAnimSprite.h
//  EbookAnimal
//
//  Created by gdlab on 12/10/26.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <AVFoundation/AVFoundation.h>

@interface EAAnimSprite : CCSprite {
    @public
    NSString *imageName;
    NSString *soundName;
    NSString *wordsoundName;
    NSString *wordimageName;
    NSString *wordmusicName;
    NSInteger imgNum;
    NSInteger repeatTime;
    BOOL _isTouch;
    
    @protected
    float delayTime;
    NSMutableArray *animImageFrames;
}

@property(nonatomic, retain) NSString *imageName, *soundName, *wordsoundName, *wordimageName, *wordmusicName;
@property(nonatomic) BOOL isTouch;
@property(nonatomic, readwrite) NSInteger imgNum, repeatTime;
@property(nonatomic, readwrite) float delayTime;
@property(nonatomic, retain) CCAnimation *spAnimate;

+ (id)spriteWithName:(NSString*)name;
- (id)initWithName:(NSString*)name;

-(void) startAnimation;
-(void) startLoopAnimation;

-(void) firstFram;

@end
