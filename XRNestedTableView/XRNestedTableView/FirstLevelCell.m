//
//  SuperCell.m
//  XRNestedTableView
//
//  Created by Xinrui Gao on 22/08/12.
//
//

#import "FirstLevelCell.h"

@implementation FirstLevelCell
@synthesize expandedIndexes;

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
  [self.superTableView beginUpdates];
  [self.superTableView endUpdates];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  SecondLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondLevelCell"];
  
  if (cell == nil)
  {
    [[NSBundle mainBundle] loadNibNamed:@"SecondLevelCell" owner:self options:nil];
    
    //data source
    self.secondCell.dataSource = [self.dataSource objectAtIndex:indexPath.row];
    
    self.secondCell.label.text = @"Level 2 cell";
    
    cell = self.secondCell;
    self.secondCell = nil;
  }
  
  return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  BOOL isExpanded = [[expandedIndexes objectForKey:indexPath] boolValue];
  if(isExpanded)
  {
    NSInteger indexRow = indexPath.row; //important and necessary, because after the next updateTableHeightWithDiff method, indexPath.row changed!!!!!
    [self.delegate updateTableHeightWithDiff:([SecondLevelCell getsubCellHeight]*[[self.dataSource objectAtIndex:indexPath.row] count])];
    //NSLog(@"Print indexpath: %d", indexPath.row);
    return [SecondLevelCell getHeight]+[SecondLevelCell getsubCellHeight]*[[self.dataSource objectAtIndex:indexRow] count];
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
  
  if (!expandedIndexes) {
    expandedIndexes = [[NSMutableDictionary alloc] init];
  }
  
	BOOL isExpanded = ![[expandedIndexes objectForKey:indexPath] boolValue];
	NSNumber *expandedIndex = [NSNumber numberWithBool:isExpanded];
  [expandedIndexes removeAllObjects];
	[expandedIndexes setObject:expandedIndex forKey:indexPath];

  if (!isExpanded) {
    [self.delegate updateTableHeightWithDiff:0];
  }
  [self.superTableView beginUpdates];
  [self.superTableView endUpdates];
}

@end
