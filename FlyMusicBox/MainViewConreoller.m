//
//  MainViewConreoller.m
//  FlyMusicBox
//
//  Created by 李飞翔 on 16/4/13.
//  Copyright © 2016年 Fly. All rights reserved.
//
#define  ASTR @"http://123.125.110.148/mobileoc.music.tc.qq.com/C400003XYcCu3IZKLc.m4a?continfo=98C55A6DD9FE733FF53DFB07FF0CDE57BD1C4873CBD1F2FF&vkey=9F4D7CBF9A801A8ADEE7EF020A42BEBA74AAF0E30A93B1F94731C90CE761BBE71627C7CA0C7228E533075C09225A4ED23964F78902F75A93&guid=6748CA609687429C9B1936265B52A1C4&uin=1985228464&fromtag=53"

#import "MainViewConreoller.h"
#import <AVFoundation/AVFoundation.h>
#import "FSAudioStream.h"
#import "BGImageView.h"
#import "Play.h"
#import "MusicModel.h"
#import "AppDelegate.h"
#import "FlySliderVC.h"
#import "NextButton.h"
@interface MainViewConreoller ()

@property(nonatomic,strong)FSAudioStream *audioStream;
@property(nonatomic,strong)MusicModel *model;
@property(nonatomic,strong)NSMutableArray *dataArray;
//创建全局属性的ShapeLayer
@property (nonatomic, strong) CAShapeLayer *shapeLayer;



@end

@implementation MainViewConreoller
{
    CABasicAnimation*ani;
    NSTimer * timer1 ;
    BGImageView * bgimageview;
    NSString * urlStr;
    Play * playView;
    NextButton * nextButon;
    UILabel * title;
    int number;
    UISlider * slider;
    UISlider * slider2;
    UIImageView * cdImageV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createData];
    [self BGImageView];
    [self createUI];
    [self createAudioSession];
    [self createSlider];
    [self createNsnotification];
    [self createAnimation];
    [self createTimer];


}
-(void)createTimer
{
    timer1 =  [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeValue) userInfo:nil repeats:YES];
}
-(void)createData
{
    number=0;
    _dataArray=[[NSMutableArray alloc] init];
}
-(void)createNsnotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playmusic:) name:@"playMusic" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(musicTable:) name:@"musicTable" object:nil];

}
-(void)musicTable:(NSNotification*)noti{
    NSDictionary * dict = [noti userInfo];
    _dataArray = dict[@"musicTable"];
 
    
    
}
-(void)playmusic:(NSNotification*)noti{
    
    [UIView animateWithDuration:0.1 animations:^{
        
//        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height ,);

        AppDelegate * apd = [UIApplication sharedApplication].delegate;
        UINavigationController * nvc =  (UINavigationController * )apd.window.rootViewController;
        FlySliderVC * flysvc =[nvc.viewControllers lastObject];
        flysvc.mainV.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);

    }];

    NSDictionary * dict = [noti userInfo];
    _model = dict[@"mode"];
    title.text=[NSString stringWithFormat:@"%@",_model.name];
    [_audioStream stop];
    [self createFsaudioStream:_model.url];
}
-(void)createSlider
{
    
    slider=[[UISlider alloc] init];
    [slider setThumbImage:[UIImage imageNamed:@"Sliderthumb"] forState:UIControlStateNormal];//设置了普通状态和高亮状态的滑轮样式
    [slider addTarget:self action:@selector(SliderChangeDown) forControlEvents:UIControlEventTouchDown];
    [slider addTarget:self action:@selector(SliderChangeUpInsid) forControlEvents:UIControlEventTouchUpInside];
    slider.minimumValue = 0.0;
    slider.maximumValue = 1.0;
    [self.view addSubview:slider];

    slider.minimumTrackTintColor =RGBACOLOR(87, 204, 181, 0.9);
    slider.maximumTrackTintColor =RGBACOLOR(255, 255, 255, 0.5);
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.bottom.equalTo(playView.mas_top).offset(-20);
    }];
    slider.userInteractionEnabled=YES;
    
    
    
    slider2=[[UISlider alloc] init];
