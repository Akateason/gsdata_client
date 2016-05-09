//
//  User.h
//  XtDemo
//
//  Created by teason on 16/5/6.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef NS_ENUM(NSInteger, KindOfJob) {
//    admin = -1 ,
//    subaojiang = 1 ,
//    xiaoxuzi ,
//} ;

@interface User : NSObject

@property (nonatomic)       NSInteger   userID ;
@property (nonatomic,copy)  NSString    *userName ;
@property (nonatomic,copy)  NSString    *password ;
@property (nonatomic)       NSInteger   kind ;      //  KindOfJob

@end
