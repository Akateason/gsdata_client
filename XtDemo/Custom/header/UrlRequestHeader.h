//
//  UrlRequestHeader.h
//  SuBaoJiang
//
//  Created by apple on 15/6/4.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#ifndef SuBaoJiang_UrlRequestHeader_h
#define SuBaoJiang_UrlRequestHeader_h

/**
 *服务器 地址
 */
static NSString *const kRootUrlString           = @"http://wei.subaojiang.com:8080/gsdata/api" ;
//static NSString *const kRootUrlString           = @"http://localhost:8080/gsdata/api" ;
//static NSString *const kRootUrlString           = @"http://teason.pagekite.me/gsdata/api" ;

#pragma mark --
#pragma mark - 登录注册
static NSString *const URL_USER_REGISTER        = @"http://wei.subaojiang.com:8080/GsdataApp/user/register" ;
static NSString *const URL_USER_LOGIN           = @"http://wei.subaojiang.com:8080/GsdataApp/user/login" ;
//static NSString *const URL_USER_REGISTER        = @"http://localhost:8080/GsdataApp/user/register" ;
//static NSString *const URL_USER_LOGIN           = @"http://localhost:8080/GsdataApp/user/login" ;

#pragma mark --
#pragma mark - 系统api
//获取用户信息
static NSString *const URL_FETCH_USER_INFO      = @"sys/sysapi/user_info" ;
//用户登录验证
static NSString *const URL_LOGIN_USER           = @"sys/sysapi/login_user" ;
//用户名验证
static NSString *const URL_CHECK_USER           = @"sys/sysapi/check_user" ;

#pragma mark --
#pragma mark - 微信api
//通过本系统nickname_id或微信文章url地址获取距发布时间七日时间阅读点赞数
static NSString *const URL_WX_READNUM           = @"wx/wxapi/wx_week_readnum";
//获取用户下所有微信分组信息
static NSString *const URL_WX_GROUP_NAME        = @"wx/wxapi/group_name" ;
//获取一个公众号的信息
static NSString *const URL_WX_NICKNAME_ONE      = @"wx/wxapi/nickname_one" ;
//通过markid、day返回分页统计标签排行
static NSString *const URL_WX_NICKNAME_RESULT   = @"wx/wxapi/nickname_result" ;
//通过nicknameid返回在不同标签下的排行名次
static NSString *const URL_WX_NICKNAME_MARK     = @"wx/wxapi/nickname_mark" ;
//返回所有标签
static NSString *const URL_WX_ALL_MARK          = @"wx/wxapi/all_mark" ;
//返回当月所有统计表（日，周）
static NSString *const URL_WX_RESULT_TABLES     = @"wx/wxapi/result_tables" ;
//通过UID返回用户分组及各分组内的公众号(含最新发布的一条文章)列表
static NSString *const URL_WX_NICKNAME          = @"wx/wxapi/nickname" ;
//通过groupid、day返回文章分页集合
static NSString *const URL_WX_GROUP_DATA        = @"wx/wxapi/group_data" ;
//通过groupid、day返回分页统计排行内样本总数量(公众号总数、发文总数、总阅读)
static NSString *const URL_WX_RESULT_APPEND     = @"wx/wxapi/result_append" ;
//通过groupid、day返回分页统计DAY排行
static NSString *const URL_WX_RESULT_DAY        = @"wx/wxapi/result_day" ;
//通过groupid、day返回分页统计WEEK排行
static NSString *const URL_WX_RESULT_WEEK       = @"wx/wxapi/result_week" ;
//添加微信公众账号到分组
static NSString *const URL_WX_TO_GROUP          = @"wx/wxapi/add_wx_to_group" ;
//实时获取公众号文章正文
static NSString *const URL_WX_CONTENT           = @"wx/wxapi/wx_content" ;
//微信热门视频数据
static NSString *const URL_WX_VIDEO_DATA        = @"wx/wxapi/wx_video_data" ;
//获取单个公众号最新排名情况
static NSString *const URL_OPEN_NOW             = @"wx/opensearchapi/nickname_order_now" ;
//获取n天公众号的排名情况（默认3天）
static NSString *const URL_OPEN_ORDER_LIST      = @"wx/opensearchapi/nickname_order_list" ;
//通过分组编号（groupid）和appid的用户编号获取用户的分组和分组下公众号
static NSString *const URL_OPEN_GROUP           = @"wx/opensearchapi/nickname_group" ;
//使用关键字搜索公账号信息
static NSString *const URL_OPEN_ACCOUNT_INFO    = @"wx/opensearchapi/nickname_keyword_search" ;
//使用关键字搜索公众号文章
static NSString *const URL_OPEN_ACCOUT_CONTENT  = @"wx/opensearchapi/content_keyword_search" ;
//根据条件搜索公众号某段时间内的文章信息
static NSString *const URL_OPEN_C_LIST_INTIME   = @"wx/opensearchapi/content_list" ;
//获取某个公众号时间范围内的文章总数、阅读总数、点赞总数
static NSString *const URL_OPEN_TOTAL_INTIME    = @"wx/opensearchapi/nickname_order_total" ;
//根据文章地址获取该文章的评论信息
static NSString *const URL_WX_ARTICLE_COMMENTS  = @"wx/wxapi2/wx_comment_by_url" ;
//添加微信分组到用户账户下
static NSString *const URL_WX_ADDWXGROUP        = @"wx/wxapi/addWxGroup" ;

#endif


