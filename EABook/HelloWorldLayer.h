//
//  HelloWorldLayer.h
//  EABook
//
//  Created by gdlab on 12/10/26.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//


#import <GameKit/GameKit.h>
#import "EALayer.h"

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : EALayer
{
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
+(CCScene *) sceneWithGamePoint:(GamePoint *)gp;
@end
