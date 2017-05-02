//
//  CircularLayout.h
//  iOSAssignment
//
//  Created by Jeff Eom on 2017-05-01.
//  Copyright © 2017 Jeff Eom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularLayout : UICollectionViewLayout

@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) NSInteger cellCount;

@end
