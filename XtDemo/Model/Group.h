//
//  Group.h
//  XtDemo
//
//  Created by teason on 16/3/21.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject

@property (nonatomic,copy)      NSString        *groupname ;
@property (nonatomic)           NSInteger       groupid ;
@property (nonatomic)           NSInteger       count ;
@property (nonatomic,strong)    NSArray         *nicknames ; // a list of public name .

@end
