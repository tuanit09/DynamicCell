//
//  ITTableViewCell.m
//  DynamicCell
//
//  Created by Tuan Anh Nguyen on 8/10/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "ITTableViewCell.h"
#import "UIView+ITUtils.h"
#import "ITItemView.h"

@interface ITTableViewCell()<ITItemViewDelegate>
@property (strong, nonatomic) NSArray *itemViews;
@end

@implementation ITTableViewCell

// load item views for cell
-(void)loadItemViews
{
    NSInteger numberOfItemViews = [self.delegate numberOfItemViewsInITTableViewCell:self];
    NSMutableArray *itemViews = [NSMutableArray arrayWithCapacity:numberOfItemViews];
    while (numberOfItemViews--) {
        [itemViews addObject:[ITItemView viewWithNibName:nil]];
    }
    self.itemViews = itemViews;
}
-(void)setItemViews:(NSArray *)itemViews
{
    if (self.itemViews) {
        for (UIView *itemView in self.itemViews) {
            [itemView removeFromSuperview];
        }
    }
    _itemViews = itemViews;
    if (self.itemViews) {
        for (ITItemView *itemView in self.itemViews) {
            itemView.delegate = self;
            [self addSubview:itemView];
        }
    }
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if ([self.itemViews count]) {
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat height = self.bounds.size.height;
        CGFloat width = self.bounds.size.width / [self.itemViews count];
        for (UIView *itemView in self.itemViews) {
            itemView.frame = CGRectMake(x, y, width, height);
            x += width;
        }
    }
}
-(void)setDelegate:(id<ITTableViewCellDelegate>)delegate
{
    _delegate = delegate;
    if (!self.itemViews) {
        [self loadItemViews];
    }
}

// void set array of item
-(void)setCellInfo:(id)info
{
    if (!self.itemViews) {
        [self loadItemViews];
    }
    for (NSInteger idx = 0; idx < [self.itemViews count]; idx++) {
        ITItemView *itemView = [self.itemViews objectAtIndex:idx];
        if (idx < [info count]) {
            itemView.hidden = NO;
            [itemView setViewInfo:[info objectAtIndex:idx]];
        }
        else
        {
            itemView.hidden = YES;
        }
    }
}

#pragma -mark Item View Delegate
-(void)ITItemViewSelected:(id)itemView
{
    if ([self.delegate respondsToSelector:@selector(ITTableViewCell:SelectedItemAtIndex:)]) {
        NSInteger selectedIdx = [self.itemViews indexOfObject:itemView];
        [self.delegate ITTableViewCell:self SelectedItemAtIndex:selectedIdx];
    }
}
@end
