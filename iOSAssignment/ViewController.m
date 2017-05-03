//
//  ViewController.m
//  iOSAssignment
//
//  Created by Jeff Eom on 2017-04-30.
//  Copyright © 2017 Jeff Eom. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

#pragma mark - Property
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIImageView *loggedInUser;
@property (strong, nonatomic) NSArray *arrayOfUsers;
@property NSInteger zCount;
@property UICollectionViewCell *historyCell;

@end

@implementation ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
  [super viewDidLoad];
  
  UsersFromJson *object = [[UsersFromJson alloc] init];
  NSDictionary *jsonList = [object fetchObjects];
  self.arrayOfUsers = [self mapArrayOfUsersWithJSONDictionary:jsonList];
  self.cellCount = self.arrayOfUsers.count;
  [self.collectionView reloadData];
  self.zCount = 0;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  [self setTitleWithTag];
}

#pragma mark - CollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
  return self.cellCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
  UserCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"userCell" forIndexPath:indexPath];
  User *aUser = (User *)[self.arrayOfUsers objectAtIndex:indexPath.row];
  cell = [cell initWithName:aUser.displayName andImage:[UIImage imageNamed:aUser.displayName]];
  
  if (aUser.isOnline) {
    cell.isOnline.image = [UIImage imageNamed:@"online"];
  }else{
    cell.isOnline.image = [UIImage imageNamed:@"offline"];
  }
  
  if (aUser.hasAccepted) {
    cell.hasAccepted.hidden = true;
  }else {
    cell.hasAccepted.hidden = false;
  }
  
  cell.notificationNumber.text = aUser.notificationCount.stringValue;
  switch (aUser.notificationCount.intValue) {
    case 0:
      cell.notificationBadge.hidden = true;
      break;
    default:
      cell.notificationBadge.hidden = false;
      break;
  }
  return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
  CGFloat badgeHalfSize = 15 / 2.0;
  CGPoint centerOfCV = CGPointMake(self.collectionView.frame.size.width / 2.0, self.collectionView.frame.size.height / 2.0);
  CGPoint centerWithAcc = CGPointMake(self.loggedInUser.center.x - badgeHalfSize, self.loggedInUser.center.y - badgeHalfSize);
  UICollectionViewCell *datasetCell = [collectionView cellForItemAtIndexPath:indexPath];
  if (CGPointEqualToPoint(datasetCell.center,centerOfCV) || CGPointEqualToPoint(datasetCell.center,centerWithAcc))
  {
    BOOL animationsEnabled = [UIView areAnimationsEnabled];
    [UIView setAnimationsEnabled:NO];
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    [UIView setAnimationsEnabled:animationsEnabled];
  }else {
    if (self.historyCell != nil && !self.historyCell.hidden ) {
      self.historyCell.center = centerOfCV;
      [self.historyCell addSubview:datasetCell];
      datasetCell.center = centerWithAcc;
      [self.historyCell bringSubviewToFront:datasetCell];
    }else {
      datasetCell.center = centerOfCV;
      self.historyCell = datasetCell;
    }
  }
}

#pragma mark - Fetch data from JSON
- (NSArray *)mapArrayOfUsersWithJSONDictionary:(NSDictionary *)jsonDictionary {
  NSMutableArray *arrayOfUsers = [NSMutableArray new];
  for (NSDictionary* value in jsonDictionary.allValues) {
    User *aUser = [User new];
    aUser.displayName = value[@"name"];
    NSNumber *onlineBoolInNumber = [value objectForKey:@"online"];
    NSInteger onlineFlagBool = [onlineBoolInNumber integerValue];
    switch (onlineFlagBool) {
      case 0:
        aUser.onlineFlag = false;
        break;
      case 1:
        aUser.onlineFlag = true;
        break;
    }
    NSNumber *acceptedBoolInNumber = [value objectForKey:@"accepted"];
    NSInteger acceptedFlagBool = [acceptedBoolInNumber integerValue];
    switch (acceptedFlagBool) {
      case 0:
        aUser.acceptedFlag = false;
        break;
      case 1:
        aUser.acceptedFlag = true;
        break;
    }
    aUser.notificationCount = [value objectForKey:@"notificationCount"];
    [arrayOfUsers addObject:aUser];
  }
  return arrayOfUsers;
}

@end
