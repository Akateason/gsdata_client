//
//  ServerRequest.h
//  JGB
//
//  Created by JGBMACMINI01 on 14-8-12.
//  Copyright (c) 2014年 JGBMACMINI01. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "XTRequest.h"
#import "ResultParsered.h"

@interface ServerRequest : XTRequest

#pragma mark --
#pragma mark - 登录注册

/*
 PARAM:
 name        STR	: 用户名(真实姓名)
 password    STR	: 密码
 kind        INT : 工作类型 (-1->管理员,  1->速报酱员工,  2->小旭子员工)
 */
+ (void)registerName:(NSString *)name
            password:(NSString *)pass
                kind:(NSInteger)kind
             success:(void (^)(id json))success
                fail:(void (^)())fail ;

/*
 PARAM:
 name       STR : 用户名(真实姓名)
 password   STR : 密码
 */
+ (void)loginName:(NSString *)name
         password:(NSString *)pass
          success:(void (^)(id json))success
             fail:(void (^)())fail ;

#pragma mark --
#pragma mark - 系统API（接口列表）
/**
 *  获取用户信息
 *
 *  @param jsonStr
 *  @param success
 *  @param fail
 */
+ (void)fetchUserInfoWithJsonString:(NSString *)jsonStr
                            success:(void (^)(id json))success
                               fail:(void (^)())fail ;

#pragma mark --
#pragma mark - 微信API（接口列表）

/**
 *  获取一个公众号详情
 *
 *  @param nickNameID nickNameID description
 *  @param success    success description
 *  @param fail       fail description
 */
+ (void)fetchNickNameInfo:(NSInteger)nickNameID
                  success:(void(^)(id json))success
                     fail:(void(^)())fail ;

/**
 *  通过本系统nickname_id或微信文章url地址获取距发布时间七日时间阅读点赞数
 *  @param startTime  startTime description
 *  @param endTime    endTime description
 *  @param nickNameID nickNameID description
 *  @param success    success description
 *  @param fail       fail description
 */
+ (void)fetchWxWeekReadNumWithStartTime:(NSString *)startTime
                                endTime:(NSString *)endTime
                             nickNameID:(NSInteger)nickNameID
                                success:(void (^)(id json))success
                                   fail:(void (^)())fail ;

/**
 *  获取用户下所有微信分组信息
 *
 *  @param success
 *  @param fail
 */
+ (void)fetchMyGroupsListSuccess:(void (^)(id json))success
                            fail:(void (^)())fail ;

/**
 *  通过分组编号（groupid）和appid的用户编号获取用户的分组和分组下公众号
 *
 *  @param groupID groupID description
 *  @param success success description
 *  @param fail    fail description
 */
+ (void)fetchPublicNameListFromGroupID:(NSInteger)groupID
                               success:(void (^)(id json))success
                                  fail:(void (^)())fail ;

/**
 *  通过UID返回用户分组及各分组内的公众号(含最新发布的一条文章)列表
 *
 *  @param success
 *  @param fail
 */
+ (void)fetchAllNickNameSuccess:(void (^)(id json))success
                           fail:(void (^)())fail ;


/**
 *  sort In Group
 *  通过groupid、day返回文章分页集合
 *  @param dayStr   日期(yyyy-MM-dd)
 *  @param groupID
 *  @param sortName 排序字段(posttime,readnum)
 *  @param sortWay  排序方式(asc,desc)
 *  @param page     页码
 *  @param rows     每页记录数(最大10条记录)
 *  @param success
 *  @param fail
 */
+ (void)sortInGroupWithDayString:(NSString *)dayStr
                         groupID:(NSInteger)groupID
                        sortName:(NSString *)sortName
                            sort:(NSString *)sortWay
                            page:(NSInteger)page
                            rows:(NSInteger)rows
                         success:(void (^)(id json))success
                            fail:(void (^)())fail ;


