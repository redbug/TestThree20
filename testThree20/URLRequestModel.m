//
//  URLRequestModel.m
//  testThree20
//
//  Created by Wei Ming Chao on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "URLRequestModel.h"
#import "URLRequestFactory.h"
#import "NSString+SBJSON.h"
#import "GuluContactModel.h"

@implementation URLRequestModel
@synthesize contacts = _contacts;
@synthesize uid = _uid;

- (id)initWithUId:(NSString*)uid
{
    if (self = [super init]) {
        _uid = uid;
        _contacts = [NSMutableArray array];
    }
    
    return self;
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more 
{
    TTURLRequest * request = [[URLRequestFactory sharedFactory] createRequestWithApiName:API_GET_FRIEND_LIST delegate:self];
        
    request.cachePolicy = cachePolicy;
    request.cacheExpirationAge = TT_CACHE_EXPIRATION_AGE_NEVER;
    [[request parameters] setObject:_uid forKey:@"uid"];
    [request send];
}

- (void)requestDidFinishLoad:(TTURLRequest*)request {
    NSString * urlPath = request.urlPath;
    
    if ( [urlPath isEqualToString:API_URL(API_GET_FRIEND_LIST)] ){
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
            
            _contacts = contacts;
        }
        
    }    
    
    [super requestDidFinishLoad:request];
}

@end
