//
//  XRNestedTableView.m
//  XRNestedTableView
//
//  Created by Xinrui Gao on 11/09/12.
//  Copyright (c) 2012 Xinrui Gao. All rights reserved.
//

#import "XRNestedTableViewController.h"

@implementation XRNestedTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self) {
    // Custom initialization
  }
  return self;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  FirstLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstLevelCell"];
  
  if (cell == nil)
  {
    [[NSBundle mainBundle] loadNibNamed:@"FirstLevelCell" owner:self options:nil];
    self.firstLevelCell.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self.firstLevelCell
                                             selector:@selector(updateTable)
                                                 name:@"MainTableViewCellDidSelect"
                                               object:nil];
    //data source
    self.firstLevelCell.dataSource = [self.dataSource objectAtIndex:indexPath.row];
    
    self.firstLevelCell.label.text = @"Level 1 cell";
    
    cell = self.firstLevelCell;
    self.firstLevelCell = nil;
  }
  return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (!expandedStatus) {
    expandedStatus = [[NSMutableDictionary alloc] init];
  }
  BOOL isExpanded = [[expandedStatus objectForKey:indexPath] boolValue];
  if(isExpanded)
  {
    if (needExpandAgain) {
      needExpandAgain = NO;
      return [FirstLevelCell getHeight] + [FirstLevelCell getsubCellHeight]*[[self.dataSource objectAtIndex:indexPath.row] count] + expandDiff;
    }
    return [FirstLevelCell getHeight] + [FirstLevelCell getsubCellHeight]*[[self.dataSource objectAtIndex:indexPath.row] count];
  }
  return [FirstLevelCell getHeight];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"Level 1: Row %d has been tapped", indexPath.row);
  if ( indexPath == nil )
    return;
  expandDiff = 0;
	BOOL isExpanded = ![[expandedStatus objectForKey:indexPath] boolValue];
	NSNumber *expandedIndex = [NSNumber numberWithBool:isExpanded];
  [expandedStatus removeAllObjects];
	[expandedStatus setObject:expandedIndex forKey:indexPath];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:@"MainTableViewCellDidSelect" object:nil];
  
  [self.tableView beginUpdates];
  [self.tableView endUpdates];
}

- (void)updateTableHeightWithDiff:(CGFloat)diff {
  needExpandAgain = YES;
  expandDiff = diff;
  [self.tableView beginUpdates];
  [self.tableView endUpdates];
}

@end
