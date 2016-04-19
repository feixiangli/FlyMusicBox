//
//  FlyMusicTableSingle.m
//  FlyMusicBox
//
//  Created by 李飞翔 on 16/4/15.
//  Copyright © 2016年 Fly. All rights reserved.
//

#import "FlyMusicTableSingle.h"
static FlyMusicTableSingle * manager=nil;
@implementation FlyMusicTableSingle
+(instancetype)shareManager
{
    static  dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[FlyMusicTableSingle alloc] init];
    });
    return manager;
}
@end
