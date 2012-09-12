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
  if ([self.dataSource isKindOfClass:[NSArray class]]) {
    return self.dataSource.count;
  }else{
    return 0;
  }
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
    if ([self.dataSource isKindOfClass:[NSArray class]]) {
      self.firstLevelCell.dataSource = [self.dataSource objectAtIndex:indexPath.row];
      self.firstLevelCell.label.text = [NSString stringWithFormat:@"Level 1 cell %d", indexPath.row];
    }
    
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
  
  BOOL hasChild = NO;
  if ([[self.dataSource objectAtIndex:indexPath.row] isKindOfClass:[NSArray class]]
      && [[self.dataSource objectAtIndex:indexPath.row] count] > 1) {
    hasChild = YES;
  }
  
  BOOL isExpanded = [[expandedStatus objectForKey:indexPath] boolValue];
  if(hasChild && isExpanded)
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
  
  if (!([[self.dataSource objectAtIndex:indexPath.row] isKindOfClass:[NSArray class]]
        && [[self.dataSource objectAtIndex:indexPath.row] count] > 1)) {
    [expandedStatus removeAllObjects];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MainTableViewCellDidSelect" object:nil];
    [tableView beginUpdates];
    [tableView endUpdates];
    NSLog(@"Level 2: Row %d has been selected", indexPath.row);
    return;
  }
  
  expandDiff = 0;
	BOOL isExpanded = ![[expandedStatus objectForKey:indexPath] boolValue];
	NSNumber *expandedIndex = [NSNumber numberWithBool:isExpanded];
  [expandedStatus removeAllObjects];
	[expandedStatus setObject:expandedIndex forKey:indexPath];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:@"MainTableViewCellDidSelect" object:nil];
  
  [tableView beginUpdates];
  [tableView endUpdates];
}

- (void)updateTableHeightWithDiff:(CGFloat)diff {
  needExpandAgain = YES;
  expandDiff = diff;
  [self.tableView beginUpdates];
  [self.tableView endUpdates];
}

@end
