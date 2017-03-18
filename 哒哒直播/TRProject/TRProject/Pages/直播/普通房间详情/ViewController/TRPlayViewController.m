//
//  TRPlayViewController.m
//  TRProject
//
//  Created by tarena on 2017/2/4.
//  Copyright © 2017年 Tedu. All rights reserved.
//

#import "TRPlayViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "TRPlayPageVC.h"




@interface TRPlayViewController ()
@property (nonatomic) IJKFFMoviePlayerController *player;
@property (nonatomic) TRRoomModel *roomModel;

#pragma mark - 竖屏相关内容
/** 存放返回按钮, logo标志, 分享按钮的视图 */
@property (nonatomic) UIView *backLogoView;

@property (nonatomic) UIView *statusbarBGView;

/** 控制视频播放 */
@property (nonatomic) UIView *controlView;
@property (nonatomic) UILabel *titleLb;
@property (nonatomic) NSTimer *hideTimer;
@property (nonatomic) UILabel *numberLb;
//下半部分内容
@property (nonatomic) UIView *bottomView;


@property (nonatomic) UIView *chatView;

#pragma mark - 横屏相关内容
//横屏视图
@property (nonatomic) UIView *landscapeView;

@end

@implementation TRPlayViewController


#pragma mark - Life
- (id)initWithRoomId:(NSString *)roomId{
    if (self = [super init]) {
        self.roomId = roomId;
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self.view showHUD];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [NetManager getRoomInfo:_roomId completionHandler:^(TRRoomModel *room, NSError *error) {
        [self.view hideHUD];
        if (error) {
            [self.view showMsg:@"error"];
        }else{
            _roomModel = room;
            [self playVideo];
            _titleLb.text = room.title;
            _numberLb.text = [NSString stringWithFormat:@" %ld ", room.view];
            if (room.view > 10000) {
                _numberLb.text = [NSString stringWithFormat:@" %.1f万 ", room.view / 10000.0];
            }
        }
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [_player play];
    kAppDelegate.oritentationMask = UIInterfaceOrientationMaskAllButUpsideDown;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboradStatusChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.player stop];
    //立刻关闭当前播放器
    [self.player shutdown];
    self.navigationController.navigationBarHidden = NO;
    kAppDelegate.oritentationMask = UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.view endEditing:YES];
    UIDeviceOrientation oritentation = [UIDevice currentDevice].orientation;
    BOOL isLandscape = UIDeviceOrientationIsLandscape(oritentation);
    if (isLandscape) {//横向
        _player.view.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    }else{
        _player.view.frame = CGRectMake(0, 20, kScreenW, kScreenW * .56);
        
    }
    self.landscapeView.hidden = !isLandscape;
    self.controlView.hidden = isLandscape;
    self.backLogoView.hidden = isLandscape;
    self.statusbarBGView.hidden = isLandscape;
    self.bottomView.hidden = isLandscape;
}
#pragma mark - method 
- (void)configUI{
    self.view.backgroundColor = [UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1];
    
    //电池条背景色
    _statusbarBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 20)];
    [self.view addSubview:_statusbarBGView];
    _statusbarBGView.backgroundColor = [UIColor blackColor];
    
    [self controlView];
    [self backLogoView];
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
    //指定图片插入的位置层次
    [self.view insertSubview:_player.view belowSubview:self.controlView];
    _player.view.frame = CGRectMake(0, 20, kScreenW, kScreenW * .56);
    _player.scalingMode = IJKMPMovieScalingModeAspectFill;
    _player.shouldAutoplay = YES;
    [_player prepareToPlay];
    
    [self.view bringSubviewToFront:self.landscapeView];
}

//切换横竖屏
- (void)changeOrientation:sender{
    //iOS默认不允许强制调整屏幕方向, 但是可以通过手段来调用这个私有方法
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        //invocation 是一个方法调用的整体过程
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        //设置调用的方法
        [invocation setSelector:selector];
        //设置调用方法的对象
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationPortrait;
        if (!UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
            val = UIInterfaceOrientationLandscapeRight;
        }
        //设置索引值2对应的参数.  索引值0 存的是target  , 1存的是selector
        [invocation setArgument:&val atIndex:2];
        //启动这个方法调用的过程
        [invocation invoke];
    }
}


#pragma mark - Lazy

