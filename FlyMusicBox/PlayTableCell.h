//
//  PlayTableCell.h
//  FlyMusicBox
//
//  Created by 李飞翔 on 16/4/15.
//  Copyright © 2016年 Fly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"
@interface PlayTableCell : UITableViewCell

@property(nonatomic,strong)MusicModel * model;
+(instancetype)cellWithTableView:(UITableView*)tableView;

@end
