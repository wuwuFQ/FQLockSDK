//
//  ViewController.m
//  FQLockSDKDemo
//
//  Created by TKiOS on 2022/9/27.
//

#import "ViewController.h"
#import <FQLockSDK/FQLockSDK.h>
#import "FQLockGestureViewController.h"
#import "FQLockHelper.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UISwitch *gestureSwitch;
@property (nonatomic, strong) UISwitch *faceIDSwitch;

@property (nonatomic, copy) NSString *userID;

@property (nonatomic, strong) UITableView *listView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.userID = @"1";//根据自己的业务自定义就行
    
    self.listView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.listView.rowHeight = 50;
    self.listView.delegate = self;
    self.listView.dataSource = self;
    [self.view addSubview:self.listView];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.listView reloadData];
    
    [self.gestureSwitch setOn:[FQLockHelper isLocalGestureEnableForUserId:self.userID]];
    [self.faceIDSwitch setOn:[FQLockHelper isBiometryAuthEnableForUserId:self.userID]];
    
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            //是否支持生物识别
            if ([FQBiometryContext canEvaluate]) {
                //有没有设置手势识别
                if ([FQLockHelper isLocalGestureEnableForUserId:self.userID]) {
                    return 3;
                } else {
                    return 2;
                }
            } else {
                //有没有设置手势识别
                if ([FQLockHelper isLocalGestureEnableForUserId:self.userID]) {
                    return 2;
                }
            }
            return 1;
            
            break;
        default:
            return 0;
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        UITableViewCell *gestureCell = [tableView dequeueReusableCellWithIdentifier:@"gestureCell"];
        if (!gestureCell) {
            gestureCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"gestureCell"];
            UISwitch *switchView = [[UISwitch alloc] init];
            gestureCell.accessoryView = switchView;
            [switchView addTarget:self action:@selector(gestureCellSwitch:) forControlEvents:UIControlEventValueChanged];
            self.gestureSwitch = switchView;
        }
        gestureCell.textLabel.text = @"手势密码解锁";
        return gestureCell;
    } else if (indexPath.row == 1) {
        if ([FQLockHelper isLocalGestureEnableForUserId:self.userID]) {
            UITableViewCell *modifyCell = [tableView dequeueReusableCellWithIdentifier:@"modifyCell"];
            if (!modifyCell) {
                modifyCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"modifyCell"];
            }
            
            modifyCell.textLabel.text = @"修改解锁密码";
            return modifyCell;
        } else {
            UITableViewCell *faceIdCell = [tableView dequeueReusableCellWithIdentifier:@"faceIdCell"];
            if (!faceIdCell) {
                faceIdCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"faceIdCell"];
                UISwitch *switchView = [[UISwitch alloc] init];
                faceIdCell.accessoryView = switchView;
                [switchView addTarget:self action:@selector(faceIdCellSwitch:) forControlEvents:UIControlEventValueChanged];
                self.faceIDSwitch = switchView;
            }
            
            if ([FQBiometryContext biometryType] == FQBiometryTypeTouchID) {
                faceIdCell.textLabel.text = @"使用指纹解锁";
            } else if ([FQBiometryContext biometryType] == FQBiometryTypeFaceID) {
                faceIdCell.textLabel.text = @"面容ID解锁";
            }
            return faceIdCell;
        }
    } else {
        UITableViewCell *faceIdCell = [tableView dequeueReusableCellWithIdentifier:@"faceIdCell"];
        if (!faceIdCell) {
            faceIdCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"faceIdCell"];
            UISwitch *switchView = [[UISwitch alloc] init];
            faceIdCell.accessoryView = switchView;
            [switchView addTarget:self action:@selector(faceIdCellSwitch:) forControlEvents:UIControlEventValueChanged];
            self.faceIDSwitch = switchView;
        }
        
        if ([FQBiometryContext biometryType] == FQBiometryTypeTouchID) {
            faceIdCell.textLabel.text = @"使用指纹解锁";
        } else if ([FQBiometryContext biometryType] == FQBiometryTypeFaceID) {
            faceIdCell.textLabel.text = @"面容ID解锁";
        }
        return faceIdCell;
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @"开启锁屏之后，请把APP推到后台验证 \n指纹和面容ID解锁需要使用真机测试 ";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1 && [FQLockHelper isLocalGestureEnableForUserId:self.userID]) {
        FQLockGestureViewController *lockVC = [[FQLockGestureViewController alloc] init];
        lockVC.userID = self.userID;
        lockVC.localLockBlock = ^(BOOL complete) {
            if (complete) {
                
            }
        };
        lockVC.lockType = FQGestureLockTypeReset;
        [self.navigationController pushViewController:lockVC animated:YES];
    }
}

- (void)gestureCellSwitch:(UISwitch *)sender {
    FQLockGestureViewController *lockVC = [[FQLockGestureViewController alloc] init];
    lockVC.userID = self.userID;
    lockVC.localLockBlock = ^(BOOL complete) {
        if (complete) {
            
        }
    };
    if (sender.isOn) { //开启
        lockVC.lockType = FQGestureLockTypeSetting;
    }else{ //关闭
        lockVC.lockType = FQGestureLockTypeClose;
    }
    [self.navigationController pushViewController:lockVC animated:YES];
}

- (void)faceIdCellSwitch:(UISwitch *)sender {
    if (sender.isOn) {
        [FQBiometryContext biometryAuthWithSucceedHandler:^{
            [FQLockHelper setBiometryAuthEnable:YES forUserId:self.userID];
        } failureHandler:^(FQBiometryError errorCode) {
            self.faceIDSwitch.on = NO;
        }];
    } else {
        [FQLockHelper setBiometryAuthEnable:NO forUserId:self.userID];
    }
}

@end
