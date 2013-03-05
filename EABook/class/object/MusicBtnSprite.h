//
//  MusicBtnSprite.h
//  EABook
//
//  Created by Mac04 on 13/2/26.
//
//

#import "CCSprite.h"

@interface MusicBtnSprite : CCSprite{
    CCSprite *BtnCircle;
    CCSprite *BtnSprite;
}
@property(nonatomic,retain)CCSprite *BtnCircle;
-(void)startCircle;
-(void)stopCircle;
@end
