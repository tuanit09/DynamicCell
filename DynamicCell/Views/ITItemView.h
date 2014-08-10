//
//  ITItemView.h
//  DynamicCell
//
//  Created by Tuan Anh Nguyen on 8/10/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ITItemViewDelegate <NSObject>
-(void)ITItemViewSelected:(id)itemView;
@end

@interface ITItemView : UIView
@property (strong, nonatomic) NSString *title;
@property (weak, nonatomic) id<ITItemViewDelegate>delegate;
-(void)setViewInfo:(id)info;
@end
