//
//  PlistUtils.h
//  XtDemo
//
//  Created by teason on 16/4/25.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Nickname ;

@interface PlistUtils : NSObject

- (NSDictionary *)getResultWithNickName:(Nickname *)nickName ;
- (NSArray *)getChineseResultSequence ;

@end
