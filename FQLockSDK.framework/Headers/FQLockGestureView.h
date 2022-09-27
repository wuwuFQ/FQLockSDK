//
//  FQLockGestureView.h
//  FQUtils
//
//  Created by wuwuFQ on 2022/9/17.
//

#import <UIKit/UIKit.h>
#import "FQLockConfig.h"

NS_ASSUME_NONNULL_BEGIN


@class FQLockGestureView;

@protocol FQGestureLockViewDelegate <NSObject>

@optional
/// 连线个数少于最少连接数，通知代理
/// @param view LockView
/// @param type <#type description#>
/// @param gesture 手势密码
- (void)fq_gestureLockView:(FQLockGestureView *)view type:(FQGestureLockType)type connectNumberLessThanNeedWithGesture:(NSString *)gesture;

/// 第一次设置手势密码
/// @param view LockView
/// @param type <#type description#>
/// @param gesture 第一次手势密码
- (void)fq_gestureLockView:(FQLockGestureView *)view type:(FQGestureLockType)type didCompleteSetFirstGesture:(NSString *)gesture;

/// 第二次设置手势密码
/// @param view LockView
/// @param type <#type description#>
/// @param gesture 第二次手势密码
/// @param equal 第二次和第一次的手势密码匹配结果
- (void)fq_gestureLockView:(FQLockGestureView *)view type:(FQGestureLockType)type didCompleteSetSecondGesture:(NSString *)gesture result:(BOOL)equal;

/// 验证手势密码
/// - Parameters:
///   - view: LockView
///   - type: <#type description#>
///   - gesture: 验证的手势密码
///   - equal: 验证是否通过
- (void)fq_gestureLockView:(FQLockGestureView *)view type:(FQGestureLockType)type didCompleteVerifyGesture:(NSString *)gesture result:(BOOL)equal;

@end

@interface FQLockGestureView : UIView


// 代理
@property (nonatomic, weak) id<FQGestureLockViewDelegate> delegate;


/// 初始化方法
/// - Parameter config: <#config description#>
- (instancetype)initWithConfig:(FQLockConfig *)config;

@end


NS_ASSUME_NONNULL_END
