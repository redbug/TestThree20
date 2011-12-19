//
//  ListDataSource.m
//  testThree20
//
//  Created by Wei Ming Chao on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ListDataSource.h"
#import "GuluContactModel.h"


@implementation ListDataSource


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithUID:(NSString*)uid;
{
    if (self = [super init]) {
        _urlRequestModel = [[URLRequestModel alloc] initWithUId:uid];
    }
    
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<TTModel>)model {
    return _urlRequestModel;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableViewDidLoadModel:(UITableView*)tableView 
{
    NSMutableArray* items = [[NSMutableArray alloc] init];
    
    for (GuluContactModel* contact in _urlRequestModel.contacts) {
        TTTableImageItem *contactItem = [TTTableImageItem itemWithText:[contact getFullName] 
                                                              imageURL:contact.profile_pic
                                                                   URL:nil];
        [items addObject:contactItem];
    }
    
    self.items = items;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForLoading:(BOOL)reloading {
    if (reloading) {
        return NSLocalizedString(@"Updating Contacts...", @"Twitter feed updating text");
    } else {
        return NSLocalizedString(@"Loading Contacts...", @"Twitter feed loading text");
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForEmpty {
    return NSLocalizedString(@"No contacts found.", @"Twitter feed no results");
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)subtitleForError:(NSError*)error {
    return NSLocalizedString(@"Sorry, there was an error loading the contact.", @"");
}

@end
