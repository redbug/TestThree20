//
//  FBLoginManager.m
//  testThree20
//
//  Created by Wei Ming Chao on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DCFbLoginManager.h"

@interface DCFbLoginManager()
-(void)getFacebookUserID;
@end

@implementation DCFbLoginManager
@synthesize facebook = _facebook;
@synthesize fbUserID = _fbUserID;
@synthesize fbSsoDelegate = _fbSsoDelegate;

static id _instace = nil;

+ (id)sharedManager
{
    @synchronized(self)
    {
        if( _instace == nil)
        {
            _instace = [[DCFbLoginManager alloc] init];
        }
        return _instace;
    }
}

#pragma mark - public methods
-(void)loginByFacebookId:(NSString *)fbUserId accessToken:(NSString *)accessToken
{
//    GuluHttpRequest *request=[[GuluAPIAccessManager sharedManager] facebookConnectWithFacebookID:fbUserId 
//                                                                                     accessToken:accessToken 
//                                                                                          target:self];
//    [request startAsynchronous];
//    
//    [SVProgressHUD showWithStatus:NSLocalizedString(@"Loading...", @"") maskType:SVProgressHUDMaskTypeGradient];    
}


-(void)invokeFacebbokSSOWithSuffix:(NSString *)suffix
{
    NSString *facebookApiKey = [_fbSsoDelegate getFacebookApiKey];
            
    //refer https://developers.facebook.com/docs/mobile/ios/build/#multipleapps
    _facebook = [[Facebook alloc] initWithAppId:facebookApiKey urlSchemeSuffix:suffix andDelegate:self];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if( [defaults objectForKey:@"FBAccessTokenKey"] &&
       [defaults objectForKey:@"FBExpirationDateKey"])
    {
        _facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        _facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    if( [_facebook isSessionValid] )
    {
        [self getFacebookUserID];
    }
    else{
        [_facebook authorize:[NSArray arrayWithObject:@"offline_access"]];    
    }
}


#pragma mark - private methods
-(void)getFacebookUserID
{
    [_facebook requestWithGraphPath:@"me" andDelegate:self];
}


#pragma mark -
#pragma mark FBSessionDelegate methods
- (void)fbDidLogin {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[_facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[_facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    [self getFacebookUserID];
}

- (void)fbDidNotLogin:(BOOL)cancelled {
    
}

- (void)fbDidLogout {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
    }
}


#pragma mark - FBRequestDelegate methods
- (void)request:(FBRequest *)request didLoad:(id)result
{    
    NSDictionary *userDictionary = (NSDictionary *)result;
    _fbUserID = [userDictionary objectForKey:@"id"];
    
    [_fbSsoDelegate didFbSsoSuccessWithFbUserId:_fbUserID accessToken:_facebook.accessToken];
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {

}

@end



