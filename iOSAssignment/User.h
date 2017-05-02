//
//  User.h
//  iOSAssignment
//
//  Created by Jeff Eom on 2017-04-30.
//  Copyright © 2017 Jeff Eom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

#pragma mark - Public

@property (copy, nonatomic) NSString *displayName;
@property (assign, getter=isOnline) BOOL onlineFlag;
@property (assign, getter=hasAccepted) BOOL acceptedFlag;
@property (copy, nonatomic) NSNumber* notificationCount;

- (instancetype)initUserWithName: (NSString *)name;

@end
