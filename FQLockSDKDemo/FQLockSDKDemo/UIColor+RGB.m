//
//  UIColor+RGB.m
//  FQUtils
//
//  Created by wuwuFQ on 2022/9/27.
//

#import "UIColor+RGB.h"

@implementation UIColor (RGB)
+ (UIColor*)colorFromHexString:(NSString*)hexString
{
    if (hexString) {
        unsigned rgbValue = 0;
        NSScanner *scanner = [NSScanner scannerWithString:hexString];
        if ([hexString hasPrefix:@"#"]) {
            [scanner setScanLocation:1]; // bypass '#' character
        }
        [scanner scanHexInt:&rgbValue];
        if ([hexString length] >= 8) {
            return UIColorFromARGB(rgbValue);
        }else{
            return UIColorFromRGB(rgbValue);
        }
    }else{
        return nil;
    }
}

@end
