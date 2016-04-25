//
//  PlistUtils.m
//  XtDemo
//
//  Created by teason on 16/4/25.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "PlistUtils.h"
#import "Nickname.h"
#import "NSObject+Reflection.h"

@interface PlistUtils ()

@property (nonatomic,strong) NSDictionary   *propDic ;
@property (nonatomic,strong) NSArray        *seqList ;

@end

@implementation PlistUtils

#pragma mark - init
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self propDic] ;
        [self seqList] ;
    }
    return self;
}

#pragma mark - util

/**
 * fetch properties dictionary . str -> str .
 */
+ (NSDictionary *)getPropertiesDictionary
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"NicknameTransfer" ofType:@"plist"] ;
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath] ;
    return data ;
}

+ (NSArray *)getSequenceList
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"NicknameSequence" ofType:@"plist"] ;
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath] ;
    return data ;
}

/**
 * Nickname reflections
 */
- (NSArray *)properiesNameInNickname:(Nickname *)nick
{
    return [nick propertyKeys] ;
}

/**
 * get chinese name
 */
- (NSString *)getChineseNameWithNicknamePropertyName:(NSString *)name
{
    return self.propDic[name] ;
}

#pragma mark -
- (NSDictionary *)propDic
{
    if (!_propDic) {
        _propDic = [[self class] getPropertiesDictionary] ;
    }
    return _propDic ;
}

- (NSArray *)seqList
{
    if (!_seqList) {
        _seqList = [[self class] getSequenceList] ;
    }
    return _seqList ;
}

- (NSDictionary *)getResultWithNickName:(Nickname *)nickName
{
    NSMutableDictionary *tempDic = [@{} mutableCopy] ;
    for (NSString *nameEng in self.propDic.allKeys)
    {
        NSString *nameChinese = self.propDic[nameEng] ;
        id value = [nickName valueForKey:nameEng] ;
        if (value) [tempDic setObject:value forKey:nameChinese] ;
    }
    return tempDic ;
}

- (NSArray *)getChineseResultSequence
{
    return self.seqList ;
}

@end
