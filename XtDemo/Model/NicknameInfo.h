//
//  NicknameInfo.h
//  XtDemo
//
//  Created by teason on 16/3/30.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NicknameInfo : NSObject

@property (nonatomic)       NSInteger nickNameID ;
@property (nonatomic,copy)  NSString  *wx_nickname ; //"微信公众号名称",
@property (nonatomic,copy)  NSString  *wx_openid ; //"待定",
@property (nonatomic,copy)  NSString  *wx_biz ; //"微信官方biz",
@property (nonatomic,copy)  NSString  *wx_name ; //"公众账号（如 cctv）",
@property (nonatomic,copy)  NSString  *wx_qrcode ; //"公众号二维码地址",
@property (nonatomic,copy)  NSString  *wx_note ; //"公众号描述",
@property (nonatomic,copy)  NSString  *wx_vip_note ; // 认证信息",
@property (nonatomic,copy)  NSString  *wx_country ; // 公众号所属国家",
@property (nonatomic,copy)  NSString  *wx_province ; // "公众号所属省份",
@property (nonatomic,copy)  NSString  *wx_city ; // 公众号所属城市",
@property (nonatomic,copy)  NSString  *wx_title ; //"最新文章标题",
@property (nonatomic,copy)  NSString  *wx_url ; //"最新文章地址",
@property (nonatomic,copy)  NSString  *wx_url_posttime ; //最新文章发布时间",
@property (nonatomic)       NSInteger uid ;
@property (nonatomic,copy)  NSString  *time_start ; //开始采集时间",
@property (nonatomic,copy)  NSString  *time_end ; //结束采集时间",
@property (nonatomic,copy)  NSString  *time_stop ; //结束时间",
@property (nonatomic,copy)  NSString  *add_time ; //添加时间",
@property (nonatomic)       NSInteger status ; //状态
@property (nonatomic)       NSInteger isenable ; //是否可用
@property (nonatomic,copy)  NSString  *category_id ; //类目ID",
@property (nonatomic,copy)  NSString  *category_name ; //类目名称",
@property (nonatomic,copy)  NSString  *category_sub_name ; //子类目名称",
@property (nonatomic,copy)  NSString  *link_name ; //联系人名称",
@property (nonatomic,copy)  NSString  *link_unit ; //"联系人单位",
@property (nonatomic,copy)  NSString  *link_position ; //"联系人职位",
@property (nonatomic,copy)  NSString  *link_tel ; //"联系人电话",
@property (nonatomic,copy)  NSString  *link_wx ; //联系人职位微信",
@property (nonatomic,copy)  NSString  *link_qq ; //"联系人qq",
@property (nonatomic,copy)  NSString  *link_email ; //"联系人职位email",
@property (nonatomic,copy)  NSString  *update_time ; //更新时间",
@property (nonatomic,copy)  NSString  *update_status ; //"更新状态"

@end
