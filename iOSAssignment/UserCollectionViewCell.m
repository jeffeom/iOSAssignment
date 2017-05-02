//
//  UserCollectionViewCell.m
//  iOSAssignment
//
//  Created by Jeff Eom on 2017-05-01.
//  Copyright © 2017 Jeff Eom. All rights reserved.
//

#import "UserCollectionViewCell.h"

@implementation UserCollectionViewCell

- (instancetype)initWithName: (NSString *)name andImage: (UIImage *)image {
  _nameLabel.text = name;
  _image.image = image;
  self.imageWidth.constant = self.frame.size.width + 20;
  self.layer.cornerRadius = self.frame.size.height / 2;
  _hasAccepted.image = [UIImage imageNamed:@"accepted"];
  return self;
}
@end
