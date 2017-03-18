//
//  TRYanViewController.m
//  TRProject
//
//  Created by tarena on 2017/2/4.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import "TRYanViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface TRYanViewController ()
@property (nonatomic) IJKFFMoviePlayerController *player;
@property (nonatomic) TRRoomModel *roomModel;

@property (nonatomic) UIButton *closeBtn;
@end

@implementation TRYanViewController

- (id)initWithRoomId:(NSString *)roomId{
    if (self = [super init]) {
        self.roomId = roomId;
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view showHUD];
    self.view.backgroundColor = [UIColor whiteColor];
    [NetManager getRoomInfo:_roomId completionHandler:^(TRRoomModel *room, NSError *error) {
        [self.view hideHUD];
        if (error) {
            [self.view showMsg:@"ssdf"];
        }else{
            _roomModel = room;
            [self playVideo];
        }
    }];
    
    //关闭按钮
    _closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_closeBtn setBackgroundImage:[UIImage imageNamed:@"btn_hp_guanggao_close"] forState:UIControlStateNormal];
    [self.view addSubview:_closeBtn];
    [_closeBtn bk_addEventHandler:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-10);
        make.top.equalTo(20);
        make.size.equalTo(28);
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)playVideo{
    NSString *videoPath = @"";
    videoPath = _roomModel.live.ws.hls.three.src;
    if (!videoPath) {
        videoPath = _roomModel.live.ws.hls.four.src;
    }
    if (!videoPath) {
        videoPath = _roomModel.live.ws.hls.five.src;
    }
    NSLog(@"%@", videoPath);
    
    _player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:videoPath withOptions:[IJKFFOptions optionsByDefault]];
    [self.view addSubview:_player.view];
    [_player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    _player.scalingMode = IJKMPMovieScalingModeAspectFill;
    _player.shouldAutoplay = YES;
    [_player prepareToPlay];
    //防止播放视图把关闭按钮遮盖住, 所以强制把关闭按钮挪到最上面
    [self.view bringSubviewToFront:_closeBtn];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [_player play];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.player stop];
    //立刻关闭当前播放器
    [self.player shutdown];
    self.navigationController.navigationBarHidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
