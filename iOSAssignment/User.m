//
//  User.m
//  iOSAssignment
//
//  Created by Jeff Eom on 2017-04-30.
//  Copyright © 2017 Jeff Eom. All rights reserved.
//

#import "User.h"

@implementation User

#pragma mark - Life Cycle
- (instancetype)initUserWithName: (NSString *)name
{
  self = [super init];
  if (self) {
    _displayName = name;
    _onlineFlag = false;
    _acceptedFlag = false;
    _notificationCount = 0;
  }
  return self;
}

@end
