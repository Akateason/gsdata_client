//
//  LoginHandler.m
//  XtDemo
//
//  Created by teason on 16/5/6.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "LoginHandler.h"
#import "User.h"
#import "NotificationCenterHeader.h"

@implementation LoginHandler

static NSString *kKeyUserName = @"userName" ;
static NSString *kKeyPassword = @"password" ;
static NSString *kKind        = @"kind" ;

/**
 *  userdefault . cache logined user info .
 */
+ (void)loginCachedInUserDefaults:(User *)user
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults] ;
    [defaults setObject:user.userName forKey:kKeyUserName] ;
    [defaults setObject:user.password forKey:kKeyPassword] ;
    [defaults setObject:@(user.kind)  forKey:kKind] ;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGINOUT
                                                        object:nil] ;
}

/**
 *  get current user .
 */
+ (User *)getCurrentUserInCache
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults] ;
    User *currentUser = [[User alloc] init] ;
    currentUser.userName = [defaults objectForKey:kKeyUserName] ;
    currentUser.password = [defaults objectForKey:kKeyPassword] ;
    currentUser.kind = [[defaults objectForKey:kKind] integerValue] ;
    
    return currentUser ;
}

/**
 * log out .
 */
+ (void)logout
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults] ;
    [defaults removeObjectForKey:kKeyUserName] ;
    [defaults removeObjectForKey:kKeyPassword] ;
    [defaults removeObjectForKey:kKind] ;
}

/**
 * has login or not
 */
+ (BOOL)userHasLogin
{
    User *user = [self getCurrentUserInCache] ;
    return (user.userName.length > 0) ;
}

/**
 *  get CurrentUsers KindOfJob
 admin = -1 ,
 subaojiang = 1 ,
 xiaoxuzi ,
 */
+ (KindOfJob)getCurrentUsersKindOfJob
{
    if (![self userHasLogin]) return 0 ;
    
    User *user = [self getCurrentUserInCache] ;
    return user.kind ;
}

/*
 *  KindOfJob nickname
 */
+ (NSString *)getNicknameString
{
    KindOfJob kind = (![self userHasLogin]) ? subaojiang : ((User *)[self getCurrentUserInCache]).kind ;
    switch (kind)
    {
        case subaojiang :
        case admin :
        {
            return @"日本流行每日速报" ;
        }
            break;
        case xiaoxuzi :
        {
            return @"小旭子" ;
        }
            break;
        default:
            break;
    }
}

/*
 *  KindOfJob wx Name
 */
+ (NSString *)getWXnameString
{
    KindOfJob kind = (![self userHasLogin]) ? subaojiang : ((User *)[self getCurrentUserInCache]).kind ;
    switch (kind)
    {
        case subaojiang :
        case admin :
        {
            return @"zhepen" ;
        }
            break;
        case xiaoxuzi :
        {
            return @"xiaoxuzi_fashion" ;
        }
            break;
        default:
            break;
    }

}

@end
