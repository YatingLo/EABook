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
    NSFileManager *fileMgr = [[NSFileManager defaultManager] autorelease];
    NSError *error = nil;
    NSArray *fileList = [fileMgr contentsOfDirectoryAtPath:HOME_PATH error:&error];
    NSMutableArray *dirList = [[NSMutableArray alloc] init];
    
    //降冪排列
    NSSortDescriptor *SortDescriptor=[NSSortDescriptor sortDescriptorWithKey:Nil ascending:NO selector:@selector(compare:)];
    fileList = [[fileList sortedArrayUsingDescriptors:[[NSArray arrayWithObject:SortDescriptor] mutableCopy]] mutableCopy];
    
    int i = 1;
    for (NSString *file in fileList) {
        NSString  *path =[HOME_PATH stringByAppendingPathComponent:file];
        BOOL isDir;
        BOOL success = [fileMgr fileExistsAtPath:path isDirectory:&isDir];
        BOOL other = NO;
        
        BOOL other2 = [file isEqualToString:@"Config.plist"];
        other = [file isEqualToString:@".DS_Store"];
        if (success & !isDir & !other & !other2) {
            if (i++ < 7) {
                [dirList addObject:file];
                NSLog(@"%@",file);
            }
            else
            {
                [fileMgr removeItemAtPath:[HOME_PATH stringByAppendingPathComponent:file] error:&error];
            }
        }
    }
    
    return dirList;
}

//設定儲存檔案名稱
-(NSString*) getFileName
{
    return [NSString stringWithFormat:@"/image%@%@",[self getTime], @".png"];
}

-(NSString*) getTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"MM-dd-HH-mm-ss"];
    //dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSSSSS";
    //NSLog(@"Date%@", [dateFormatter stringFromDate:[NSDate date]]);
    return [dateFormatter stringFromDate:[NSDate date]];
}

//存檔
-(BOOL) saveSpriteToPNG:(CCSprite*)sprite
{
    //NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Test2.png"];
    NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    pngPath = [pngPath stringByAppendingString:[self getFileName]];
    
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

//刪除檔案
-(BOOL) deleteImage:(NSString*)fileName
{
    NSFileManager *fileMgr = [[NSFileManager defaultManager] autorelease];
    NSError *error = nil;
    [fileMgr removeItemAtPath:[HOME_PATH stringByAppendingPathComponent:fileName] error:&error];
    return YES;
}
@end
