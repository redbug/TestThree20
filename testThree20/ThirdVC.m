//
//  ThirdVC.m
//  testThree20
//
//  Created by Wei Ming Chao on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ThirdVC.h"
#import "URLRequestModel.h"
#import "ListDataSource.h"

@implementation ThirdVC
@synthesize uid = _uid;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithUId:(NSString*)uid
{
    if (self = [super initWithNibName:nil bundle:nil]) 
    {        
        self.title = @"Contacts";
        self.variableHeightRows = YES;
        self.uid = uid;
    }
    
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createModel {    
    self.dataSource = [[ListDataSource alloc] initWithUID:self.uid];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<UITableViewDelegate>)createDelegate {
    return [[TTTableViewDragRefreshDelegate alloc] initWithController:self];
}




@end
