//
//  Article.h
//  XtDemo
//
//  Created by teason on 16/3/23.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

@property (nonatomic)       NSInteger   nickname_id ;
@property (nonatomic,copy)  NSString    *wx_nickname ;
@property (nonatomic,copy)  NSString    *wx_name ;
@property (nonatomic,copy)  NSString    *title ;
@property (nonatomic,copy)  NSString    *content ;
@property (nonatomic,copy)  NSString    *url ;
@property (nonatomic,copy)  NSString    *posttime ;
@property (nonatomic,copy)  NSString    *get_time ;
@property (nonatomic)       NSInteger   readnum ;
@property (nonatomic)       NSInteger   likenum ;
@property (nonatomic,copy)  NSString    *get_time_pm ;
@property (nonatomic)       NSInteger   readnum_pm ; //距发文时间次日午时阅读数
@property (nonatomic)       NSInteger   likenum_pm ; //距发文时间次日午时点赞数
@property (nonatomic)       NSInteger   readnum_week ;
@property (nonatomic)       NSInteger   likenum_week ;
@property (nonatomic)       NSInteger   top ;
@property (nonatomic)       NSInteger   status ;
@property (nonatomic,copy)  NSString    *picurl ;
@property (nonatomic,copy)  NSString    *sourceurl ;
@property (nonatomic,copy)  NSString    *author ;
@property (nonatomic,copy)  NSString    *copyright ;

// info
@property (nonatomic)       NSInteger   read_num_1 ;
@property (nonatomic)       NSInteger   like_num_1 ;
@property (nonatomic)       NSInteger   read_num_2 ;
@property (nonatomic)       NSInteger   like_num_2 ;
@property (nonatomic)       NSInteger   read_num_3 ;
@property (nonatomic)       NSInteger   like_num_3 ;
@property (nonatomic)       NSInteger   read_num_4 ;
@property (nonatomic)       NSInteger   like_num_4 ;
@property (nonatomic)       NSInteger   read_num_5 ;
@property (nonatomic)       NSInteger   like_num_5 ;
@property (nonatomic)       NSInteger   read_num_6 ;
@property (nonatomic)       NSInteger   like_num_6 ;
@property (nonatomic)       NSInteger   read_num_7 ;
@property (nonatomic)       NSInteger   like_num_7 ;

@end
