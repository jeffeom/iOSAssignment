//
//  UsersFromJson.m
//  iOSAssignment
//
//  Created by Jeff Eom on 2017-05-01.
//  Copyright © 2017 Jeff Eom. All rights reserved.
//

#import "UsersFromJson.h"

@implementation UsersFromJson

- (NSDictionary *)fetchObjects {
  NSError *error;
  NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"DummyUsers" ofType:@"json"];
  NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
  if (jsonData == nil) {
    NSLog(@"%@", error.localizedDescription);
  }
  NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
  if (jsonArray == nil) {
    NSLog(@"%@", error.localizedDescription);
  }
  return jsonArray[@"USERS"][0];
}

@end
