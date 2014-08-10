//
//  ITTableViewCell.h
//  DynamicCell
//
//  Created by Tuan Anh Nguyen on 8/10/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *kCellID_ITTableViewCell = @"ITTableViewCell";

@protocol ITTableViewCellDelegate <NSObject>
@required
-(NSInteger)numberOfItemViewsInITTableViewCell:(id)cell;
@optional
-(void)ITTableViewCell:(id)cell SelectedItemAtIndex:(NSInteger)idx;
@end

@interface ITTableViewCell : UITableViewCell
@property (weak, nonatomic) id<ITTableViewCellDelegate>delegate;
-(void)setCellInfo:(id)info;
@end