/**
 *  通过groupid、day返回分页统计排行
 *
 *  @param dayStr  dayStr description
 *  @param groupID groupID description
 *  @param sort    sort description
 *  @param order   order description
 *  @param page    page description
 *  @param rows    rows description
 *  @param success success description
 *  @param fail    fail description
 */
+ (void)sortInDayWithDayString:(NSString *)dayStr
                       groupID:(NSInteger)groupID
                          sort:(NSString *)sort
                        orrder:(NSString *)order
                          page:(NSInteger)page
                          rows:(NSInteger)rows
                       success:(void (^)(id json))success
                          fail:(void (^)())fail ;

/**
 *  通过groupid、day返回分页统计排行WEEK排行
 *
 *  @param dayStr  dayStr description
 *  @param groupID groupID description
 *  @param sort    sort description
 *  @param order   order description
 *  @param page    page description
 *  @param rows    rows description
 *  @param success success description
 *  @param fail    fail description
 */
+ (void)sortInWeekWithDayString:(NSString *)dayStr
                        groupID:(NSInteger)groupID
                           sort:(NSString *)sort
                         orrder:(NSString *)order
                           page:(NSInteger)page
                           rows:(NSInteger)rows
                        success:(void (^)(id json))success
                           fail:(void (^)())fail ;

/**
 *  search Nickname With Keyword
 *  根据关键词搜索公众号
 *  @param keyword keyword description
 *  @param success
 *  @param fail
 */
+ (void)searchNicknameWithKeyword:(NSString *)keyword
                            start:(NSInteger)start
                          success:(void (^)(id json))success
                             fail:(void (^)())fail ;

/**
 *  search Articles With Keyword
 *  根据关键词搜索公众号文章
 *  @param keyword keyword description
 *  @param success success description
 *  @param fail    fail description
 */
+ (void)searchArticlesWithKeyword:(NSString *)keyword
                            start:(NSInteger)start
                          success:(void (^)(id json))success
                             fail:(void (^)())fail ;

/**
 *  wx/opensearchapi/nickname_order_total
 *  获取某个公众号时间范围内的文章总数、阅读总数、点赞总数
 *
 *  @param nickNameString nickNameString description
 *  @param num            days 默认3, 可传7,最大31.
 *  @param success        success description
 *  @param fail           fail description
 */
+ (void)fetchNickNameOrderList3Days:(NSString *)nickNameString
                                num:(NSInteger)days
                            success:(void (^)(id json))success
                               fail:(void (^)())fail ;

+ (ResultParsered *)syncFetchNickNameOrderList3Days:(NSString *)nickNameString
                                                num:(NSInteger)days ;

+ (ResultParsered *)syncFetchNickNameOrderList3DaysWX:(NSString *)wxName
                                                  num:(NSInteger)days ;


/*
 *  根据条件列出公众号某日文章
 *  wx_name	true	string	搜公众号官方英文ID,例：cctvnewscenter
 *  start	true	int	搜索结果开始页（默认为0）
 *  num	true	int	返回数据最大记录数（默认为10，最大不超过10）
 *  postdate	false	string	发布时间(格式：yyyy-MM-dd)
 *  datestart	false	string	开始时间(格式：yyyy-MM-dd)
 *  dateend	false	string	结束时间(格式：yyyy-MM-dd)
 *  sortname	true	string	排序条件-字段排序条件-字段[readnum|likenum|readnum_pm|likenum_pm|readnum_week|likenum_week|posttime]
 *  sort	true	string	[asc|desc] 排序方式
 *  nickname_id	true	string	平台内公众号ID
 *  is_top	false	boolean	是否是头条文章
 */
+ (void)fetchContentListWithWxName:(NSString *)wx_name
                             start:(int)start
                         dateStart:(NSString *)dateStart
                           dateEnd:(NSString *)dateEnd
                          sortName:(NSString *)sortName
                              sort:(NSString *)sort
                             isTop:(BOOL)isTop
                            QuanBu:(BOOL)bQuanbu
                           success:(void (^)(id json))success
                              fail:(void (^)())fail ;
@end





