//
//  RightViewController.m
//  FlyMusicBox
//
//  Created by 李飞翔 on 16/4/14.
//  Copyright © 2016年 Fly. All rights reserved.
//


#import "RightViewController.h"
#import "UIImage+ImageEffects.h"
#import "UIImageView+LBBlurredImage.h"
#import "BGIMView.h"

#import "AppDelegate.h"
#import "FlySliderVC.h"
@interface RightViewController ()
@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBgImv];
}

-(void)createBgImv
{
    BGIMView * bgv = [[BGIMView alloc] initWithImage:[UIImage imageNamed:@"riBG.jpg"]];
    [self.view addSubview:bgv];
    [bgv make];
}



@end
