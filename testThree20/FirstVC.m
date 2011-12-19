//
//  FirstVC.m
//  testThree20
//
//  Created by Wei Ming Chao on 12/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstVC.h"
#import "DCFbLoginManager.h"
#import "NSString+SBJSON.h"
#import "GuluContactModel.h"
#import "URLRequestFactory.h"


@interface FirstVC()

-(void)requestContacts;
@end


@implementation FirstVC

@synthesize gotoSecondBtn = _gotoSecondBtn;
@synthesize gotoThirdBtn = _gotoThirdBtn;
@synthesize loginBtn = _loginBtn;
@synthesize sessionKey = _sessionKey;
@synthesize uid = _uid;



-(void)requestContacts
{
    TTURLRequest *request = [[URLRequestFactory sharedFactory] createRequestWithApiName:API_GET_FRIEND_LIST delegate:self];    
    
    [[request parameters] setObject:self.uid forKey:@"uid"];
    
    [request send];    
}

- (IBAction)loginByFacebook:(id)sender
{
    DCFbLoginManager *loginManager = [DCFbLoginManager sharedManager];
    loginManager.fbSsoDelegate = self;
    [loginManager invokeFacebbokSSOWithSuffix:APP_SUFFIX];
    [SVProgressHUD showWithStatus:@"Logging..."];
}

- (IBAction)gotoSecondView:(id)sender
{
    [self requestContacts];
}

- (IBAction)gotoThirdView:(id)sender
{
    [[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:[NSString stringWithFormat:@"my://ThirdVC/%@", self.uid]]];
}

#pragma mark - GuluFacebookSSODelegate Methods
-(NSString*)getFacebookApiKey
{
    return FACEBOOK_API_KEY;
}

-(void)didFbSsoSuccessWithFbUserId:(NSString *)fbUserId accessToken:(NSString *)accessToken;
{
    NSLog(@"fbUserId:%@", fbUserId);
    NSLog(@"accessToken:%@", accessToken);
    
    TTURLRequest *request = [TTURLRequest requestWithURL:API_URL(API_FACEBOOK_CONNECT) delegate:self];

    TTURLDataResponse* response = [[TTURLDataResponse alloc] init];
    request.response = response;
    request.httpMethod = @"POST";
    
    [[request parameters] setObject:fbUserId forKey:@"facebookId"];
    [[request parameters] setObject:accessToken forKey:@"accessToken"];
    [request send];
}

- (void)requestDidFinishLoad:(TTURLRequest*)request 
{
    NSString * urlPath = request.urlPath;
    
    if ([urlPath isEqualToString:API_URL(API_FACEBOOK_CONNECT)]) {
        NSData *respData = [(TTURLDataResponse *)request.response data];
        NSString *respStr = [[NSString alloc] initWithData:respData encoding:NSASCIIStringEncoding];
        
        //TTDPRINT(@"Result %@", respStr);
        
        NSDictionary *respDict = [respStr JSONValue];
        
        //TTDPRINT(@"Result dictioanry %@", respDict);    
        
        NSDictionary *user = [respDict objectForKey:@"user"];
        NSString *sessionKey = [respDict objectForKey:@"session_key"];

        
        _uid = [user objectForKey:@"id"];
        _sessionKey = sessionKey;
        
        URLRequestFactory *urlRequestFactory = [URLRequestFactory sharedFactory];
        
        urlRequestFactory.sessionKey = sessionKey;
        
        [SVProgressHUD dismiss];
        
        NSLog(@"user id:%@", _uid);
        NSLog(@"session key:%@", sessionKey);    
    }
    else if ( [urlPath isEqualToString:API_URL(API_GET_FRIEND_LIST)] ){
        NSData *respData = [(TTURLDataResponse *)request.response data];
        NSString *respStr = [[NSString alloc] initWithData:respData encoding:NSUTF8StringEncoding];
        if([[respStr JSONValue] isKindOfClass:[NSArray class]])
        {
            NSArray *respArray = [respStr JSONValue];
//            TTDPRINT(@"respDict:%@", respArray);
            
            NSMutableArray *contacts = [NSMutableArray array];
            GuluContactModel *contact;
            
            for ( id obj in respArray )
            {
                contact = [[GuluContactModel alloc] init];
                contact.first_name = [obj objectForKey:@"first_name"];
                contact.last_name = [obj objectForKey:@"last_name"];
                contact.email = [obj objectForKey:@"email"];
                contact.profile_pic = [obj objectForKey:@"profile_pic"];
                contact.gulu_user_id = [obj objectForKey:@"gulu_user_id"];
                contact.is_favorited = [[obj objectForKey:@"is_favorited"] boolValue];
                [contacts addObject:contact];
            }
            
            [[TTNavigator navigator]openURLAction: [[TTURLAction actionWithURLPath:@"my://SecondVC/Redbug"] applyQuery:[NSDictionary dictionaryWithObject:contacts forKey:@"contacts"]]];
        }
    
    }
}

- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {

    TTDPRINT(@"Error %@", error);
}
@end
