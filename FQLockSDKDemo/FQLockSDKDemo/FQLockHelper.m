//
//  FQLockHelper.m
//  FQUtils
//
//  Created by wuwuFQ on 2022/9/27.
//

#import "FQLockHelper.h"
#define kLocalAuthPasswordKey @"FQ_LOCAL_AUTH_PASSWORD_KEY"
#define kLocalGesturePasswordKey @"FQ_LOCAL_GESTURE_PASSWORD_KEY"

@implementation FQLockHelper
//用户是否设置了TouchID解锁
+ (BOOL)isBiometryAuthEnableForUserId:(NSString*)userId
{
    if (![FQBiometryContext canEvaluate]) {
        return NO;
    }
    if (!userId) {
        return NO;
    }
    return [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%@_%@", kLocalAuthPasswordKey, userId]];
}

+ (void)setBiometryAuthEnable:(BOOL)isEnable forUserId:(NSString*)userId
{
    if (!userId) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setBool:isEnable forKey:[NSString stringWithFormat:@"%@_%@", kLocalAuthPasswordKey, userId]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

///手势密码
+ (BOOL)isLocalGestureEnableForUserId:(NSString*)userId {
    if (!userId) {
        return NO;
    }
    return [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%@_%@", kLocalGesturePasswordKey, userId]];
}

+ (void)setLocalGestureEnable:(BOOL)isEnable forUserId:(NSString*)userId {
    if (!userId) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setBool:isEnable forKey:[NSString stringWithFormat:@"%@_%@", kLocalGesturePasswordKey, userId]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
