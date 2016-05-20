//
//  LoginHandler.h
//  XtDemo
//
//  Created by teason on 16/5/6.
//  Copyright © 2016年 teason. All rights reserved.
//

typedef NS_ENUM(NSInteger, KindOfJob) {
    admin = -1 ,
    subaojiang = 1 ,
    xiaoxuzi ,
} ;

#import <Foundation/Foundation.h>

@class User ;

@interface LoginHandler : NSObject

/**
 *  userdefault . cache logined user info .
 */
+ (void)loginCachedInUserDefaults:(User *)user ;

/**
 *  get current user .
 */
+ (User *)getCurrentUserInCache ;

/**
 * log out .
 */
+ (void)logout ;

/**
 *  has login or not
 */
+ (BOOL)userHasLogin ;

/**
 *  Get CurrentUsers KindOfJob
 *   admin = -1 ,
 *   subaojiang = 1 ,
 *   xiaoxuzi ,
 */
+ (KindOfJob)getCurrentUsersKindOfJob ;

/*
 *  KindOfJob nickname
 @return 日本流行每日速报
 */
+ (NSString *)getNicknameString ;

/*
 *  KindOfJob wx Name
 @return zhepen
 */
+ (NSString *)getWXnameString ;


@end
