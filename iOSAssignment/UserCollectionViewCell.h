//
//  UserCollectionViewCell.h
//  iOSAssignment
//
//  Created by Jeff Eom on 2017-05-01.
//  Copyright © 2017 Jeff Eom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;
@property (strong, nonatomic) IBOutlet UIImageView *isOnline;
@property (strong, nonatomic) IBOutlet UILabel *notificationNumber;
@property (strong, nonatomic) IBOutlet UIImageView *hasAccepted;
@property (strong, nonatomic) IBOutlet UIView *notificationBadge;

- (instancetype)initWithName: (NSString *)name andImage: (UIImage *)image;

@end