//    [slider2 setThumbImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];//设置了普通状态和高亮状态的滑轮样式
    slider2.thumbTintColor=RGBACOLOR(32, 114, 231, 0.8);
    [slider2 addTarget:self action:@selector(SliderChangeValue) forControlEvents:UIControlEventValueChanged];

    
    slider2.minimumTrackTintColor =RGBACOLOR(76, 142, 39, 0.8);
    slider2.maximumTrackTintColor =RGBACOLOR(255, 255, 255, 0.5);
    slider2.minimumValue = 0.0;
    slider2.maximumValue = 1.0;
   
    [self.view addSubview:slider2];
    [slider2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(playView.mas_left).offset(-20);
        make.centerY.equalTo(playView.mas_centerY);
    }];
    
}

-(void)createFsaudioStream:(NSString*)str
{
    __weak Play * play2 = playView;
    _audioStream=[FlyFSAudioStream shareFlyFSAudioStream];
    [_audioStream playFromURL:[NSURL URLWithString:str]];
   

    //监测播放状态
//    FSStreamPosition
//    float a =playbackTimeInSeconds;
    __weak FSAudioStream * _audioStream2= _audioStream;
    _audioStream.onFailure=^(FSAudioStreamError error, NSString *errorDescription){
        NSLog(@"error! %@ errorID:%d",errorDescription,error);
    };
    _audioStream.onStateChange=^(FSAudioStreamState state)
    {
        NSLog(@"FSAudioStreamState:%ld",state);
        if (state==kFsAudioStreamPlaying) {
            
            /**
             * Playing.播放中
             */
            [self createAnimationZhuan];
            
            [play2 setImage:[play2 PauseImage]  forState:UIControlStateNormal];

        }else if (state==kFsAudioStreamPlaybackCompleted){

            /**
             * Playback completed.*播放完成。
             */
            if (_audioStream2.isPlaying) {
                [_audioStream2 stop];
            }
            number++;
            
            if (number>=_dataArray.count)
            {
                number=0;
            }
            MusicModel * model =_dataArray[number];
            title.text=[NSString stringWithFormat:@"%@",model.name];
            
            [_audioStream2 playFromURL:[NSURL URLWithString:model.url]];

            
        }else if (state==kFsAudioStreamBuffering)
        {
            //Buffering.*缓冲。


        }else if (state==kFsAudioStreamRetrievingURL)
        {
            // Retrieving URL.*检索URL。
           
            
        }else if (state==kFsAudioStreamUnknownState)
        {
            
            /**
             * Unknown state.*未知状态。
             */


        }else if (state==kFsAudioStreamRetryingFailed)
        {
            
            /**
             * Retrying failed.*重新尝试失败了。
             */

        }
        else if (state==kFsAudioStreamRetryingSucceeded)
        {
            
            /**
             * Retrying succeeded.*重新尝试成功了。
             */
            [_audioStream play];
        }
        else if (state==kFsAudioStreamRetryingStarted)
        {
            
            /**
             * Started retrying.*开始进行重试。
             */

        }
        else if (state==kFsAudioStreamFailed)
        {
            /**
             * Failed.*失败了。
             */

        }
        else if (state==kFSAudioStreamEndOfFile)
        {
            /**
             * The stream has received all the data for a file.*流已经收到了所有的数据文件。
             */
            NSLog(@"流已经收到了所有的数据文件");

            
            
        }
        else if (state==kFsAudioStreamSeeking)
        {
            
            /**
             * Seeking.*寻求。
             */

            
        }
        else if(kFsAudioStreamPaused==state){
            //暂停
            [cdImageV.layer removeAllAnimations];

            [play2 setImage:[play2 PlayImage]  forState:UIControlStateNormal];
//
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    
//                if (![_audioStream isPlaying]) {
//                    [[AVAudioSession sharedInstance]setActive:NO error:nil];
//                }
//            });
            
            
        }else if(kFsAudioStreamStopped==state){
            
            [cdImageV.layer removeAllAnimations];

            //停止
//            [play2 setImage:[play2 PlayImage]  forState:UIControlStateNormal];
//
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                
//                if (![_audioStream isPlaying]) {
//                    [[AVAudioSession sharedInstance]setActive:NO error:nil];
//                }
//            });
            
            
        }
        
         
    };
    

}
-(void)changeValue
{
//
//    NSLog(@" 播放百分比 %f",_audioStream.currentTimePlayed.position);
//    NSLog(@" 播放时间 %u",_audioStream.currentTimePlayed.second);
    //将播放进度赋值给slider
    slider.value=_audioStream.currentSeekByteOffset.position;
    self.shapeLayer.strokeStart = _audioStream.currentSeekByteOffset.position;
    
}
-(void)createAudioSession
{
    //会话，使其后台播放
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
}
-(void)createUI
{
    playView=[[Play alloc] init];
    [self.view addSubview:playView];
    [playView make];
    [playView addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    
    nextButon = [[NextButton alloc] init];
    [self.view addSubview:nextButon];
    [nextButon make];
    [nextButon addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)nextClick
{
    
    if (_audioStream.isPlaying) {
        [_audioStream stop];
    }

    number++;
    
    if (number>=_dataArray.count)
    {
        number=0;
    }
    MusicModel * model =_dataArray[number];
    title.text=[NSString stringWithFormat:@"%@",model.name];
    
    
    [_audioStream playFromURL:[NSURL URLWithString:model.url]];
    
    
}
-(void)pause
{
    if (!_audioStream) {
        MusicModel * model =_dataArray[number];
        title.text=[NSString stringWithFormat:@"%@",model.name];
        [self createFsaudioStream:model.url];
        [UIView animateWithDuration:0.2 animations:^{
            _audioStream.volume=0.5;
            slider2.value = _audioStream.volume;
        }];
    }else{
        [_audioStream pause];

    }
    
    
    
    
}
-(void)BGImageView
{
   bgimageview = [[BGImageView alloc] initWithImage:[UIImage imageNamed:@"main"]];
   [self.view addSubview:bgimageview];
   [bgimageview make];
    
    title = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 25, 150, 30)];
    title.font=[UIFont systemFontOfSize:19];
    title.textColor=[UIColor whiteColor];

    [bgimageview addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgimageview.mas_centerX).offset(0);
        make.top.equalTo(bgimageview).offset(25);
    }];
    
}

