//
//  GroupCell.m
//  XtDemo
//
//  Created by teason on 16/3/22.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "GroupCell.h"
#import "Group.h"

@interface GroupCell ()

@property (weak, nonatomic) IBOutlet UILabel *lbContent;
@property (weak, nonatomic) IBOutlet UILabel *lbDetail;
@property (weak, nonatomic) IBOutlet UIButton *bt_see;
@property (weak, nonatomic) IBOutlet UIButton *bt_sort;

@end

@implementation GroupCell

+ (GroupCell *)configureCellWithGroup:(Group *)group
                      delegateHandler:(id)handler
                                table:(UITableView *)table
{
    GroupCell * cell = [table dequeueReusableCellWithIdentifier:kGroupCell] ;
    if (!cell) {
        cell = [table dequeueReusableCellWithIdentifier:kGroupCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    cell.group = group ;
    cell.delegate = handler ;
    return cell ;
}

- (void)setGroup:(Group *)group
{
    _group = group ;
    
    _lbContent.text = [NSString stringWithFormat:@"%@",group.groupname] ;
    _lbDetail.text = [NSString stringWithFormat:@"分组下有%ld个公众号",(long)group.count] ;
}

- (void)awakeFromNib {
    // Initialization code
    _lbContent.textColor = [UIColor xt_mainColor] ; //[UIColor xt_mainBlueColor] ;
    
    _bt_see.layer.cornerRadius = _bt_see.frame.size.width / 2. ;
    _bt_see.backgroundColor = [UIColor xt_lightBlueColor] ;
    
    _bt_sort.layer.cornerRadius = _bt_sort.frame.size.width / 2. ;
    _bt_sort.backgroundColor = [UIColor xt_lightGreenColor] ;
}

- (IBAction)btSeeClicked:(id)sender {
    [_delegate toSeeMore:self.group] ;
}

- (IBAction)btSortClicked:(id)sender {
    [_delegate toSorting:self.group] ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
