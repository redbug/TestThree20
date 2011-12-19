//
//  FirstVC.h
//  testThree20
//
//  Created by Wei Ming Chao on 12/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCFbLoginManager.h"

@interface FirstVC : UIViewController
<DCFbSsoDelegate>
@property (nonatomic, strong) IBOutlet UIButton *gotoSecondBtn;
@property (nonatomic, strong) IBOutlet UIButton *gotoThirdBtn;
@property (nonatomic, strong) IBOutlet UIButton *loginBtn;

@property (nonatomic, strong)NSString *sessionKey;
@property (nonatomic, strong)NSString *uid;

- (IBAction)loginByFacebook:(id)sender;
- (IBAction)gotoSecondView:(id)sender;
- (IBAction)gotoThirdView:(id)sender;
@end
