//
//  LeftBGIMView.m
//  FlyMusicBox
//
//  Created by 李飞翔 on 16/4/15.
//  Copyright © 2016年 Fly. All rights reserved.
//

#import "BGIMView.h"

@implementation BGIMView


-(instancetype)initWithImage:(UIImage *)image;
{
    if (self=[super initWithImage:image]) {
    }
    return self;
}

-(void)make{
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.superview).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];    
}

@end
