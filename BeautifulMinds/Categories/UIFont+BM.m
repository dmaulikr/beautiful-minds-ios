//
//  UIFont+BM.m
//  BeautifulMinds
//
//  Created by Geman Wu on 1/2/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import "UIFont+BM.h"

@implementation UIFont (BM)

+(UIFont *) BMTextFontWithSize:(CGFloat)size {
  return [self proximaNovaRegularWithSize:size];
}

+(UIFont *) BMTitleFontBoldWithSize:(CGFloat)size {
  return [self proximaNovaBoldWithSize:size];
}

+(UIFont *) BMTitleFontSemiBoldWithSize:(CGFloat)size {
  return [self proximaNovaSemiBoldWithSize:size];
}

+(UIFont *)proximaNovaRegularWithSize:(CGFloat)size {
  return [UIFont fontWithName:@"ProximaNova-Regular" size:size];
}
+(UIFont *)proximaNovaSemiBoldWithSize:(CGFloat)size {
  return [UIFont fontWithName:@"ProximaNova-Semibold" size:size];
}
+(UIFont *)proximaNovaBoldWithSize:(CGFloat)size {
  return [UIFont fontWithName:@"ProximaNova-Bold" size:size];
}


@end
