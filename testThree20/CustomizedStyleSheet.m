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
- (TTStyle*)launcherButton:(UIControlState)state 
{
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

- (TTStyle*)launcherButtonImage:(UIControlState)state
{
    TTStyle* style =
    [TTShapeStyle styleWithShape:[TTRoundedRectangleShape
                                  shapeWithRadius:8] next:
     [TTBoxStyle styleWithMargin:UIEdgeInsetsMake(0, 0, 0, 0)
                         padding:UIEdgeInsetsMake(22, 22, 22, 22)
                         minSize:CGSizeMake(0, 0)
                        position:TTPositionStatic next:
      [TTImageStyle styleWithImageURL:nil defaultImage:nil contentMode:UIViewContentModeScaleAspectFit
                                 size:CGSizeMake(57, 57) next:nil
       ]]];
    
    if (state == UIControlStateHighlighted || state == UIControlStateSelected) {
        [style addStyle:
         [TTBlendStyle styleWithBlend:kCGBlendModeSourceAtop next:
          [TTSolidFillStyle styleWithColor:RGBACOLOR(0,0,0,0.5) next:nil]]];
    }
    
    return style;
}
@end
