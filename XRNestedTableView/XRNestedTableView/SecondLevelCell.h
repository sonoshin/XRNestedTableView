//
//  SecondLevelCell.h
//  XRNestedTableView
//
//  Created by Xinrui Gao on 22/08/12.
//
//

#import <UIKit/UIKit.h>
#import "ThirdLevelCell.h"

static const int theHeight = 50;
static const int theSubCellHeight = 50;

@interface SecondLevelCell : UITableViewCell <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet ThirdLevelCell *thirdCell;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *label;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *subTableView;

+ (int) getHeight;
+ (int) getsubCellHeight;

@end
