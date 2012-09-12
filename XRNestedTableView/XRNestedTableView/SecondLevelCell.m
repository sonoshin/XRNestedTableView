//
//  SecondLevelCell.m
//  XRNestedTableView
//
//  Created by Xinrui Gao on 22/08/12.
//
//

#import "SecondLevelCell.h"

@implementation SecondLevelCell

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
  return theHeight;
}

+ (int) getsubCellHeight
{
  return theSubCellHeight;
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
  ThirdLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThirdLevelCell"];
  
  if (cell == nil)
  {
    [[NSBundle mainBundle] loadNibNamed:@"ThirdLevelCell" owner:self options:nil];
    
    self.thirdCell.label.text = [self.dataSource objectAtIndex:indexPath.row];
    
    cell = self.thirdCell;
    self.thirdCell = nil;
  }
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"Level 3: Row %d has been tapped", indexPath.row);
}

@end