- (UIView *)backLogoView {
    if(_backLogoView == nil) {
        _backLogoView = [[UIView alloc] init];
        [self.view addSubview:_backLogoView];
        [_backLogoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.height.equalTo(30);
            make.top.equalTo(20);
        }];
        
        //返回按钮
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"btn_player_sp_back"] forState:UIControlStateNormal];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"btn_player_sp_back_click"] forState:UIControlStateHighlighted];
        [_backLogoView addSubview:backBtn];
        [backBtn bk_addEventHandler:^(id sender) {
            [self.navigationController popViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
            make.size.equalTo(22);
        }];
        
        //分享按钮
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [shareBtn setBackgroundImage:[UIImage imageNamed:@"btn_zhibojian_shu_share"] forState:UIControlStateNormal];
        [shareBtn setBackgroundImage:[UIImage imageNamed:@"btn_zhibojian_shu_share_click"] forState:UIControlStateHighlighted];
        [_backLogoView addSubview:shareBtn];
        [shareBtn bk_addEventHandler:^(id sender) {
            [self.navigationController popViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.centerY.equalTo(0);
            make.size.equalTo(25);
        }];
        
        //logo
        UIImageView *logoIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_shuiyin"]];
        [_backLogoView addSubview:logoIV];
        [logoIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(shareBtn.mas_left).offset(-10);
            make.centerY.equalTo(0);
            make.size.equalTo(CGSizeMake(60, 24));
        }];
    }
    return _backLogoView;
}

- (UIView *)controlView {
    if(_controlView == nil) {
        _controlView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenW, kScreenW * .56)];
        [self.view addSubview:_controlView];
        
        UIView *contentView = [UIView new];
        [_controlView addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
            [UIView animateWithDuration:.2 animations:^{
                contentView.alpha = 1;
            }];
            
            //重置等待时间
            [_hideTimer invalidate];
            //4秒钟后隐藏视图
            _hideTimer = [NSTimer scheduledTimerWithTimeInterval:4 block:^(NSTimer * _Nonnull timer) {
                [UIView animateWithDuration:.2 animations:^{
                    contentView.alpha = 0;
                }];
            } repeats:NO];
        } delay:0];
        [_controlView addGestureRecognizer:tapGR];
        
        //4秒钟后隐藏视图
        _hideTimer = [NSTimer scheduledTimerWithTimeInterval:4 block:^(NSTimer * _Nonnull timer) {
            [UIView animateWithDuration:.2 animations:^{
                contentView.alpha = 0;
            }];
        } repeats:NO];
        
        _titleLb = [UILabel new];
        [contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(35);
            make.top.equalTo(4);
            make.right.equalTo(-110);
        }];
        _titleLb.textColor = [UIColor whiteColor];
        
        UIButton *oritentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [oritentionBtn bk_addEventHandler:^(id sender) {
            [self changeOrientation:sender];
        } forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:oritentionBtn];
        [oritentionBtn setBackgroundImage:[UIImage imageNamed:@"btn_player_sp_qp"] forState:UIControlStateNormal];
        [oritentionBtn setBackgroundImage:[UIImage imageNamed:@"btn_player_sp_qp_click"] forState:UIControlStateHighlighted];
        [oritentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(30);
            make.bottom.equalTo(-4);
            make.right.equalTo(-10);
        }];
        
        _numberLb = [UILabel new];
        _numberLb.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.6];
        _numberLb.textColor = [UIColor whiteColor];
        [contentView addSubview:_numberLb];
        _numberLb.layer.cornerRadius = 4;
        [_numberLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.bottom.equalTo(-4);
            make.height.equalTo(20);
        }];
        _numberLb.font = [UIFont systemFontOfSize:14];
        _numberLb.clipsToBounds = YES;
    }
    return _controlView;
}


- (UIView *)landscapeView {
    if(_landscapeView == nil) {
        _landscapeView = [[UIView alloc] init];
        [self.view addSubview:_landscapeView];
        [_landscapeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        //返回按钮
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"btn_player_sp_back"] forState:UIControlStateNormal];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"btn_player_sp_back_click"] forState:UIControlStateHighlighted];
        [_landscapeView addSubview:backBtn];
        [backBtn bk_addEventHandler:^(id sender) {
            [self changeOrientation:sender];
        } forControlEvents:UIControlEventTouchUpInside];
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.top.equalTo(24);
            make.size.equalTo(22);
        }];
        
        
        /************ 横屏界面要显示的其它UI都写在下方即可 ***************/
        
    }
    return _landscapeView;
}

