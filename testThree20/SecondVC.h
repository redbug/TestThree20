//
//  SecondVC.h
//  testThree20
//
//  Created by Wei Ming Chao on 12/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondVC : TTViewController
<TTLauncherViewDelegate>

@property (nonatomic, strong) TTLauncherView *launcherView;
@property (nonatomic, strong) NSArray *contacts;

@end
