//
//  GuluContactModel.m
//  testThree20
//
//  Created by Wei Ming Chao on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GuluContactModel.h"

#define kFirstNameKey       @"first_name"
#define kLastNameKey        @"last_name"
#define kEmailKey           @"email"
#define kProfilePicURLKey   @"profile_pic"
#define kGuluUserIdKey      @"gulu_user_id"
#define kIsFavoritedKey     @"is_favorited"

@implementation GuluContactModel

@synthesize first_name = _first_name;
@synthesize last_name = _last_name;
@synthesize email = _email;
@synthesize profile_pic = _profile_pic;
@synthesize gulu_user_id = _gulu_user_id;
@synthesize is_favorited = _is_favorited;
@synthesize propertiesForDescription = _propertiesForDescription;



- (id)init
{
    self = [super init];
    if (self) {        
        _propertiesForDescription = [NSArray arrayWithObjects:@"first_name", @"last_name", @"email", @"profile_pic", @"gulu_user_id", @"is_favorited",nil];
    }
    
    return self;
}


#pragma mark - Public Methods
-(NSString *)getFullName
{
    NSString *userName;
    NSString *firstName;
    NSString *lastName;
    
    firstName = (self.first_name == nil)? @"": self.first_name;
    lastName = (self.last_name == nil)? @"": self.last_name;
    
    if([firstName isEqualToString:@""]){
        userName = lastName;
    }else if([lastName isEqualToString:@""]){
        userName = firstName;
    }else{
        userName = [firstName stringByAppendingFormat:@" %@", lastName];
    }
    
    return userName;
}


#pragma mark -
#pragma mark NSCoding
- (void)encodeWithCoder:(NSCoder *)encoder
{
//    [super encodeWithCoder:encoder];
    
    [encoder encodeObject:self.first_name forKey:kFirstNameKey];
    [encoder encodeObject:self.last_name forKey:kLastNameKey];
    [encoder encodeObject:self.email forKey:kEmailKey];
    [encoder encodeObject:self.profile_pic forKey:kProfilePicURLKey];
    [encoder encodeObject:self.gulu_user_id forKey:kGuluUserIdKey];
    [encoder encodeBool:self.is_favorited forKey:kIsFavoritedKey];
}

- (id)initWithCoder:(NSCoder *)decoder
{
//    self = [super initWithCoder:decoder];
    self.first_name = [decoder decodeObjectForKey:kFirstNameKey];
    self.last_name = [decoder decodeObjectForKey:kLastNameKey];
    self.email = [decoder decodeObjectForKey:kEmailKey];
    self.profile_pic = [decoder decodeObjectForKey:kProfilePicURLKey];
    self.gulu_user_id = [decoder decodeObjectForKey:kGuluUserIdKey];
    self.is_favorited = [decoder decodeBoolForKey:kIsFavoritedKey];
    
    return self;
}


#pragma mark -
#pragma mark NSCopying
-(id)copyWithZone:(NSZone *)zone
{
    GuluContactModel *copy = [[[self class] allocWithZone:zone] init];
    copy.first_name = [self.first_name copyWithZone:zone];
    copy.last_name = [self.last_name copyWithZone:zone];
    copy.email = [self.email copyWithZone:zone];
    copy.profile_pic = [self.email copyWithZone:zone];
    copy.gulu_user_id = [self.gulu_user_id copyWithZone:zone];
    copy.is_favorited = self.is_favorited;
    
    return copy;
}


-(NSString *)description
{
    NSMutableString *tmp = [NSMutableString string];
    
    for( NSString *prop in _propertiesForDescription){
        [tmp appendFormat:@"%@: %@\n", prop, [self valueForKey:prop]];
    }
    
    NSString *header = @"\n========== Gulu Contact Model ==========\n";
    NSString *footer = @"========================================\n";
    NSString *content = tmp;    
    
    return  [[header stringByAppendingString:content] stringByAppendingString:footer];
}


@end