- (UIView *)bottomView {
    if(_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        [self.view addSubview:_bottomView];
        CGFloat top = kScreenW * .56 + 20;
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.top.equalTo(top);
        }];
        _bottomView.backgroundColor = [UIColor greenColor];
        
        
        TRPlayPageVC *pageVC = [TRPlayPageVC new];
        pageVC.menuViewStyle = WMMenuViewStyleLine;
        UIButton *favorBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        favorBtn.backgroundColor = [UIColor redColor];
        favorBtn.frame = CGRectMake(0, 0, 80, 30);
        
        NSMutableAttributedString *titleStr = [NSMutableAttributedString new];
        NSTextAttachment *attentionImage = [NSTextAttachment new];
        attentionImage.image = @"btn_detail_attention".yx_image;
        attentionImage.bounds = CGRectMake(0, -3, 15, 15);
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attentionImage];
        NSAttributedString *title = [[NSAttributedString alloc] initWithString:@" 关注" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [titleStr appendAttributedString:imageStr];
        [titleStr appendAttributedString:title];
        [favorBtn setAttributedTitle:titleStr forState:UIControlStateNormal];
        /*
         [favorBtn setTitle:@"关注" forState:UIControlStateNormal];
         [favorBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         因为图片本身尺寸太大, 无法用下面方法设置图片
         //注意, 这里是image 不是 backgroundimage
         //image 和title 是左右关系.  backgroundimage 和title是上下关系
         [favorBtn setImage:[UIImage imageNamed:@"btn_detail_attention"] forState:UIControlStateNormal];
         */
        [self addChildViewController:pageVC];
        [_bottomView addSubview:pageVC.view];
        pageVC.viewFrame = CGRectMake(0, 0, kScreenW, kScreenH - kScreenW * .56 - 44 - 20);
        
        //右侧视图必须写在 addSubview设置完毕之后的地方1
        pageVC.menuView.rightView = favorBtn;
        
        _chatView = [UIView new];
        [_bottomView addSubview:_chatView];
        [_chatView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(44);
        }];
        _chatView.backgroundColor = [UIColor whiteColor];
        
        UIButton *emojiBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [emojiBtn setBackgroundImage:[UIImage imageNamed:@"btn_hp_write_emoji"] forState:UIControlStateNormal];
        [_chatView addSubview:emojiBtn];
        [emojiBtn bk_addEventHandler:^(id sender) {
            [self.navigationController popViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        [emojiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
            make.size.equalTo(30);
        }];
        
        UIButton *giftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [giftBtn setBackgroundImage:[UIImage imageNamed:@"navBar_gift-static_image"] forState:UIControlStateNormal];
        [_chatView addSubview:giftBtn];
        [giftBtn bk_addEventHandler:^(id sender) {
            [self.navigationController popViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        [giftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.centerY.equalTo(0);
            make.size.equalTo(25);
        }];
        
        UITextField *tf = [UITextField new];
        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.placeholder = @"不发弹幕真的不寂寞吗?";
        [_chatView addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(60);
            make.right.equalTo(-60);
            make.centerY.equalTo(0);
        }];
        [tf bk_addEventHandler:^(id sender) {
            [tf resignFirstResponder];
        } forControlEvents:UIControlEventEditingDidEndOnExit];
        
        
    }
    return _bottomView;
}

#pragma mark - Keyboard Notification
- (void)keyboradStatusChanged:(NSNotification *)sender{
    NSLog(@"%@", sender);
    NSTimeInterval duration = [sender.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    UIViewAnimationOptions option = [sender.userInfo[@"UIKeyboardAnimationCurveUserInfoKey"] intValue];
    CGRect endFrame = [sender.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    NSLog(@"%f", kScreenH);
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        [_chatView mas_updateConstraints:^(MASConstraintMaker *make) {
            if (endFrame.origin.y == kScreenH) {
                make.bottom.equalTo(0);
            }else{
                make.bottom.equalTo(-endFrame.size.height);
            }
        }];
    } completion:nil];
    //约束制作动画, 必须写下方代码才生效
    [self.view layoutIfNeeded];
}


@end






