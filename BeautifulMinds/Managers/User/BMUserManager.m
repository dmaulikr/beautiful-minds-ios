//
//  BMUserManager.m
//  BeautifulMinds
//
//  Created by Fishie Veggie on 1/2/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import "BMUserManager.h"

@implementation BMUserManager

+ (BMUserManager *)shared {
    static BMUserManager *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[[self class] alloc] init];
    });
    return shared;
}


-(BOOL)isCurrentUser {
    return [PFUser currentUser] != nil;
}

-(void)loginWithEmail:(NSString *)email password:(NSString *)password returned:(void (^)(PFUser *user, NSError *error))callback {
    [PFUser logInWithUsernameInBackground:[email lowercaseString] password:password block:^(PFUser * _Nullable user, NSError * _Nullable error) {
        if (error) {
            callback(nil, error);
        }
        else {
            [[PFUser currentUser] fetchInBackground];
            callback(user, nil);
        }
    }];
}

-(void)signupWithEmail:(NSString *)email password:(NSString *)password returned:(void (^)(PFUser *user, NSError *error))callback {
    PFUser *user = [PFUser new];
    user.email = [email lowercaseString];
    user.username = [email lowercaseString];
    user.password = password;
    user[@"displayName"] = @"Anonymous";
    user[@"authorAvatarUrl"] = @"http://www.soulmarket.net/wp-content/uploads/2015/02/blank-profile.png";
    user[@"isBanned"] = @NO;
    user[@"isActive"] = @YES;
    user[@"abTesting"] = @"a";
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            callback(nil, error);
        }
        else {
            [[PFUser currentUser] fetchInBackground];
            callback(user, nil);
        }
    }];
}

@end
