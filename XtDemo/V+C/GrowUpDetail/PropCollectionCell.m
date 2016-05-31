//
//  PropCollectionCell.m
//  XtDemo
//
//  Created by teason on 16/4/26.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "PropCollectionCell.h"

@implementation PropCollectionCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 5. ;
}

+ (PropCollectionCell *)configureWithChineseNameList:(NSArray *)nicknameChineseNameList
                                      nameProperties:(NSDictionary *)nicknameProperties
                                          collection:(UICollectionView *)collectionView
                                           indexPath:(NSIndexPath *)indexPath
{
    PropCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPropCollectionCell forIndexPath:indexPath] ;
    cell.backgroundColor = indexPath.section % 2 ? [UIColor xt_halfMainBlueColor] : [UIColor xt_halfMainColor] ;
    
    cell.lbKey.text = nicknameChineseNameList[indexPath.section] ;
    cell.lbVal.text = [NSString stringWithFormat:@"%@",nicknameProperties[nicknameChineseNameList[indexPath.section]]] ;
    cell.lbKey.textColor = [UIColor whiteColor] ;
    cell.lbVal.textColor = [UIColor darkGrayColor] ;
    
    return cell ;
}

@end
