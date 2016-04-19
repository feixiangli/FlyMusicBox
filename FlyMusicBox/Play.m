//
//  Play.m
//  FlyMusicBox
//
//  Created by 李飞翔 on 16/4/15.
//  Copyright © 2016年 Fly. All rights reserved.
//

#import "Play.h"

@implementation Play


-(instancetype)init{
    
    if (self=[super init]) {
        [self setImage:[self PlayImage] forState:UIControlStateNormal];
    }
    return self;
}

-(UIImage*)PlayImage
{
    
    CGSize size = CGSizeMake(50, 50);
    CGRect bounds = CGRectMake(2, 2, 50-4, 50-4);
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(ctx,bounds);
    
    
    CGContextMoveToPoint(ctx, 15, 15);
    CGContextAddLineToPoint(ctx, 15, 35);
    CGContextAddLineToPoint(ctx, 38, 25);
    CGContextClosePath(ctx);
    
    
    
    CGContextSetLineWidth(ctx, 2);
    [RGBACOLOR(255, 255, 255, 0.98) set];
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextStrokePath(ctx);//空心yuan
    
    
    CGContextStrokePath(ctx);
    

    UIImage * image =UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}



-(UIImage*)PauseImage
{
    //暂停图片
    CGSize size2 = CGSizeMake(50, 50);
    CGRect bounds2 = CGRectMake(2, 2, 50-4, 50-4);
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(size2, NO, 0);
    
    CGContextRef ctx2 = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(ctx2,bounds2);
    
    
    CGContextMoveToPoint(ctx2, 50/3, 15);
    CGContextAddLineToPoint(ctx2, 50/3, 35);
    
    CGContextMoveToPoint(ctx2, 2*50/3, 15);
    CGContextAddLineToPoint(ctx2, 2*50/3, 35);

    
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
        make.centerX.equalTo(self.superview);
    }];
}
@end
