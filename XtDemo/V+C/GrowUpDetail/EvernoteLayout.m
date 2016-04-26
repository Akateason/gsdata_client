//
//  EvernoteLayout.m
//  XtDemo
//
//  Created by teason on 16/4/26.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "EvernoteLayout.h"

static CGFloat cellHeight = 50. ;
static CGFloat SpringFactor = 10. ;

@implementation EvernoteLayout

- (instancetype)init
{
    self = [super init] ;
    if (self) {
        self.itemSize = CGSizeMake(cellWidth, cellHeight) ;
        self.headerReferenceSize = CGSizeMake(screenWidth, verticallyPadding) ;
    }
    return self ;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder] ;
    if (self) {
        self.itemSize = CGSizeMake(cellWidth, cellHeight) ;
        self.headerReferenceSize = CGSizeMake(screenWidth, verticallyPadding) ;
    }
    return self ;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return true ;
}

// return an array layout attributes instances for all the views in the given rect
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    CGFloat offsetY = self.collectionView.contentOffset.y ;
    NSArray *attrsArray = [super layoutAttributesForElementsInRect:rect] ;
    CGFloat collectionViewFrameHeight = self.collectionView.frame.size.height ;
    CGFloat collectionViewContentHeight = self.collectionView.contentSize.height ;
    CGFloat ScrollViewContentInsetBottom = self.collectionView.contentInset.bottom ;
    CGFloat bottomOffset = offsetY + collectionViewFrameHeight - collectionViewContentHeight - ScrollViewContentInsetBottom ;
    CGFloat numOfItems = [self.collectionView numberOfSections] ;
    
    for (UICollectionViewLayoutAttributes *attr in attrsArray)
    {
        if (attr.representedElementCategory == UICollectionElementCategoryCell)
        {
            CGRect cellRect = attr.frame ;
            if ( offsetY <= 0 )
            {
                float distance = fabs(offsetY) / SpringFactor ;
                cellRect.origin.y += offsetY + distance * (attr.indexPath.section + 1) ;
            }
            else if ( bottomOffset > 0 )
            {
                float distance = bottomOffset / SpringFactor ;
                cellRect.origin.y += bottomOffset - distance * (numOfItems - attr.indexPath.section) ;
            }
            attr.frame = cellRect ;
        }
    }
    
    return attrsArray;
}

@end
