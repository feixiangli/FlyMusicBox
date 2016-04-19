//
//  FlyFSAudioStream.m
//  FlyMusicBox
//
//  Created by 李飞翔 on 16/4/15.
//  Copyright © 2016年 Fly. All rights reserved.
//

#import "FlyFSAudioStream.h"
static FlyFSAudioStream * manager = nil;
@implementation FlyFSAudioStream
+(instancetype)shareFlyFSAudioStream{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager= [[FlyFSAudioStream alloc] init];
        
    });
    return manager;
}

@end
