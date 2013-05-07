//
//  EALayerProtocol.h
//  Animal
//
//  Created by Mac06 on 13/5/7.
//
//

#import <Foundation/Foundation.h>

#define TAP 0
#define SWIPE 1
#define PAN 2
#define SOUND 3
#define ALL 4

@protocol EALayerProtocol <NSObject>

-(void) switchInteraction:(int) type;
-(void) switchInteractionElse:(int) type;

@end
