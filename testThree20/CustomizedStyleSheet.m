//
//  CustomizedStyleSheet.m
//  testThree20
//
//  Created by Wei Ming Chao on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomizedStyleSheet.h"

@implementation CustomizedStyleSheet
// Style for TTLauncherItems
- (TTStyle*)launcherButton:(UIControlState)state {
    return 
    [TTPartStyle styleWithName: @"image" 
                         style: TTSTYLESTATE(launcherButtonImage:, state) 
                          next: [TTTextStyle 
                                 styleWithFont:[UIFont boldSystemFontOfSize:11]
                                 color: RGBCOLOR(0, 0, 0)
                                 minimumFontSize: 11 
                                 shadowColor: nil
                                 shadowOffset: CGSizeZero 
                                 next: nil]];
}
@end
