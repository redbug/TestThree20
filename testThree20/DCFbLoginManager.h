//
//  FBLoginManager.h
//  testThree20
//
//  Created by Wei Ming Chao on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Facebook.h"

@protocol DCFbSsoDelegate;

@interface DCFbLoginManager : NSObject
<FBSessionDelegate, FBRequestDelegate>

@property (nonatomic, unsafe_unretained)id<DCFbSsoDelegate> fbSsoDelegate;
@property (nonatomic, strong)Facebook *facebook;
@property (nonatomic, strong)NSString *fbUserID;

+ (id)sharedManager;

-(void)invokeFacebbokSSOWithSuffix:(NSString *)suffix;
-(void)loginByFacebookId:(NSString *)fbUserId accessToken:(NSString *)accessToken;

@end

@protocol DCFbSsoDelegate <NSObject>
-(NSString*)getFacebookApiKey;
-(void)didFbSsoSuccessWithFbUserId:(NSString *)fbUserId accessToken:(NSString *)accessToken;
@end