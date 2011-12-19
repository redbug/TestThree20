//
//  AppSettings.h
//  testThree20
//
//  Created by Wei Ming Chao on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#ifndef testThree20_AppSettings_h
#define testThree20_AppSettings_h



#ifndef APP_RELEASE
#define APP_RELEASE 1
#endif


/*****************************
 * Server Settings
 *****************************/
#if APP_RELEASE
#define API_HOST @"http://api.gulu.com/"
#define CHAT_SERVER @"chat.gulumail.com"
#define CHAT_PORT 8097
#else
#define API_HOST @"http://demo.gd:1337/api/"
//#define API_HOST @"http://web2-staging.demo.gd/api/"
//#define CHAT_SERVER @"chat1-staging.demo.gd"
#define CHAT_SERVER @"184.105.138.76"
#define CHAT_PORT 8097
#endif

/*****************************
 * Facebook 
 *****************************/
#define FACEBOOK_API_KEY @"172593759495024"
#define FACEBOOK_API_SECRET @"6e8e86173e4101faba3c2a3fed49e24f"
#define APP_SUFFIX @"test"

#endif
