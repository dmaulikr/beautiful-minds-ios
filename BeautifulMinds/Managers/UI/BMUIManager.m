//
//  BMUIManager.m
//  BeautifulMinds
//
//  Created by Bibo on 1/2/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import "BMUIManager.h"

@implementation BMUIManager

+(CGFloat)getWidthForString:(NSString *)string font:(UIFont *)font restrictedHeight:(CGFloat)height {
  CGSize maximumLabelSize = CGSizeMake(CGFLOAT_MAX, height);
  CGRect textRect = [string boundingRectWithSize:maximumLabelSize
                                         options:(NSStringDrawingUsesLineFragmentOrigin)
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
  
  return textRect.size.width;
}

+(CGFloat)getHeightForString:(NSString *)string font:(UIFont *)font restrictedWidth:(CGFloat)width {
  CGSize maximumLabelSize = CGSizeMake(width, CGFLOAT_MAX);
  CGRect textRect = [string boundingRectWithSize:maximumLabelSize
                                         options:(NSStringDrawingUsesLineFragmentOrigin)
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
  
  return textRect.size.height;
}

@end
