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
  
  switch (aUser.isOnline) {
    case true:
      cell.isOnline.image = [UIImage imageNamed:@"online"];
      break;
    case false:
      cell.isOnline.image = [UIImage imageNamed:@"offline"];
      break;
  }
  
  switch (aUser.hasAccepted) {
    case true:
      cell.hasAccepted.hidden = true;
      break;
    case false:
      cell.hasAccepted.hidden = false;
      break;
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
  CGPoint centerOfCV = CGPointMake(self.collectionView.frame.size.width / 2.0, self.collectionView.frame.size.height / 2.0);
  UICollectionViewCell *datasetCell = [collectionView cellForItemAtIndexPath:indexPath];
  if (CGPointEqualToPoint(datasetCell.center,centerOfCV))
  {
    [self.collectionView performBatchUpdates:^{
      [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    } completion:nil];
  }else {
    [UIView animateWithDuration:1.0 animations:^{
      datasetCell.center = centerOfCV;
    }];
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
