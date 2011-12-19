//
//  ListDataSource.h
//  testThree20
//
//  Created by Wei Ming Chao on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLRequestModel.h"

@interface ListDataSource : TTListDataSource
{
    URLRequestModel * _urlRequestModel;
}

- (id)initWithUID:(NSString*)uid;
@end
