//
//  FlySliderVC.h
//  FlyMusicBox
//
//  Created by 李飞翔 on 16/4/14.
//  Copyright © 2016年 Fly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlySliderVC : UIViewController
/**
 初始化滑动视图控制器
 */
@property (nonatomic, weak, readonly) UIView *mainV;
@property (nonatomic, weak, readonly) UIView *leftV;
@property (nonatomic, weak, readonly) UIView *rightV;

-(instancetype)initSetMain:(UIViewController*)mvc Left:(UIViewController*)lvc  Right:(UIViewController*)rvc;


@end
