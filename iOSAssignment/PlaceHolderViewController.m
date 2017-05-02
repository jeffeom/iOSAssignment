//
//  PlaceHolderViewController.m
//  iOSAssignment
//
//  Created by Jeff Eom on 2017-05-01.
//  Copyright © 2017 Jeff Eom. All rights reserved.
//

#import "PlaceHolderViewController.h"

@interface PlaceHolderViewController ()

@end

@implementation PlaceHolderViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  [self setTitleWithTag];
}

@end
