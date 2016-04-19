//
//  NextButton.m
//  FlyMusicBox
//
//  Created by 李飞翔 on 16/4/16.
//  Copyright © 2016年 Fly. All rights reserved.
//

#import "NextButton.h"

@implementation NextButton

-(instancetype)init{
    
    if (self=[super init]) {
        [self setImage:[self NextImage] forState:UIControlStateNormal];
    }
    return self;
}

-(UIImage*)NextImage
{
    //next图片
    CGSize size2 = CGSizeMake(50, 50);
    CGRect bounds2 = CGRectMake(2, 2, 50-4, 50-4);
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(size2, NO, 0);
    
    CGContextRef ctx2 = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(ctx2,bounds2);
    
    
    CGContextMoveToPoint(ctx2, 2*50/3, 50/2);
    CGContextAddLineToPoint(ctx2, 50/3, 50/3);
    
    CGContextMoveToPoint(ctx2, 2*50/3, 50/2);
    CGContextAddLineToPoint(ctx2, 50/3, 2*50/3);
    
    
    CGContextSetLineWidth(ctx2, 2);
    [RGBACOLOR(255, 255, 255, 0.98) set];
    CGContextSetLineJoin(ctx2, kCGLineJoinRound);
    CGContextStrokePath(ctx2);//空心yuan
    
    
    CGContextStrokePath(ctx2);
    
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    return image;
}
-(void)make
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.bottom.equalTo(self.superview).offset(-50);
        make.centerX.equalTo(self.superview.mas_centerX).offset(self.superview.center.x /2);
    }];
}

@end
