//
//  ITViewController.m
//  DynamicCell
//
//  Created by Tuan Anh Nguyen on 8/10/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "ITViewController.h"
#import "ITTableViewCell.h"
#import "UIView+ITUtils.h"

static CGFloat const kItemWidth = 150.;
static CGFloat const kItemHeight = 250;

@interface ITViewController ()<UITableViewDataSource, UITableViewDelegate, ITTableViewCellDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *data;
@end

@implementation ITViewController
-(void)viewDidLoad
{
    [super viewDidLoad];

    // dummy data
    self.data = [NSMutableArray arrayWithCapacity:21];
    for (NSInteger idx = 0;  idx < 21; idx++) {
        [self.data addObject:@{
                               @"title" : [NSString stringWithFormat:@"%@", @(idx)]
                               }];
    }
    // create initial table view
    self.tableView = [UITableView new];
}
-(NSInteger)itemsPerCell
{
    return self.tableView.bounds.size.width / kItemWidth;
}
#pragma -mark Refresh Table View
-(void)setTableView:(UITableView *)tableView
{
    // remove current table view
    if (self.tableView) {
        [self.tableView removeFromSuperview];
    }
    _tableView = tableView;
    if (self.tableView) {
        // add view table view
        [self.view addSubviewWithFullSize:self.tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        // some custom properties
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.bounces = NO;
        self.tableView.showsHorizontalScrollIndicator = NO;
        self.tableView.showsVerticalScrollIndicator = NO;
        // register nibs for the new table view
        [self.tableView registerNib:[UINib nibWithNibName:kCellID_ITTableViewCell bundle:nil] forCellReuseIdentifier:kCellID_ITTableViewCell];
    }
}
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    self.tableView = [UITableView new];
}
-(void)dealloc
{
    self.tableView = nil;
}

#pragma -mark Table View DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger itemsPerCell =  [self itemsPerCell];
    if (itemsPerCell) {
        NSInteger itemsCount = [self.data count];
        return  (itemsCount / itemsPerCell) + ((itemsCount % itemsPerCell)? 1 : 0);
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ITTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID_ITTableViewCell];
    cell.delegate = self;
    NSInteger itemsPerCell =  [self itemsPerCell];
    NSInteger length = itemsPerCell;
    NSInteger location = itemsPerCell * [indexPath row];
    if (location + length > [self.data count]) {
        length = [self.data count] - location;
    }
    NSArray *cellInfo = [self.data subarrayWithRange:(NSRange){.location = location, .length = length}];
    [cell setCellInfo:cellInfo];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kItemHeight;
}
#pragma -mark Cell Delegate
-(NSInteger)numberOfItemViewsInITTableViewCell:(id)cell
{
    return [self itemsPerCell];
}
-(void)ITTableViewCell:(id)cell SelectedItemAtIndex:(NSInteger)idx
{
    NSInteger row = [[self.tableView indexPathForCell:cell] row];
    NSInteger dataIdx = row * [self itemsPerCell] + idx;
    NSString *title = [[self.data objectAtIndex:dataIdx] valueForKey:@"title"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Custom Cell ^_^" message:[NSString stringWithFormat:@"You have selected %@", title] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
@end
