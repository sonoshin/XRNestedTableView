//
//  XRNestedTableView.h
//  XRNestedTableView
//
//  Created by Xinrui Gao on 11/09/12.
//  Copyright (c) 2012 Xinrui Gao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstLevelCell.h"

@protocol XRNestedTableViewDelegate;

@interface XRNestedTableViewController : UITableViewController <UpdateTableHeight>
{
  NSMutableDictionary *expandedStatus;
  BOOL needExpandAgain;
  CGFloat expandDiff;
}

@property (strong, nonatomic) IBOutlet FirstLevelCell *firstLevelCell;
@property (nonatomic) id <XRNestedTableViewDelegate> delegate;

@property (strong, nonatomic) NSArray *dataSource;

@end

@protocol XRNestedTableViewDelegate <NSObject>

@optional
- (NSInteger)nestedTableView:(XRNestedTableViewController *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)nestedTableView:(XRNestedTableViewController *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end