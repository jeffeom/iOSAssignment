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
  
  if (aUser.isOnline) {
    cell.isOnline.image = [UIImage imageNamed:@"online"];
  }else {
    cell.isOnline.image = [UIImage imageNamed:@"offline"];
  }
  
  if (aUser.hasAccepted) {
    cell.hasAccepted.hidden = true;
  }else {
    cell.hasAccepted.hidden = false;
  }
  
  cell.notificationNumber.text = aUser.notificationCount.stringValue;
  if (aUser.notificationCount.intValue == 0){
    cell.notificationBadge.hidden = true;
  }else {
    cell.notificationBadge.hidden = false;
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
    
    if (onlineFlagBool == 0) {
      aUser.onlineFlag = false;
    }else {
      aUser.onlineFlag = true;
    }
    
    NSNumber *acceptedBoolInNumber = [value objectForKey:@"accepted"];
    NSInteger acceptedFlagBool = [acceptedBoolInNumber integerValue];
    
    if (acceptedFlagBool == 0) {
      aUser.acceptedFlag = false;
    }else {
      aUser.acceptedFlag = true;
    }
    
    aUser.notificationCount = [value objectForKey:@"notificationCount"];
    [arrayOfUsers addObject:aUser];
  }
  return arrayOfUsers;
}

@end
