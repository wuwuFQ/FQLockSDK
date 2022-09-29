//
//  FQLockGestureViewController.h
//  FQUtils
//
//  Created by wuwuFQ on 2022/9/17.
//

#import <UIKit/UIKit.h>
#import <FQLockSDK/FQLockSDK.h>

typedef void(^LocalLockBlock)(BOOL complete);

@interface FQLockGestureViewController : UIViewController
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, assign) FQGestureLockType lockType;
@property (nonatomic, strong) LocalLockBlock localLockBlock;

@end
