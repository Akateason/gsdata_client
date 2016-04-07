//
//  Nickname.h
//  XtDemo
//
//  Created by teason on 16/3/22.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Nickname : NSObject

@property (nonatomic)           NSInteger   group_id ;
@property (nonatomic)           NSInteger   nickname_id ;       // 公众号账号
@property (nonatomic,copy)      NSString    *wx_name ;          // 公众号英文
@property (nonatomic,copy)      NSString    *wx_nickname ;      // 公众号

@property (nonatomic,copy)      NSString    *wx_title ;         // 最新文章标题
@property (nonatomic,copy)      NSString    *wx_url ;           // 最新文章地址
@property (nonatomic,copy)      NSString    *wx_url_posttime ;  // 最新文章发布时间

@property (nonatomic)           NSInteger   url_num ;           // 文章数
@property (nonatomic)           NSInteger   url_num_10w ;       // 文章达10w+的数量(负数为下降)
@property (nonatomic)           NSInteger   url_num_10w_up ;    // 文章达10w+的数量的增量(负数为下降)
@property (nonatomic)           NSInteger   readnum_all ;       // 总阅读
@property (nonatomic)           NSInteger   readnum_all_up ;    // 总阅读的增量(+-)
@property (nonatomic)           NSInteger   readnum_av ;        // 平均阅读
@property (nonatomic)           NSInteger   readnum_av_up ;     // 平均阅读的增量(负数为下降)
@property (nonatomic)           NSInteger   likenum_all ;       // 总点赞
@property (nonatomic)           NSInteger   likenum_all_up ;    // 总点赞的增量(负数为下降)
@property (nonatomic)           NSInteger   likenum_av ;        // 平均点赞
@property (nonatomic)           NSInteger   likenum_av_up ;     // 平均点赞的增量 (负数为下降)
@property (nonatomic)           NSInteger   readnum_max ;       // 最大阅读数
@property (nonatomic)           NSInteger   likenum_max	;       // 最大点赞数
@property (nonatomic)           double      likenum_readnum_rate ; // 阅读数与点赞数的比率
@property (nonatomic)           double      wci ;                  // 微信传播指数
@property (nonatomic)           double      wci_up ;               // 微信传播指数 增量
@property (nonatomic)           NSInteger   rowno ;             // 排名
@property (nonatomic)           NSInteger   rowno_up ;          // 排名上升增量
@property (nonatomic,copy)      NSString    *result_day ;       // 排名日期
@property (nonatomic)           NSInteger   url_times ;         // 该公众号在上述日期中发文次数
@property (nonatomic)           NSInteger   url_times_up ;      // 发文次数相对上次的增量（负数即为下降）
@property (nonatomic)           NSInteger   url_times_readnum ; // 该公众号在上述日期中发文的总阅读数
@property (nonatomic)           NSInteger   url_times_readnum_up ; // 发文的总阅读数相对上次的增量（负数即为下降）
@property (nonatomic)           NSInteger   url_num_up ;        // 文章总数相对上次的增量（负数即为下降）
@property (nonatomic)           double      wcir ;
@property (nonatomic)           double      wciz ;

@end

