//
//  UIViewController+UIViewController_NavigationTitle.m
//  iOSAssignment
//
//  Created by Jeff Eom on 2017-05-01.
//  Copyright © 2017 Jeff Eom. All rights reserved.
//

#import "UIViewController+UIViewController_NavigationTitle.h"

@implementation UIViewController (UIViewController_NavigationTitle)

- (void)setTitleWithTag {
  NSArray *titleArray = [[NSArray alloc] initWithObjects:@"Feed", @"Parkinson's", @"Programs", @"My Health", @"Profile", nil];
  TabBarController *tabBarController = (TabBarController *) self.tabBarController;
  tabBarController.navTitlelabel.textAlignment = NSTextAlignmentCenter;
  tabBarController.navTitlelabel.text = titleArray[self.tabBarItem.tag];
  tabBarController.navTitlelabel.textColor = [UIColor whiteColor];
}

@end
