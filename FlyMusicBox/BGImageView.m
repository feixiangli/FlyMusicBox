//
//  BGImageView.m
//  FlyMusicBox
//
//  Created by 李飞翔 on 16/4/15.
//  Copyright © 2016年 Fly. All rights reserved.
//

#import "BGImageView.h"

@implementation BGImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithImage:(UIImage *)image;
{
    if (self=[super initWithImage:image]) {
        
//        self= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main"]];
        
//        [self addSubview:imageview];

    }
    return self;
}

-(void)make{
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.superview).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        
        UIToolbar * toolbar=[[UIToolbar alloc] init];
        
        //
        //        UIBarStyleDefault          = 0,
        //        UIBarStyleBlack            = 1,
        //
        //        UIBarStyleBlackOpaque      = 1,
        //        UIBarStyleBlackTranslucent = 2
        toolbar.barStyle=UIBarStyleBlackOpaque;
        //        toolbar.backgroundColor=[UIColor whiteColor];
        
        [self addSubview:toolbar];
        
        [toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        
        //        UIBlurEffectStyleExtraLight,
        //        UIBlurEffectStyleLight,
        //        UIBlurEffectStyleDark
        //        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        //        UIVisualEffectView *effectView =[[UIVisualEffectView alloc]initWithEffect:effect];
        //        [imageview addSubview:effectView];
        //        [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        //                        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        //
        //        }];
        
        
    }];
}
@end
