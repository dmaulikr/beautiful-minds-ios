//
//  BMUserManager.h
//  BeautifulMinds
//
//  Created by Fishie Veggie on 1/2/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMUserManager : NSObject

+ (BMUserManager *)shared;

-(BOOL)isCurrentUser;

-(void)loginWithEmail:(NSString *)email password:(NSString *)password returned:(void (^)(PFUser *user, NSError *error))callback;
-(void)signupWithEmail:(NSString *)email password:(NSString *)password returned:(void (^)(PFUser *user, NSError *error))callback;


@end
