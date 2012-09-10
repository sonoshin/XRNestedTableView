//
//  SuperTableViewController.m
//  XRNestedTableView
//
//  Created by Xinrui Gao on 22/08/12.
//
//

#import "SuperTableViewController.h"

@interface SuperTableViewController () {
  NSMutableDictionary *expandedStatus;
  BOOL needExpandAgain;
  CGFloat expandDiff;
}


@end

@implementation SuperTableViewController
@synthesize firstLevelRowsForSection, firstLevelSectionNumber, secondLevelRowsForSection, secondLevelSectionNumber, thirdLevelRowsForSection, thirdLevelSectionNumber;

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  expandedStatus = [[NSMutableDictionary alloc] init];
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;
  
  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  return self.firstLevelSectionNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  return self.firstLevelRowsForSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  FirstLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstLevelCell"];
  
  if (cell == nil)
  {
    [[NSBundle mainBundle] loadNibNamed:@"FirstLevelCell" owner:self options:nil];
    self.superCell.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self.superCell
                                             selector:@selector(updateTable)
                                                 name:@"MainTableViewCellDidSelect"
                                               object:nil];
    //data source
    self.superCell.numberOfSections = self.secondLevelSectionNumber;
    self.superCell.numberOfRowsInSection = self.secondLevelRowsForSection;
    self.superCell.numberOfSectionsForNextLevel = self.thirdLevelSectionNumber;
    self.superCell.numberOfRowsInSectionForNextLevel = self.thirdLevelRowsForSection;
    
    self.superCell.label.text = @"Level 1 cell";
    
    cell = self.superCell;
    self.superCell = nil;
  }
  return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  BOOL isExpanded = [[expandedStatus objectForKey:indexPath] boolValue];
  if(isExpanded)
  {
    if (needExpandAgain) {
      needExpandAgain = NO;
      return [FirstLevelCell getHeight] + [FirstLevelCell getsubCellHeight]*self.secondLevelRowsForSection + expandDiff;
    }
    return [FirstLevelCell getHeight] + [FirstLevelCell getsubCellHeight]*self.secondLevelRowsForSection;
  }
  return [FirstLevelCell getHeight];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
