//
//  YUtils.h
//  YangFrame
//
//  Created by Yang Shichang on 13-10-26.
//  Copyright (c) 2013年 Yang152412. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YUtils : NSObject

+ (NSString*)localizedStringWithKey:(NSString*)key;

+ (NSArray*)localizedArrayWithKey:(NSString*)key;


/* fileName 示例 test/hello/test.txt */
+ (void)writeFile:(NSString*)fileName data:(NSData*)data append:(BOOL)append;

+ (NSData*)readFile:(NSString*)fileName;

+ (void)removeFile:(NSString*)fileName;

#pragma mark - //  沙盒目录
- (NSString *)dataFilePath:(NSString *)fileName;
// 写全局配置文件
- (BOOL)saveConfigsWithObject:(id)object key:(NSString *)key;
- (NSDictionary *)readConfigsFromDocuments;
#pragma mark - // 存储/读取/删除 用户名和密码
- (void)saveUserLoginInfoWithUserName:(NSString *)userName password:(NSString *)password autoLogin:(BOOL)autoLogin;
- (NSDictionary *)readUserLoginInfo;
- (NSString *) getPasswordForUsername: (NSString *) username
								error: (NSError **) error;
 // 删除用户名，密码
- (void)deletePasswordForUserName:(NSString *)userName;

#pragma mark -
#pragma mark 从String创建URL
+ (NSURL*)urlWithString:(NSString *)value;

//获取UIImage， 如果图片找不到或者尺寸为0 返回nil
+ (UIImage*)getImage:(NSString*) imageName;

#pragma mark -
#pragma mark  runtime

+ (NSArray*)propertyFromClass:(Class)cls;

+ (NSArray*)propertyArray:(Class)cls;

+ (NSDictionary*)dictionaryFromObject:(id)object;

+ (id)objectFromDictionary:(NSDictionary*)dict ofClass:(Class)cls;

#pragma mark -
#pragma mark  device token

+ (void)saveDeviceToken:(NSString*)token;

// return  device token
+ (NSString*)deviceToken;

// return if need to update token (nil of off remote notification)
+ (BOOL)isNeedUpdateDeviceToken:(NSString*)token;

// return if open remote notification
+ (BOOL)isAllowRemoteNotification;
#pragma mark - format string
+ (NSString *)parseObjectToJsonString:(id)object;
+ (NSString *)convertMoneyFormat:(NSString *)moneyString;
+ (NSString *)formatCardNumber:(NSString *)cardNumber;



#pragma mark - 清除本地登录状态
+ (void)clearLoginStatus;

//获得上拉加载更多的自定义view
+ (UIView *)getTableViewLoadMoreView;

#pragma mark 根据folder拼网络图片URL

+ (NSURL*)urlWithFolder:(NSString*)folder withURL:(NSString*)org;
@end
