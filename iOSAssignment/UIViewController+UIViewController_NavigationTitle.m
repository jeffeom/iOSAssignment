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
  TabBarController *tc = (TabBarController *) self.tabBarController;
  tc.navTitlelabel.textAlignment = NSTextAlignmentCenter;
  tc.navTitlelabel.text = titleArray[self.tabBarItem.tag];
  tc.navTitlelabel.textColor = [UIColor whiteColor];
}

@end
