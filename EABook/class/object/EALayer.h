//
//  EALayer.h
//  EbookAnimal
//
//  Created by Mac06 on 12/10/25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SoundSensor.h"
#import "MotionSensor.h"
#import "AppDelegate.h"
#import "GamePoint.h"
#import "EAAnimSprite.h"
#import "SoundManager.h"

@interface EALayer : CCLayer {
    @protected
    NSMutableArray *tapObjectArray;
    NSMutableArray *swipeObjectArray;
    NSMutableArray *panObjectArray;
    NSMutableArray *moveObjectArray;
    
    GamePoint *gamepoint;
    AppController *delegate;
    
    BOOL touchEnable;
    BOOL soundEnable;
    
    SoundSensor *soundDetect;
    MotionSensor *motionDetect;
    
    UITapGestureRecognizer *tapgestureRecognizer;
    UISwipeGestureRecognizer *swipegestureRecognizerLeft;
    UISwipeGestureRecognizer *swipegestureRecognizerRight;
    UISwipeGestureRecognizer *swipegestureRecognizerUp;
    UISwipeGestureRecognizer *swipegestureRecognizerDown;
    UIPanGestureRecognizer *pangestureRecognizer;
    
    CCSpriteBatchNode *spriteSheet;
    EAAnimSprite *tempObject;
    EAAnimSprite *touchedSprite;

    UISwipeGestureRecognizerDirection swipeDirection;
    
    SoundManager *soundMgr;
}
@property (nonatomic,retain) GamePoint *gamepoint;
@property BOOL touchEnable;
//@property (nonatomic, retain) NSMutableArray *tapObjectArray, *swipeObjectArray;

-(void) newStart:(ccTime)dt;
-(void) addObjects;
-(void) handleSwipe:(UISwipeGestureRecognizer *)recognizer;
-(void) handleTap:(UITapGestureRecognizer *)recognizer;
-(void) handlePan:(UIPanGestureRecognizer *)recognizer;
-(void) handlePanAndSwipe;
-(void) swipeSpriteMovement:(CGPoint)touchLocation direction:(UISwipeGestureRecognizerDirection)dir;
-(void) tapSpriteMovement:(CGPoint)touchLocation;
-(void) panSpriteMovement:(CGPoint)touchLocation;

-(void) switchInteraction;
-(void) switchTouchInteraction;
-(void) stopSpriteMove;
/*
-(void) addSprite:(CCSprite*) obj spriteType:(int)type;
-(void) addTapToLayer;
-(void) addPanToLayer;
-(void) addSwipeToLayer;
-(void) handlePanAndSwipe;
-(void) removeTapFromLayer;
-(void) removePanFromLayer;
-(void) removeSwipeFromLayer;
*/
-(void) addBackGround:(NSString*)imageName;
-(void) addWordImage:(NSString*)imageName;
-(void) removeWordImage;
-(void) addPre;
-(void) addNext;
-(void) addReturn;
@end
