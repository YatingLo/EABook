//
//  FileOps.h
//  EABook
//
//  Created by Mac06 on 12/11/16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCRenderTexture.h"

@interface FileOps : CCNode {
    
}
-(NSArray*) getDirList;
-(BOOL) saveSpriteToPNG:(CCSprite*)sprite;
@end
