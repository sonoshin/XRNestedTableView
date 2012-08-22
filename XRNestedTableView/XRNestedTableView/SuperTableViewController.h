//
//  SuperTableViewController.h
//  XRNestedTableView
//
//  Created by Xinrui Gao on 22/08/12.
//
//

#import <UIKit/UIKit.h>
#import "SuperCell.h"

@interface SuperTableViewController : UITableViewController <UpdateTableHeight>

@property (strong, nonatomic) IBOutlet SuperCell *superCell;

@end
