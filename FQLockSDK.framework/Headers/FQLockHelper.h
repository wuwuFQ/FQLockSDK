//
//  FQLockHelper.h
//  FQUtils
//
//  Created by wuwuFQ on 2022/9/27.
//

#import <Foundation/Foundation.h>
@interface FQLockHelper : NSObject

///是否设置了生物识别
+ (BOOL)isBiometryAuthEnableForUserId:(NSString*)userId;
///设置生物识别
+ (void)setBiometryAuthEnable:(BOOL)isEnable forUserId:(NSString*)userId;


///是否设置了手势密码
+ (BOOL)isLocalGestureEnableForUserId:(NSString*)userId;
///设置手势密码
+ (void)setLocalGestureEnable:(BOOL)isEnable forUserId:(NSString*)userId;

@end

