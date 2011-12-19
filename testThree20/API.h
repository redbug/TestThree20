//
//  API.h
//  testThree20
//
//  Created by Wei Ming Chao on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#ifndef testThree20_API_h
#define testThree20_API_h

#define API_GET_FRIEND_LIST             @"get_friends_by_uid/"
#define API_FACEBOOK_CONNECT            @"facebook_connect/"

#define API_URL(apiName) [NSString stringWithFormat:@"%@%@", API_HOST, apiName]
#endif
