//
//  LeftViewController.m
//  FlyMusicBox
//
//  Created by 李飞翔 on 16/4/14.
//  Copyright © 2016年 Fly. All rights reserved.
//

#import "LeftViewController.h"
#import "BGIMView.h"
#import "PlayTableCell.h"
#import "MusicModel.h"
@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBgImv];
    [self createData];
    [self createTableview];
    [self performSelector:@selector(createNsnotification) withObject:nil afterDelay:1];
}
-(void)createNsnotification{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"musicTable" object:nil userInfo:@{@"musicTable":_dataArray}];
}
-(void)createData
{
    
    _dataArray=[[NSMutableArray alloc] init];
    NSArray * urlArray=@[@"http://123.125.110.148/mobileoc.music.tc.qq.com/C400003BECkf4LOgGw.m4a?continfo=3C38FBC7884AB753F6531108A8E85E67DEAAAA31A01E2DCC&vkey=9F4D7CBF9A801A8ADEE7EF020A42BEBA74AAF0E30A93B1F94731C90CE761BBE71627C7CA0C7228E533075C09225A4ED23964F78902F75A93&guid=6748CA609687429C9B1936265B52A1C4&uin=1985228464&fromtag=53",@"http://123.125.110.148/mobileoc.music.tc.qq.com/C400003XYcCu3IZKLc.m4a?continfo=98C55A6DD9FE733FF53DFB07FF0CDE57BD1C4873CBD1F2FF&vkey=9F4D7CBF9A801A8ADEE7EF020A42BEBA74AAF0E30A93B1F94731C90CE761BBE71627C7CA0C7228E533075C09225A4ED23964F78902F75A93&guid=6748CA609687429C9B1936265B52A1C4&uin=1985228464&fromtag=53",@"http://123.125.110.148/mobileoc.music.tc.qq.com/C400000bb4fp0qHlpz.m4a?continfo=73D1234D2E0B46163A1C3BE9A33F7B5C6392A3E60E4B8C18&vkey=9F4D7CBF9A801A8ADEE7EF020A42BEBA74AAF0E30A93B1F94731C90CE761BBE71627C7CA0C7228E533075C09225A4ED23964F78902F75A93&guid=6748CA609687429C9B1936265B52A1C4&uin=1985228464&fromtag=53",@"http://123.125.110.148/mobileoc.music.tc.qq.com/C400002Vyfqp1FKgH0.m4a?continfo=D959F15C349E4D8D2052E527913E4EFD9262F3E6EE54058F&vkey=9F4D7CBF9A801A8ADEE7EF020A42BEBA74AAF0E30A93B1F94731C90CE761BBE71627C7CA0C7228E533075C09225A4ED23964F78902F75A93&guid=6748CA609687429C9B1936265B52A1C4&uin=1985228464&fromtag=53",@"http://ws.stream.qqmusic.qq.com/C400002Y9wnU1jIP5N.m4a?continfo=0ADF9BB4E445C4F091C08ECF83724164685F3D8D2E650CA5&vkey=9F4D7CBF9A801A8ADEE7EF020A42BEBA74AAF0E30A93B1F94731C90CE761BBE71627C7CA0C7228E533075C09225A4ED23964F78902F75A93&guid=6748CA609687429C9B1936265B52A1C4&uin=1985228464&fromtag=53",@"http://cc.stream.qqmusic.qq.com/C400003uwCDa0Mr6g9.m4a?continfo=A21E533F95B905C5DD2A16468AC210A6B6B31E3AB91149B8&vkey=9F4D7CBF9A801A8ADEE7EF020A42BEBA74AAF0E30A93B1F94731C90CE761BBE71627C7CA0C7228E533075C09225A4ED23964F78902F75A93&guid=6748CA609687429C9B1936265B52A1C4&uin=1985228464&fromtag=53",@"http://123.125.110.148/mobileoc.music.tc.qq.com/C400003rBWmt0H6W3P.m4a?continfo=CF851E59629262887FEDFAC6EDE9DB21558B27EA89BE7EA8&vkey=9F4D7CBF9A801A8ADEE7EF020A42BEBA74AAF0E30A93B1F94731C90CE761BBE71627C7CA0C7228E533075C09225A4ED23964F78902F75A93&guid=6748CA609687429C9B1936265B52A1C4&uin=1985228464&fromtag=53",@"http://123.125.110.148/mobileoc.music.tc.qq.com/C400000QwTVo0YHdcP.m4a?continfo=EF294CA739FC7382CDF8CAEF2085DA74A4EBC5B14FE897A5&vkey=9F4D7CBF9A801A8ADEE7EF020A42BEBA74AAF0E30A93B1F94731C90CE761BBE71627C7CA0C7228E533075C09225A4ED23964F78902F75A93&guid=6748CA609687429C9B1936265B52A1C4&uin=1985228464&fromtag=53",@"http://123.125.110.148/mobileoc.music.tc.qq.com/C400002BWGZQ2UKjKn.m4a?continfo=92F7233537D57EA0A778A3C70CE6864FBACEB387F4CBE9A0&vkey=9F4D7CBF9A801A8ADEE7EF020A42BEBA74AAF0E30A93B1F94731C90CE761BBE71627C7CA0C7228E533075C09225A4ED23964F78902F75A93&guid=6748CA609687429C9B1936265B52A1C4&uin=1985228464&fromtag=53",@"http://cc.stream.qqmusic.qq.com/C400000ASEZF3AaLN5.m4a?continfo=2066F248746A758F52EBDF5B37B7B8C061820A7F51429538&vkey=9F4D7CBF9A801A8ADEE7EF020A42BEBA74AAF0E30A93B1F94731C90CE761BBE71627C7CA0C7228E533075C09225A4ED23964F78902F75A93&guid=6748CA609687429C9B1936265B52A1C4&uin=1985228464&fromtag=53",@"http://cc.stream.qqmusic.qq.com/C400001GVjMw2SduL8.m4a?continfo=737C140297214386C42AA2E986147F255D60E031B40B5A87&vkey=9F4D7CBF9A801A8ADEE7EF020A42BEBA74AAF0E30A93B1F94731C90CE761BBE71627C7CA0C7228E533075C09225A4ED23964F78902F75A93&guid=6748CA609687429C9B1936265B52A1C4&uin=1985228464&fromtag=53",@"http://cc.stream.qqmusic.qq.com/C200001fzNOv1WXiiU.m4a?continfo=9309C5923AF3F9DC4C13174283752BE3DE850662533C14AC&vkey=9F4D7CBF9A801A8ADEE7EF020A42BEBA74AAF0E30A93B1F94731C90CE761BBE71627C7CA0C7228E533075C09225A4ED23964F78902F75A93&guid=6748CA609687429C9B1936265B52A1C4&uin=1985228464&fromtag=53"];
    
    NSArray * musicName =@[@"睡在我上铺的兄弟",@"虎口脱险",@"同桌的你",@"旅途",@"有多远走多远",@"要死就一定要死在你手里",@"赌局",@"丑八怪",@"你还要我怎样",@"单身情歌",@"卷珠帘",@"让"];
    NSArray * person =@[@"老狼",@"老狼",@"老狼",@"朴树",@"老狼",@"无名",@"中国好歌曲",@"薛之谦",@"薛之谦",@"林志炫",@"霍尊",@"萧煌奇"];
    for (int i =0; i<person.count; i++) {
        MusicModel * model =[[MusicModel alloc] init];
        model.url=urlArray[i];
        model.name=musicName[i];
        model.singerName=person[i];
        [_dataArray addObject:model];
        
    }
    
}
-(void)createTableview
{
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=RGBACOLOR(0, 0, 0, 0);
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width*0.7, self.view.frame.size.height));
        make.top.equalTo(self.view).offset(64);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

-(void)createBgImv
{
    BGIMView * bgv = [[BGIMView alloc] initWithImage:[UIImage imageNamed:@"leftBGview.jpg"]];
    [self.view addSubview:bgv];
    [bgv make];
    
    UILabel * title = [[UILabel alloc] init];
    title.font=[UIFont systemFontOfSize:19];
    title.textColor=[UIColor whiteColor];
    title.text=@"播放列表";
    [bgv addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgv.mas_centerX).offset(-65);
        make.top.equalTo(bgv).offset(25);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayTableCell *cell = [PlayTableCell cellWithTableView:tableView];
    cell.model=_dataArray[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"playMusic" object:nil userInfo:@{@"mode":_dataArray[indexPath.row]}];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


















@end
