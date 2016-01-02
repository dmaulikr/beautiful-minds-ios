//
//  BMUIManager.h
//  BeautifulMinds
//
//  Created by Bibo on 1/2/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMUIManager : NSObject

+(CGFloat)getWidthForString:(NSString *)string font:(UIFont *)font restrictedHeight:(CGFloat)height;
+(CGFloat)getHeightForString:(NSString *)string font:(UIFont *)font restrictedWidth:(CGFloat)width;

@end
