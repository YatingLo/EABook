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
#import "MusicBtnSprite.h"

@interface EALayer : CCLayer<EALayerProtocol> {
    @protected
    NSMutableArray *tapObjectArray;
    NSMutableArray *swipeObjectArray;
    NSMutableArray *panObjectArray;
    NSMutableArray *moveObjectArray;
    
    //word image 新增
    NSMutableArray *tapButtons;
    CCNode *WordImageNode;
    
    GamePoint *gamepoint;
    AppController *delegate;
    
    BOOL _tapEnable;
    BOOL _swipeEnable;
    BOOL _panEnable;
    BOOL _soundEnable;
    
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
    //兒歌新增
    MusicBtnSprite *MusicButton;
    NSString *wordMusicName;
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
-(void) addWordImage:(NSString*)imageName music:(NSString*)musicName;
-(void) removeWordImage;
-(void) addPre;
-(void) addNext;
-(void) addReturn;

-(void) moveAtBegin;
@end
