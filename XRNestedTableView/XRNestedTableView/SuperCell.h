//
//  SuperCell.h
//  XRNestedTableView
//
//  Created by Xinrui Gao on 22/08/12.
//
//

#import <UIKit/UIKit.h>
#import "SecondLevelCell.h"

@protocol UpdateTableHeight <NSObject>

- (void)updateTableHeightWithDiff:(CGFloat)diff;

@end

static const int superHeight = 50;
static const int subGroupCellHeight = 50;

@interface SuperCell : UITableViewCell <UITableViewDataSource, UITableViewDelegate>{
  NSMutableDictionary *expandedIndexes;
}

@property (nonatomic) id <UpdateTableHeight> delegate;

@property (strong, nonatomic) IBOutlet SecondLevelCell *secondCell;

@property (strong, nonatomic) NSMutableDictionary *expandedIndexes;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UITableView *superTableView;

+ (int) getHeight;
+ (int) getsubCellHeight;
- (void) updateTable;

@end
