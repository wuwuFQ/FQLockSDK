//
//  FQLockConfig.h
//  FQUtils
//
//  Created by wuwuFQ on 2022/9/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  手势密码界面用途类型
 *  设置模式：会重置密码，设置两次
 *  验证模式：验证手势正确与否
 *  请结合业务组合使用
 */
typedef enum{
    FQGestureLockTypeSetting = 1,   // 设置手势密码（默认）
    FQGestureLockTypeClose,         // 关闭手势密码
    FQGestureLockTypeLogin,         // 登录手势密码
    FQGestureLockTypeReset,         // 重置密码
} FQGestureLockType;

/**
 *  单个圆的各种状态
 */
typedef enum{
    FQLockCircleStateNormal = 1,
    FQLockCircleStateSelected,
    FQLockCircleStateError,
    FQLockCircleStateLastSelected,
    FQLockCircleStateLastError
} FQLockCircleState;

NS_ASSUME_NONNULL_BEGIN

@interface FQLockConfig : NSObject

/// 解锁类型: 新设置密码  或  验证密码
@property (nonatomic, assign) FQGestureLockType lockType;

/// 密码会以NSUserDefaults形式保存，可以自定义key（如果和userID有关，一定要自定义）
@property (nonatomic, copy) NSString *passwordKey;

/// 解锁背景色（解锁视图是正方体）
@property (nonatomic, strong) UIColor *lockViewBackgroundColor;

/// 整个解锁View居中，距离屏幕左边和右边的距离 （用来控制宽度，高度等于宽度）
@property (nonatomic, assign) CGFloat lockViewEdgeMargin;

/// 解锁View的中心CenterY，默认[UIScreen mainScreen]中心
@property (nonatomic, assign) CGFloat lockViewCenterY;

/// 连接的圆最少的个数，默认4个
@property (nonatomic, assign) CGFloat lockLeastCount;


/// 单个锁的背景色
@property (nonatomic, strong) UIColor *lockBackgroundColor;

//====================单个锁的外心圆==========================

/// 单个锁普通状态下外心圆颜色
@property (nonatomic, strong) UIColor *lockOutsideNormalColor;

/// 单个锁选中状态下外心圆颜色
@property (nonatomic, strong) UIColor *lockOutsideSelectedColor;

/// 单个锁错误状态下外心圆颜色
@property (nonatomic, strong) UIColor *lockOutsideErrorColor;

/// 外心圆的半径
@property (nonatomic, assign) CGFloat lockOutsideRadius;

/// 外心圆边框的宽度
@property (nonatomic, assign) CGFloat lockOutsideBorderWidth;


//====================单个锁的内心圆==========================
/// 单个锁普通状态下内心圆颜色
@property (nonatomic, strong) UIColor *lockInsideNormalColor;

/// 单个锁选中状态下内心圆颜色
@property (nonatomic, strong) UIColor *lockInsideSelectedColor;

/// 单个锁错误状态下内心圆颜色
@property (nonatomic, strong) UIColor *lockInsideErrorColor;

/// 内部实心圆占空心圆的比例系数 0.1~1.0
@property (nonatomic, assign) CGFloat lockInsideRadiusRadio;


//====================圆内三角形==========================

///  是否有箭头 default is YES
@property (nonatomic, assign) BOOL arrow;

/// 锁内锁普通状态下三角形颜色
@property (nonatomic, strong) UIColor *lockTrangleNormalColor;

/// 锁内锁选中状态下三角形颜色
@property (nonatomic, strong) UIColor *lockTrangleSelectedColor;

/// 锁内错误状态下三角形颜色
@property (nonatomic, strong) UIColor *lockTrangleErrorColor;

/// 三角形边长，默认12pt
@property (nonatomic, assign) CGFloat lockTrangleLength;


//====================两个锁之间的连线==========================
/// 两个锁之间普通连线颜色
@property (nonatomic, strong) UIColor *lockLineNormalColor;

/// 两个锁之间错误连线颜色
@property (nonatomic, strong) UIColor *lockLineErrorColor;

/// 连线的宽度，默认1pt
@property (nonatomic, assign) CGFloat lockLineWidth;



@end

NS_ASSUME_NONNULL_END
