//
//  FQBiometryContext.h
//  FQUtils
//
//  Created by wuwuFQ on 2021/7/5.
//

#import <Foundation/Foundation.h>

// Error codes
#define kFQBiometryErrorAuthenticationFailed                       -1
#define kFQBiometryErrorUserCancel                                 -2
#define kFQBiometryErrorUserFallback                               -3
#define kFQBiometryErrorSystemCancel                               -4
#define kFQBiometryErrorPasscodeNotSet                             -5
#define kFQBiometryErrorBiometryNotAvailable                       -6
#define kFQBiometryErrorBiometryNotEnrolled                        -7
#define kFQBiometryErrorBiometryLockout                            -8
#define kFQBiometryErrorAppCancel                                  -9
#define kFQBiometryErrorInvalidContext                            -10
#define kFQBiometryErrorWatchNotAvailable                         -11
#define kFQBiometryErrorNotInteractive                          -1004
#define kFQBiometryErrorBiometryNotPaired                         -12
#define kFQBiometryErrorBiometryDisconnected                      -13

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    /// The device does not support biometry.
    FQBiometryTypeNone,
    /// The device supports Touch ID.
    FQBiometryTypeTouchID,
    /// The device supports Face ID.
    FQBiometryTypeFaceID,
} FQBiometryType;

typedef NS_ENUM(NSInteger, FQBiometryError)
{
    /// Authentication was not successful because user failed to provide valid credentials.
//    身份验证未成功，因为用户未能提供有效凭据。错误三次会触发Failed，错误六次会锁定
    FQBiometryErrorAuthenticationFailed = kFQBiometryErrorAuthenticationFailed,
    
    /// Authentication was canceled by user (e.g. tapped Cancel button).
//    用户已取消身份验证（例如，点击“取消”按钮）。
    FQBiometryErrorUserCancel = kFQBiometryErrorUserCancel,
    
    /// Authentication was canceled because the user tapped the fallback button (Enter Password).
    FQBiometryErrorUserFallback = kFQBiometryErrorUserFallback,
    
    /// Authentication was canceled by system (e.g. another application went to foreground).
    FQBiometryErrorSystemCancel = kFQBiometryErrorSystemCancel,
    
    /// Authentication could not start because passcode is not set on the device.
    FQBiometryErrorPasscodeNotSet = kFQBiometryErrorPasscodeNotSet,

    /// Authentication was canceled by application (e.g. invalidate was called while
    /// authentication was in progress).
    FQBiometryErrorAppCancel = kFQBiometryErrorAppCancel,

    /// FQBiometryContext passed to this call has been previously invalidated.
    FQBiometryErrorInvalidContext = kFQBiometryErrorInvalidContext,

    /// Authentication could not start because biometry is not available on the device.
    FQBiometryErrorBiometryNotAvailable = kFQBiometryErrorBiometryNotAvailable,

    /// Authentication could not start because biometry has no enrolled identities.
    FQBiometryErrorBiometryNotEnrolled = kFQBiometryErrorBiometryNotEnrolled,
    
    /// Authentication was not successful because there were too many failed biometry attempts and
    /// biometry is now locked. Passcode is required to unlock biometry, e.g. evaluating
    /// FQBiometryPolicyDeviceOwnerAuthenticationWithBiometrics will ask for passcode as a prerequisite.
//    身份验证未成功，因为有太多次失败的生物测量尝试，生物测量学现在被锁定了。解锁生物测量需要密码 （意思是因为错误次数太多指纹和面容ID不能用了，需要用户锁屏，然后输入手机解锁密码才可以启用biometry）
    FQBiometryErrorBiometryLockout = kFQBiometryErrorBiometryLockout,
    
    /// Authentication failed because it would require showing UI which has been forbidden
    /// by using interactionNotAllowed property.
    FQBiometryErrorNotInteractive = kFQBiometryErrorNotInteractive,
    
    /// Authentication could not start because there was no paired watch device nearby.
    FQBiometryErrorWatchNotAvailable = kFQBiometryErrorWatchNotAvailable,
    
    /// Authentication could not start because this device supports biometry only via removable accessories and no accessory has been paired.
    FQBiometryErrorBiometryNotPaired = kFQBiometryErrorBiometryNotPaired,

    /// Authentication could not start because this device supports biometry only via removable accessories and the paired accessory is not connected.
//    身份验证无法启动，因为此设备仅通过可移动附件支持生物测量，而配对附件未连接。
    FQBiometryErrorBiometryDisconnected = kFQBiometryErrorBiometryDisconnected,

};

@interface FQBiometryContext : NSObject

///是否支持生物识别
+ (BOOL)canEvaluate;
///支持生物识别的 Type
+ (FQBiometryType)biometryType;
///验证生物识别
+ (void)biometryAuthWithSucceedHandler:(void(^)(void))succeedHandler
                     failureHandler:(void (^)(FQBiometryError errorCode))failureHandler;
@end

NS_ASSUME_NONNULL_END
