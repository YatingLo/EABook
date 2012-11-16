//
//  FileOps.m
//  EABook
//
//  Created by Mac06 on 12/11/16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "FileOps.h"


@implementation FileOps
-(NSArray*) getDirList
{
    return NULL;
}
-(BOOL) saveSpriteToPNG:(CCSprite*)sprite
{
    NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Test2.png"];
    NSLog(@"%@",pngPath);
    UIImage *image = [self convertSpriteToImage:sprite];
    [UIImagePNGRepresentation(image) writeToFile:pngPath atomically:YES];
    return YES;
}
-(UIImage *) convertSpriteToImage:(CCSprite *)sprite {
    
    CGPoint p = sprite.anchorPoint;
    
    CCRenderTexture *renderer = [CCRenderTexture renderTextureWithWidth:sprite.contentSize.width height:sprite.contentSize.height];
    
    [renderer begin];
    
    [sprite visit];
    
    [renderer end];
    
    [sprite setAnchorPoint:p];
    
    //return [UIImage imageWithData:[renderer getUIImageAsDataFromBuffer:kCCImageFormatPNG]];
    return [renderer getUIImage];
}
@end
