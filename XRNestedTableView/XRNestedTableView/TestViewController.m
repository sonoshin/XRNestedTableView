//
//  SuperTableViewController.m
//  XRNestedTableView
//
//  Created by Xinrui Gao on 22/08/12.
//
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (id) init
{
  if (self = [super initWithNibName:@"XRNestedTableViewController" bundle:nil])
  {
    // do init stuff
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

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

@end
