//
//  FQLockHelper.h
//  FQUtils
//
//  Created by wuwuFQ on 2022/9/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FQLockHelper : NSObject
///生物识别Type： 100指纹，200面容ID -1不支持
+ (NSInteger)biometryType;
///是否支持生物识别
+ (BOOL)canEvaluate;
///验证生物识别
+ (void)localAuthWithCompletionHandle:(void(^)(void))completionHandle withFailureHandle:(void (^)(NSString *message))failureHandler;
///是否设置了生物识别
+ (BOOL)isLocalAuthEnableForUserId:(NSString*)userId;
///设置生物识别
+ (void)setLocalAuthEnable:(BOOL)isEnable forUserId:(NSString*)userId;


///是否设置了手势密码
+ (BOOL)isLocalGestureEnableForUserId:(NSString*)userId;
///设置手势密码
+ (void)setLocalGestureEnable:(BOOL)isEnable forUserId:(NSString*)userId;

@end

NS_ASSUME_NONNULL_END
