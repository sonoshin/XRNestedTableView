//
//  SecondLevelCell.h
//  XRNestedTableView
//
//  Created by Xinrui Gao on 22/08/12.
//
//

#import <UIKit/UIKit.h>
#import "ThirdLevelCell.h"

static const int theHeight = 40;
static const int theSubCellHeight = 30;

@interface SecondLevelCell : UITableViewCell <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet ThirdLevelCell *thirdCell;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *label;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *subTableView;

@property (strong, nonatomic) NSArray *dataSource;

+ (int) getHeight;
+ (int) getsubCellHeight;

@end
