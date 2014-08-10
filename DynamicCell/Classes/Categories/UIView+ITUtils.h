//
//  UIView+ITUtils.h
//  DynamicCell
//
//  Created by Tuan Anh Nguyen on 8/10/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

// Flexible Size mask for view autoresizing
#define UIViewAutoresizingFlexibleSize (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)

@interface UIView (ITUtils)
// convenient method to add subview with full size and "Flexible Size" mask
-(void)addSubviewWithFullSize:(UIView *)view;
// convenient method to load view from nib
+(id)viewWithNibName:(NSString *)nameOrNil;
@end
