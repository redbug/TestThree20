//
//  GuluContactModel.h
//  testThree20
//
//  Created by Wei Ming Chao on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


@interface GuluContactModel : NSObject
<NSCoding, NSCopying>
@property (nonatomic,strong) NSString *first_name;
@property (nonatomic,strong) NSString *last_name;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *profile_pic;
@property (nonatomic,strong) NSString *gulu_user_id;
@property (nonatomic) BOOL is_favorited;
@property (nonatomic,strong) NSArray *propertiesForDescription;

-(NSString *)getFullName;

@end
