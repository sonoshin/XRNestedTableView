//
//  SuperTableViewController.h
//  XRNestedTableView
//
//  Created by Xinrui Gao on 22/08/12.
//
//

#import <UIKit/UIKit.h>
#import "FirstLevelCell.h"

@interface SuperTableViewController : UITableViewController <UpdateTableHeight>

@property (strong, nonatomic) IBOutlet FirstLevelCell *superCell;

@property (nonatomic) NSInteger firstLevelSectionNumber, firstLevelRowsForSection;
@property (nonatomic) NSInteger secondLevelSectionNumber, secondLevelRowsForSection;
@property (nonatomic) NSInteger thirdLevelSectionNumber, thirdLevelRowsForSection;

@end
