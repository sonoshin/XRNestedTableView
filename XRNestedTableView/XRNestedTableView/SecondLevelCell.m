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
  if ([self.dataSource isKindOfClass:[NSArray class]]) {
    return self.dataSource.count;
  }else{
    return 0;
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  ThirdLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThirdLevelCell"];
  
  if (cell == nil)
  {
    [[NSBundle mainBundle] loadNibNamed:@"ThirdLevelCell" owner:self options:nil];
    
    if ([self.dataSource isKindOfClass:[NSArray class]]) {
      self.thirdCell.label.text = [self.dataSource objectAtIndex:indexPath.row];
    }else if ([self.dataSource isKindOfClass:[NSString class]]){
      self.thirdCell.label.text = (NSString *)self.dataSource;
    }
    
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

