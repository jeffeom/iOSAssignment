//
//  CircularLayout.m
//  iOSAssignment
//
//  Created by Jeff Eom on 2017-05-01.
//  Copyright © 2017 Jeff Eom. All rights reserved.
//

#import "CircularLayout.h"

@implementation CircularLayout

-(void)prepareLayout
{
  [super prepareLayout];
  
  CGSize size = self.collectionView.frame.size;
  _cellCount = [[self collectionView] numberOfItemsInSection:0];
  _center = CGPointMake(size.width / 2.0, size.height / 2.0);
  _radius = MIN(size.width, size.height) / 3;
}

-(CGSize)collectionViewContentSize
{
  return [self collectionView].frame.size;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
  UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
  CGSize cellSize = CGSizeMake(self.collectionView.frame.size.height / 4, self.collectionView.frame.size.width / 4);
  attributes.size = cellSize;
  attributes.center = CGPointMake(_center.x + _radius * cosf(2 * path.item * M_PI / _cellCount),
                                  _center.y + _radius * sinf(2 * path.item * M_PI / _cellCount));
  return attributes;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
  NSMutableArray* attributes = [NSMutableArray array];
  for (NSInteger i=0 ; i < self.cellCount; i++) {
    NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
    [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
  }
  return attributes;
}

@end
