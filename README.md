# FQLockSDK
> iOS手势密码解锁，面容ID解锁，指纹解锁

### [博客地址，可评论](https://wuwufq.blog.csdn.net/article/details/127187585)
### [博客地址，可探讨](https://wuwufq.blog.csdn.net/article/details/127187585)
### [博客地址，可私聊](https://wuwufq.blog.csdn.net/article/details/127187585)

## 项目演示

<div  align='center'>
 <img src="https://user-images.githubusercontent.com/23627803/194307892-079a83d7-5f9f-4b0d-b5cc-d49b6c391b57.gif" width="50%" height="50%">
</div>

## 更新记录

|版本| 更新内容 |日期|
|--|:--|--|
|1.0.2|- 优化面容识别超过次数的code|2023-01-29|
|1.0.1|- 手势密码连接线优化<br>- 增加锁外心圆背景颜色|2022-10-18|
|1.0|- 初始版本<br>- 支持手势密码解锁，面容ID解锁，指纹解锁|2022-10-06|


## 功能介绍
- 支持手势密码解锁
- 支持面容ID解锁
- 支持指纹解锁
- SDK支持bitcode

## 集成方式
### 手动集成
1. 把项目`clone`或`Download ZIP`到本地
2. 把项目内的`FQLockSDK.framework`拖到你的项目里
<img width="424" alt="image" src="https://user-images.githubusercontent.com/23627803/194310134-f40bd0f9-3dda-44bf-ac22-f32686db5820.png">
3. 如果项目报错  `Library not loaded: @rpath/FQLockSDK.framework/FQLockSDK`， 设置 `Embed&Sign`
<img width="689" alt="image" src="https://user-images.githubusercontent.com/23627803/194310406-6797e3ec-e91e-4861-8844-80056c09df76.png">
4. 如果项目报错` Building for iOS Simulator, but the linked and embedded framework 'FQLockSDK.framework' was built for iOS + iOS Simulator. `
解决方法是： `Buil Settings` --> `Build Options` --> `Validate Workspace` 改为**Yes**
<img width="744" alt="image" src="https://user-images.githubusercontent.com/23627803/194310624-4d28f925-8df0-43bf-936e-2fb682f53ea1.png">

   

### cocoaPods自动集成
_这里默认大家对cocoaPods都是信手拈来的_
1. 在Podfile引入
```bash
pod 'FQLockSDK'
```
或者
```bash
pod 'FQLockSDK', '~> 1.0.2'
```
2. 在终端 cd 到你的项目根路径 
- 下载
```bash
pod install
```
或者
```bash
pod install --no-repo-update
```
- 更新
```bash
pod update
```
或者
```bash
pod update FQLockSDK --no-repo-update
```
## 使用案列
1. 先配置 `Info.plist` 权限

`Privacy - Face ID Usage Description` - `若要使用人脸解锁，需要您同意App访问您的面容ID`
<img width="814" alt="image" src="https://user-images.githubusercontent.com/23627803/194317090-79094c92-e411-47e2-891f-3cbc849f57ad.png">

2. 在用到密码解锁的地方引用头文件
```objectivec
#import <FQLockSDK/FQLockSDK.h>
```
3. 初始化 `FQLockGestureView`
```objectivec
    self.lockConfig = [[FQLockConfig alloc] init];
    self.lockConfig.lockType = self.lockType;
    //你的APP业务逻辑和用户无关，就可以全程不用userID
    self.lockConfig.passwordKey = [NSString stringWithFormat:@"%@_%@", kPassword, self.userID];
    self.lockConfig.lockViewCenterY = self.view.frame.size.height * 0.5;
    self.lockView = [[FQLockGestureView alloc] initWithConfig:self.lockConfig];
    self.lockView.delegate = self;
    [self.view addSubview:self.lockView];
```

4. 遵循代理`FQGestureLockViewDelegate`
```objectivec
@interface ViewController ()<FQGestureLockViewDelegate>

@end
```

5. 实现代理方法
```objectivec
#pragma mark - <FQGestureLockViewDelegate>

/// 连线个数少于最少连接数，通知代理
/// @param view LockView
/// @param type <#type description#>
/// @param gesture 手势密码
- (void)fq_gestureLockView:(FQLockGestureView *)view type:(FQGestureLockType)type connectNumberLessThanNeedWithGesture:(NSString *)gesture {

}

/// 第一次设置手势密码
/// @param view LockView
/// @param type <#type description#>
/// @param gesture 第一次手势密码
- (void)fq_gestureLockView:(FQLockGestureView *)view type:(FQGestureLockType)type didCompleteSetFirstGesture:(NSString *)gesture {

}

/// 第二次设置手势密码
/// @param view LockView
/// @param type <#type description#>
/// @param gesture 第二次手势密码
/// @param equal 第二次和第一次的手势密码匹配结果
- (void)fq_gestureLockView:(FQLockGestureView *)view type:(FQGestureLockType)type didCompleteSetSecondGesture:(NSString *)gesture result:(BOOL)equal {
    if (equal) {        
    } else {
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
    } else {
    }
}
```

>  有问题可以一起探讨，喜欢的请给个 ⭐️star⭐️，你的点赞我的动力，有需要可[通过博客联系](https://wuwufq.blog.csdn.net/article/details/127187585)
