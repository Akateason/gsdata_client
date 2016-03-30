//
//  SortPNCell.m
//  XtDemo
//
//  Created by teason on 16/3/28.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "SortPNCell.h"
#import "Nickname.h"
#import "SortPNCell+UpNumberDisplay.h"

@interface SortPNCell ()

@property (weak, nonatomic) IBOutlet UILabel *lb_number;
@property (weak, nonatomic) IBOutlet UILabel *lb_publicName;
@property (weak, nonatomic) IBOutlet UILabel *lb_publicEng;
@property (weak, nonatomic) IBOutlet UILabel *lb_readAll;
@property (weak, nonatomic) IBOutlet UILabel *lb_readMax;
@property (weak, nonatomic) IBOutlet UILabel *lb_readAvg;
@property (weak, nonatomic) IBOutlet UILabel *lb_publish;
@property (weak, nonatomic) IBOutlet UILabel *lb_likeAll;
@property (weak, nonatomic) IBOutlet UILabel *lb_wci;

@property (weak, nonatomic) IBOutlet UILabel *lb_t_readnumAll;
@property (weak, nonatomic) IBOutlet UILabel *lb_t_readAvg;
@property (weak, nonatomic) IBOutlet UILabel *lb_t_likeAll;

@end

@implementation SortPNCell

- (void)setQueueNumber:(NSInteger)queueNumber
{
    _queueNumber = queueNumber ;
    
    _lb_number.text = (queueNumber < 0) ? [NSString stringWithFormat:@"0%ld",(long)queueNumber] : [NSString stringWithFormat:@"%ld",(long)queueNumber] ;
    
    if (queueNumber != 1) {
        self.backgroundColor = (queueNumber % 2) ? [UIColor xt_halfMainBlueColor] : [UIColor xt_halfMainColor] ;
    } else {
        self.backgroundColor = [UIColor xt_lightRedColor] ;
    }
    
    _lb_number.backgroundColor = (queueNumber != 1) ? [UIColor colorWithWhite:.8 alpha:.7] : [UIColor xt_redColor] ;
}

- (void)setNick:(Nickname *)nick
{
    _nick = nick ;
    
    _lb_publicName.text = nick.wx_nickname ;
    _lb_publicEng.text = nick.wx_name ;
    _lb_readAll.text = [NSString stringWithFormat:@"%@\t%@",@(nick.readnum_all),
                        [self getDisplayStringWithUpNumber:nick.readnum_all_up]] ;
    _lb_readMax.text = [NSString stringWithFormat:@"%@",@(nick.readnum_max)] ;
    _lb_readAvg.text = [NSString stringWithFormat:@"%@\t%@",@(nick.readnum_av),
                        [self getDisplayStringWithUpNumber:nick.readnum_av_up]] ;
    _lb_publish.text = [NSString stringWithFormat:@"%@/%@",@(nick.url_times),@(nick.url_num)] ;
    _lb_likeAll.text = [NSString stringWithFormat:@"%@\t%@",@(nick.likenum_all),
                        [self getDisplayStringWithUpNumber:nick.likenum_all_up]];
    _lb_wci.text = [NSString stringWithFormat:@"%.2f",(nick.wci)] ;
    
    _lb_t_readnumAll.textColor = [self getColorWithUpNumber:nick.readnum_all_up] ;
    _lb_t_readAvg.textColor = [self getColorWithUpNumber:nick.readnum_av_up] ;
    _lb_t_likeAll.textColor = [self getColorWithUpNumber:nick.likenum_all_up] ;
    
}

- (void)awakeFromNib
{
    // Initialization code
    _lb_number.layer.cornerRadius = _lb_number.frame.size.width / 2. ;
    _lb_number.layer.masksToBounds = YES ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
