//
//  UIView+ITUtils.m
//  DynamicCell
//
//  Created by Tuan Anh Nguyen on 8/10/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "UIView+ITUtils.h"

@implementation UIView (ITUtils)
// convenient method to add subview with full size and "Flexible Size" mask
-(void)addSubviewWithFullSize:(UIView *)view
{
    if (view) {
        view.frame = self.bounds;
        view.autoresizingMask = UIViewAutoresizingFlexibleSize;
        [self addSubview:view];
    }
}

// convenient method to load view from nib
+(id)viewWithNibName:(NSString *)nameOrNil
{
    NSString *nibName = nameOrNil? nameOrNil : NSStringFromClass([self class]);
    return [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] firstObject];
}
@end
