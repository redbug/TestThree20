//
//  URLRequestFactory.m
//  testThree20
//
//  Created by Wei Ming Chao on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "URLRequestFactory.h"

@implementation URLRequestFactory
@synthesize sessionKey = _sessionKey;

static URLRequestFactory *sharedInstance;

+(id)sharedFactory
{
    @synchronized(self)
    {
        if ( sharedInstance == nil )
        {
            sharedInstance = [[URLRequestFactory alloc] init];
        }
        return sharedInstance;
    }
}

-(TTURLRequest *) createRequestWithApiName:(NSString*)apiName delegate:(id) delegate
{
    TTURLRequest *request = [TTURLRequest requestWithURL:API_URL(apiName) delegate:delegate];
    TTURLDataResponse *response = [[TTURLDataResponse alloc] init];
    request.response = response;
    request.httpMethod = @"POST";
    
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString *currnetLanguage=[languages objectAtIndex:0];   
    
    [[request headers] setObject:currnetLanguage forKey:@"Accept-Language"];
    [[request headers] setObject:[NSString stringWithFormat:@"sessionid=%@", sharedInstance.sessionKey] forKey:@"cookie"];
    
    return request;
}

@end
