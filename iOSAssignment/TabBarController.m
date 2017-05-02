//
//  TabBarController.m
//  iOSAssignment
//
//  Created by Jeff Eom on 2017-04-30.
//  Copyright © 2017 Jeff Eom. All rights reserved.
//

#import "TabBarController.h"

#pragma mark - Property
@interface TabBarController ()
@property (strong, nonatomic) IBOutlet UIView *theView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UIImageView *arrowImage;
@end

#pragma mark - IBAction
@implementation TabBarController
- (IBAction)navBarTitleTapped:(id)sender {
  if (self.navigationItem.titleView != self.searchBar) {
    [self rotateArrow];
  }
}
- (IBAction)searchTapped:(id)sender {
  switch (self.navigationItem.titleView == self.searchBar) {
    case true:
      self.navigationItem.titleView = self.theView;
      break;
    case false:
      self.navigationItem.titleView = self.searchBar;
      break;
  }
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
  ViewController *myCircle = (ViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"myCircle"];
  PlaceHolderViewController *feed = [[PlaceHolderViewController alloc] init];
  PlaceHolderViewController *programs = [[PlaceHolderViewController alloc] init];
  PlaceHolderViewController *myHealth = [[PlaceHolderViewController alloc] init];
  PlaceHolderViewController *profile = [[PlaceHolderViewController alloc] init];
  
  NSArray *tabViewControllers = [[NSArray alloc] initWithObjects: feed, myCircle, programs, myHealth, profile, nil];
  
  [self setViewControllers:tabViewControllers];
  
  feed.tabBarItem = [self setTabbarItemWithImage: [self scaleImage:[UIImage imageNamed:@"feed"]
                                                         withWidth: 20.0
                                                         andHeight: 30.0]
                                          andTag:0];
  
  myCircle.tabBarItem = [self setTabbarItemWithImage: [self scaleImage:[UIImage imageNamed:@"myCircle"]
                                                             withWidth: 35.0
                                                             andHeight: 30.0]
                                              andTag:1];
  
  programs.tabBarItem = [self setTabbarItemWithImage: [self scaleImage:[UIImage imageNamed:@"programs"]
                                                             withWidth: 35.0
                                                             andHeight: 30.0]
                                              andTag:2];
  
  myHealth.tabBarItem = [self setTabbarItemWithImage: [self scaleImage:[UIImage imageNamed:@"myHealth"]
                                                             withWidth: 35.0
                                                             andHeight: 30.0]
                                              andTag:3];
  
  profile.tabBarItem = [self setTabbarItemWithImage: [self scaleImage:[UIImage imageNamed:@"profile"]
                                                            withWidth: 25.0
                                                            andHeight: 30.0]
                                             andTag:4];
  
  self.selectedIndex = 1;
}

#pragma mark - Personal Function
- (UIImage *)scaleImage: (UIImage *)imageToResize withWidth: (CGFloat)width andHeight: (CGFloat)height {
  UIImage *image = imageToResize;
  CGSize sacleSize = CGSizeMake(width, height);
  UIGraphicsBeginImageContextWithOptions(sacleSize, NO, 0.0);
  [image drawInRect:CGRectMake(0, 0, sacleSize.width, sacleSize.height)];
  UIImage * resizedImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return resizedImage;
}

- (UITabBarItem *)setTabbarItemWithImage: (UIImage *)image andTag: (NSInteger)tagNumber {
  UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:nil
                                                     image:image
                                                       tag:tagNumber];
  item.imageInsets = UIEdgeInsetsMake(9, 0, -9, 0);
  return item;
}

- (void)rotateArrow {
  [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
    [self.arrowImage setTransform:CGAffineTransformRotate(self.arrowImage.transform, M_PI)];
  }completion:nil];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
  self.navigationItem.titleView = self.theView;
}

@end
