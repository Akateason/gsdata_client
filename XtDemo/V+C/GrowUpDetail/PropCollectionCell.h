//
//  PropCollectionCell.h
//  XtDemo
//
//  Created by teason on 16/4/26.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *kPropCollectionCell = @"PropCollectionCell" ;

@interface PropCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbKey ;
@property (weak, nonatomic) IBOutlet UILabel *lbVal ;

+ (PropCollectionCell *)configureWithChineseNameList:(NSArray *)nicknameChineseNameList
                                      nameProperties:(NSDictionary *)nicknameProperties
                                          collection:(UICollectionView *)collectionView
                                           indexPath:(NSIndexPath *)indexPath ;
@end