-(void)SliderChangeDown
{
    [timer1 setFireDate:[NSDate distantFuture]];


}

-(void)SliderChangeUpInsid
{
    FSStreamPosition fss;
    fss.position=slider.value;


    [_audioStream seekToPosition:fss];

    NSLog(@"定时器开启");
    [timer1 setFireDate:[NSDate distantPast]];

}
-(void)SliderChangeValue
{
    [_audioStream setVolume:slider2.value];
}

//
//启动定时器
//[timer2 setFireDate:[NSDate distantPast]];
//暂停定时器
//[timer2 setFireDate:[NSDate distantFuture]];


-(void)createAnimation
{
    //    cdImage
    cdImageV=[[UIImageView alloc] init];
    cdImageV.image=[UIImage imageNamed:@"cdImage"];
    [self.view addSubview:cdImageV];
    [cdImageV mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(280, 280));
        
    }];
    cdImageV.layer.cornerRadius=280/2;
    cdImageV.layer.masksToBounds=YES;
    
    
  



    //创建出CAShapeLayer
    self.shapeLayer = [CAShapeLayer layer];
    
    
    


    self.shapeLayer.frame = CGRectMake((self.view.frame.size.width-290)/2,95, 290, 290);//设置shapeLayer的尺寸和位置
    
    
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    
    //设置线条的宽度和颜色
    self.shapeLayer.lineWidth = 5.0f;
    self.shapeLayer.strokeColor = RGBACOLOR(250, 250, 250, 0.25).CGColor;
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:self.shapeLayer.bounds];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    self.shapeLayer.path = circlePath.CGPath;
    
    self.shapeLayer.strokeStart = 0.0;
    
    
    //添加并显示
    [self.view.layer addSublayer:self.shapeLayer];
    

}

-(void)createAnimationZhuan
{
    //添加旋转动画
    ani=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //设置值
    ani.toValue=[NSNumber numberWithFloat:M_PI*4];
    //设置转多少次
    ani.repeatCount=10000;
    //设置动画时间
    ani.duration=4;
    [cdImageV.layer addAnimation:ani forKey:@"ani"];
    //    ani.removedOnCompletion =YES;
}




@end
