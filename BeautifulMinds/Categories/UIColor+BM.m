//
//  UIColor+BM.m
//  BeautifulMinds
//
//  Created by Geman Wu on 1/2/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import "UIColor+BM.h"

@implementation UIColor (BM)

+(UIColor *)BMLightGrey {
  return [self colorFromHexString:@"#E8E8E8" alpha:1.0];
}

+ (UIColor *)colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha {
  unsigned rgbValue = 0;
  NSScanner *scanner = [NSScanner scannerWithString:hexString];
  [scanner setScanLocation:1]; // bypass '#' character
  [scanner scanHexInt:&rgbValue];
  return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0
                         green:((rgbValue & 0xFF00) >> 8) / 255.0
                          blue:(rgbValue & 0xFF) / 255.0
                         alpha:alpha];
}

@end
