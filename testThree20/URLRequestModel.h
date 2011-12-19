//
//  URLRequestModel.h
//  testThree20
//
//  Created by Wei Ming Chao on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLRequestModel : TTURLRequestModel
@property (nonatomic, strong) NSArray *contacts;
@property (nonatomic, strong) NSString *uid;

- (id)initWithUId:(NSString*)uid;
@end
