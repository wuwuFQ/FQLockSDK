//
//  FQLockGestureViewController.m
//  FQUtils
//
//  Created by wuwuFQ on 2022/9/17.
//

#import "FQLockGestureViewController.h"
#import "UIColor+RGB.h"
#import <FQLockSDK/FQLockSDK.h>
#import "FQLockHelper.h"

#define kPassword @"FQ_PASSWORD"

@interface FQLockGestureViewController ()<FQGestureLockViewDelegate>
@property (nonatomic, strong) FQLockGestureView *lockView;
@property (nonatomic, strong) FQLockConfig *lockConfig;
@property (nonatomic, strong) UILabel *msgLabel;
@property (nonatomic, strong) UIButton *forget_button;

@end

@implementation FQLockGestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initLockView];
    
    if (self.lockType == FQGestureLockTypeReset) {
        self.title = @"修改手势密码";
    } else if (self.lockType == FQGestureLockTypeClose) {
        self.title = @"关闭手势密码";
    } else {
        self.title = @"设置手势密码";
    }
}


- (void)initLockView {
    self.lockConfig = [[FQLockConfig alloc] init];
    self.lockConfig.lockType = self.lockType;
    //你的APP业务逻辑和用户无关，就可以全程不用userID
    self.lockConfig.passwordKey = [NSString stringWithFormat:@"%@_%@", kPassword, self.userID];
    self.lockConfig.lockViewCenterY = self.view.frame.size.height * 0.5;
    self.lockView = [[FQLockGestureView alloc] initWithConfig:self.lockConfig];
    self.lockView.delegate = self;
    [self.view addSubview:self.lockView];
    
    self.msgLabel = [UILabel new];
    [self.view addSubview:self.msgLabel];
    self.msgLabel.frame = CGRectMake(0, self.lockView.frame.origin.y - 50 - 20, self.view.frame.size.width, 20);
    self.msgLabel.textColor = [UIColor colorFromHexString:@"#939599"];
    self.msgLabel.font = [UIFont systemFontOfSize:14];
    self.msgLabel.textAlignment = NSTextAlignmentCenter;
    self.msgLabel.text = NSLocalizedString(@"绘制解锁图案", nil);
    if (self.lockType == FQGestureLockTypeReset) {
        self.msgLabel.text = NSLocalizedString(@"请绘制原手势密码", nil);
    }
    
    if (self.lockType == FQGestureLockTypeLogin) {
        if ([FQLockHelper isLocalGestureEnableForUserId:self.userID]) {
            UIButton *forget_button = [[UIButton alloc] init];
            forget_button.frame = CGRectMake(16, self.view.frame.size.height - 50, 90, 20);
            [forget_button setTitle:NSLocalizedString(@"忘记手势密码", nil) forState:UIControlStateNormal];
            [forget_button setTitleColor:[UIColor colorFromHexString:@"#0984F9"] forState:UIControlStateNormal];
            forget_button.titleLabel.font = [UIFont systemFontOfSize:14];
            [forget_button addTarget:self action:@selector(forget_buttonClick) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:forget_button];
            
            if ([FQLockHelper isBiometryAuthEnableForUserId:self.userID]) {
                NSString *desStr;
                if ([FQBiometryContext biometryType] == FQBiometryTypeTouchID) {
                    desStr = NSLocalizedString(@"指纹解锁", nil);
                } else if ([FQBiometryContext biometryType] == FQBiometryTypeFaceID) {
                    desStr = NSLocalizedString(@"面容ID解锁", nil);
                }
                UIButton *faceID_button = [[UIButton alloc] init];
                faceID_button.frame = CGRectMake(self.view.frame.size.width *0.5 - 45, self.view.frame.size.height - 50, 90, 20);
                [faceID_button setTitle:desStr forState:UIControlStateNormal];
                [faceID_button setTitleColor:[UIColor colorFromHexString:@"#0984F9"] forState:UIControlStateNormal];
                faceID_button.titleLabel.font = [UIFont systemFontOfSize:14];
                [faceID_button addTarget:self action:@selector(faceID_buttonClick) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:faceID_button];
                [self faceID_buttonClick];
            }
            
            UIButton *switch_button = [[UIButton alloc] init];
            switch_button.frame = CGRectMake(self.view.frame.size.width - 90 - 16, self.view.frame.size.height - 50, 90, 20);
            [switch_button setTitle:NSLocalizedString(@"切换其他账号", nil) forState:UIControlStateNormal];
            [switch_button setTitleColor:[UIColor colorFromHexString:@"#0984F9"] forState:UIControlStateNormal];
            switch_button.titleLabel.font = [UIFont systemFontOfSize:14];
            [switch_button addTarget:self action:@selector(switch_buttonClick) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:switch_button];
        } else {
            self.lockView.hidden = YES;
            self.msgLabel.hidden = YES;
            if ([FQLockHelper isBiometryAuthEnableForUserId:self.userID]) {
                UILabel *reason_label = [UILabel new];
                [self.view addSubview:reason_label];
                reason_label.frame = CGRectMake(0, 0, self.view.frame.size.width, 30);
                reason_label.center = self.view.center;
                reason_label.textAlignment = NSTextAlignmentCenter;
                reason_label.font = [UIFont systemFontOfSize:14];
                reason_label.textColor = [UIColor colorFromHexString:@"#939599"];
                reason_label.text = NSLocalizedString(@"点击进行指纹解锁", nil);
                
                UIButton *authBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [authBtn setImage:[UIImage imageNamed:@"icon_finger"] forState:UIControlStateNormal];
                authBtn.frame = CGRectMake(self.view.frame.size.width *0.5 - 40, reason_label.frame.origin.y -10 - 80, 80, 80);
                authBtn.highlighted = NO;
                [self.view addSubview:authBtn];
                authBtn.tag = 100;
                [authBtn addTarget:self action:@selector(authBtnClick) forControlEvents:UIControlEventTouchUpInside];
                
                if ([FQBiometryContext biometryType] == FQBiometryTypeFaceID) {
                    reason_label.text = NSLocalizedString(@"点击进行面容ID解锁", nil);
                    [authBtn setImage:[UIImage imageNamed:@"icon_faceid"] forState:UIControlStateNormal];
                    authBtn.tag = 200;
                }
                
                UIButton *switch_button = [[UIButton alloc] init];
                switch_button.frame = CGRectMake(self.view.frame.size.width *0.5 - 45, self.view.frame.size.height - 50, 90, 20);
                [switch_button setTitle:NSLocalizedString(@"切换其他账号", nil) forState:UIControlStateNormal];
                [switch_button setTitleColor:[UIColor colorFromHexString:@"#0984F9"] forState:UIControlStateNormal];
                switch_button.titleLabel.font = [UIFont systemFontOfSize:14];
                [switch_button addTarget:self action:@selector(switch_buttonClick) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:switch_button];
                [self faceID_buttonClick];
            }
        }
    }
    
    if (self.lockType == FQGestureLockTypeReset) {
        UIButton *forget_button = [[UIButton alloc] init];
        forget_button.frame = CGRectMake(self.view.frame.size.width *0.5 - 45, self.view.frame.size.height - 50, 90, 20);
        [forget_button setTitle:NSLocalizedString(@"忘记手势密码", nil) forState:UIControlStateNormal];
        [forget_button setTitleColor:[UIColor colorFromHexString:@"#0984F9"] forState:UIControlStateNormal];
        forget_button.titleLabel.font = [UIFont systemFontOfSize:14];
        [forget_button addTarget:self action:@selector(forget_buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:forget_button];
        self.forget_button = forget_button;
    }
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)faceID_buttonClick {
    __weak typeof(self) weakSelf = self;
    [FQBiometryContext biometryAuthWithSucceedHandler:^{
        if (weakSelf.localLockBlock) {
            weakSelf.localLockBlock(YES);
        }
    } failureHandler:^(FQBiometryError errorCode) {
        
    }];
}

- (void)forget_buttonClick {
//    [FQAlertController showAlertWithController:self style:nil title:@"忘记手势密码" message:@"忘记手势密码需要重新登录，登录后锁屏保护自动关闭" leftActionText:@"取消" rightActionText:@"重新登录" leftActionHandler:^{
//
//    } rightActionHandler:^{
//        [TKLocalAuthHelper setLocalAuthEnable:NO forUserId:[self.authDelegate userId]];
//        [TKLocalAuthHelper setLocalGestureEnable:NO forUserId:[self.authDelegate userId]];
//        [self.authDelegate logoutAndShowLoginWithIdentity];
//    }];
}

- (void)switch_buttonClick {
//    [FQAlertController showAlertWithController:self style:nil title:@"切换其他账号" message:@"是否要切换其他账号登录" leftActionText:@"取消" rightActionText:@"登录" leftActionHandler:^{
//
//    } rightActionHandler:^{
//        [self.authDelegate logoutAndShowLoginWithIdentity];
//    }];
}

- (void)authBtnClick {
    __weak typeof(self) weakSelf = self;
    [FQBiometryContext biometryAuthWithSucceedHandler:^{
        if (weakSelf.localLockBlock) {
            weakSelf.localLockBlock(YES);
        }
    } failureHandler:^(FQBiometryError errorCode) {
        
    }];
}

#pragma mark - <FQGestureLockViewDelegate>

/// 连线个数少于最少连接数，通知代理
/// @param view LockView
/// @param type <#type description#>
/// @param gesture 手势密码
- (void)fq_gestureLockView:(FQLockGestureView *)view type:(FQGestureLockType)type connectNumberLessThanNeedWithGesture:(NSString *)gesture {
    self.msgLabel.text = NSLocalizedString(@"至少连接4个点，请重新绘制", nil);
    self.msgLabel.textColor = [UIColor colorFromHexString:@"#FF4040"];
}

/// 第一次设置手势密码
/// @param view LockView
/// @param type <#type description#>
/// @param gesture 第一次手势密码
- (void)fq_gestureLockView:(FQLockGestureView *)view type:(FQGestureLockType)type didCompleteSetFirstGesture:(NSString *)gesture {
    self.msgLabel.text = NSLocalizedString(@"再次绘制解锁图案", nil);
    self.msgLabel.textColor = [UIColor colorFromHexString:@"#939599"];
}

/// 第二次设置手势密码
/// @param view LockView
/// @param type <#type description#>
/// @param gesture 第二次手势密码
/// @param equal 第二次和第一次的手势密码匹配结果
- (void)fq_gestureLockView:(FQLockGestureView *)view type:(FQGestureLockType)type didCompleteSetSecondGesture:(NSString *)gesture result:(BOOL)equal {
    if (equal) {
        [FQLockHelper setLocalGestureEnable:YES forUserId:self.userID];
        self.msgLabel.text = NSLocalizedString(@"设置成功", nil);
        self.msgLabel.textColor = [UIColor colorFromHexString:@"#939599"];
        if (self.localLockBlock) {
            self.localLockBlock(YES);
        }
        [self performSelector:@selector(goBack) withObject:nil afterDelay:0.5];
        
    } else {
        self.msgLabel.text = NSLocalizedString(@"与上一次绘制不一致，请重新绘制", nil);
        self.msgLabel.textColor = [UIColor colorFromHexString:@"#FF4040"];
    }
}

/// 验证手势密码
/// - Parameters:
///   - view: LockView
///   - type: <#type description#>
///   - gesture: 验证的手势密码
///   - equal: 验证是否通过
- (void)fq_gestureLockView:(FQLockGestureView *)view type:(FQGestureLockType)type didCompleteVerifyGesture:(NSString *)gesture result:(BOOL)equal {
    if (equal) {
        self.forget_button.hidden = YES;
        self.msgLabel.text = NSLocalizedString(@"绘制解锁图案", nil);
        self.msgLabel.textColor = [UIColor colorFromHexString:@"#939599"];
        
        if (type == FQGestureLockTypeClose) {
            [FQLockHelper setLocalGestureEnable:NO forUserId:self.userID];
            [self performSelector:@selector(goBack) withObject:nil afterDelay:0.5];
        }
        if (type != FQGestureLockTypeReset) {
            if (self.localLockBlock) {
                self.localLockBlock(YES);
            }
        }
    } else {
        self.msgLabel.text = NSLocalizedString(@"密码错误，请重新绘制", nil);
        self.msgLabel.textColor = [UIColor colorFromHexString:@"#FF4040"];
    }
}

@end
