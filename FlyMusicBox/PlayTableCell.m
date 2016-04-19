//
//  PlayTableCell.m
//  FlyMusicBox
//
//  Created by 李飞翔 on 16/4/15.
//  Copyright © 2016年 Fly. All rights reserved.
//

#import "PlayTableCell.h"

@implementation PlayTableCell
{
    
    UILabel*name;
    UIView * bgview;
    UILabel*person;

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        bgview = [[UIView alloc] init];
        bgview.backgroundColor=RGBACOLOR(0, 0, 0, 0.3);
        [self.contentView addSubview:bgview];
        [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(5, 10, 5, 10));
        }];
        
        name =[[UILabel alloc] init];
        name.font=[UIFont systemFontOfSize:18];
        name.textColor=[UIColor whiteColor];
        [self.contentView addSubview:name];
        
        
        person =[[UILabel alloc] init];
        person.font=[UIFont systemFontOfSize:15];
        person.textColor=[UIColor whiteColor];
        [self.contentView addSubview:person];
        
        
    }
    return self;
}

-(void)setModel:(MusicModel *)model
{
    _model=model;
    name.text=model.name;
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(bgview).offset(10);
        make.right.equalTo(bgview).offset(-10);
    }];
    
    person.text=model.singerName;
    [person mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(name.mas_bottom).offset(10);
        make.left.equalTo(bgview).offset(10);
        make.right.equalTo(bgview).offset(-10);
        
    }];
    
}


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString * ID=@"PlayTableCell";
    
    PlayTableCell*cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        cell=[[PlayTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
//    cell.selectionStyle = UITableViewCellSelection;

    cell.backgroundColor=RGBACOLOR(0, 0, 0, 0);
    
    return cell;
}



@end
