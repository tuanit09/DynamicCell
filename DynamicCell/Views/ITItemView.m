//
//  ITItemView.m
//  DynamicCell
//
//  Created by Tuan Anh Nguyen on 8/10/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "ITItemView.h"

@interface ITItemView()
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@end

@implementation ITItemView
@dynamic title;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"ITItemView: %@ is undefined", key);
}
-(void)setViewInfo:(id)info
{
    [self setValuesForKeysWithDictionary:info];
}
-(void)setTitle:(NSString *)title
{
    self.lbTitle.text = title;
}
-(NSString *)title
{
    return self.lbTitle.text;
}
#pragma -mark IB Actions
- (IBAction)btnItemViewPressed:(id)sender {
    if ([self.delegate respondsToSelector:@selector(ITItemViewSelected:)]) {
        [self.delegate ITItemViewSelected:self];
    }
}
@end
