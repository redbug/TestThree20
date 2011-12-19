//
//  URLRequestFactory.h
//  testThree20
//
//  Created by Wei Ming Chao on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLRequestFactory : NSObject
@property (nonatomic, strong) NSString *sessionKey;

+(id)sharedFactory;
-(TTURLRequest *) createRequestWithApiName:(NSString*)apiName delegate:(id) delegate;
@end
