//
//  SuperCell.m
//  XRNestedTableView
//
//  Created by Xinrui Gao on 22/08/12.
//
//

#import "FirstLevelCell.h"

@implementation FirstLevelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
      
    }
    return self;
}

+ (int) getHeight
{
  return superHeight;
}

+ (int) getsubCellHeight
{
  return subGroupCellHeight;
}

- (void) updateTable
{
  [expandedIndexes removeAllObjects];
  [self.subTableView beginUpdates];
  [self.subTableView endUpdates];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  if ([self.dataSource isKindOfClass:[NSArray class]]) {
    return 1;
  }else{
    return 0;
  }
}

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
  SecondLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondLevelCell"];

  if (cell == nil)
  {
    [[NSBundle mainBundle] loadNibNamed:@"SecondLevelCell" owner:self options:nil];
    
    //data source
    if ([self.dataSource isKindOfClass:[NSArray class]]) {
      self.secondCell.dataSource = [self.dataSource objectAtIndex:indexPath.row];
      self.secondCell.label.text = [NSString stringWithFormat:@"Level 2 cell %d", indexPath.row];
    }
     
    cell = self.secondCell;
    self.secondCell = nil;
  }
  return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  BOOL hasChild = NO;
  if ([[self.dataSource objectAtIndex:indexPath.row] isKindOfClass:[NSArray class]]
      && [[self.dataSource objectAtIndex:indexPath.row] count] > 1) {
    hasChild = YES;
  }
  BOOL isExpanded = [[expandedIndexes objectForKey:indexPath] boolValue];
  //NSLog(@"Has child? %@ Is Expanded? %@", hasChild?@"YES":@"NO", isExpanded?@"YES":@"NO");
  
  if(hasChild && isExpanded)
  {
    return [SecondLevelCell getHeight]+[SecondLevelCell getsubCellHeight]*[[self.dataSource objectAtIndex:indexPath.row] count];
  }else {
    return [SecondLevelCell getHeight];
  }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"Level 2: Row %d has been tapped", indexPath.row);
  
  if ( indexPath == nil )
    return;
  
  if (!([[self.dataSource objectAtIndex:indexPath.row] isKindOfClass:[NSArray class]]
      && [[self.dataSource objectAtIndex:indexPath.row] count] > 1)) {
    [expandedIndexes removeAllObjects];
    [self.delegate updateTableHeightWithDiff:0];
    [tableView beginUpdates];
    [tableView endUpdates];
    NSLog(@"Level 2: Row %d has been selected", indexPath.row);
    return;
  }
  
  if (!expandedIndexes) {
    expandedIndexes = [[NSMutableDictionary alloc] init];
  }
  NSLog(@"Level 2: IndexPath %@ has been selected", indexPath);
  
	BOOL isExpanded = ![[expandedIndexes objectForKey:indexPath] boolValue];
	NSNumber *expandedIndex = [NSNumber numberWithBool:isExpanded];
  [expandedIndexes removeAllObjects];
	[expandedIndexes setObject:expandedIndex forKey:indexPath];

  if (!isExpanded) {
    [self.delegate updateTableHeightWithDiff:0];
  }else {
    [self.delegate updateTableHeightWithDiff:([SecondLevelCell getsubCellHeight]*[[self.dataSource objectAtIndex:indexPath.row] count])];
  }
  [tableView beginUpdates];
  [tableView endUpdates];
  
}

@end
