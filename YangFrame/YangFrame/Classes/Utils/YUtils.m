//
//  YUtils.m
//  YangFrame
//
//  Created by Yang Shichang on 13-10-26.
//  Copyright (c) 2013年 Yang152412. All rights reserved.
//

#import "YUtils.h"
#import <sys/utsname.h>
#import <objc/runtime.h>
#import "SFHFKeychainUtils.h"
#import "NSString+Util.h"

@implementation YUtils

#pragma mark -
#pragma mark 本地化字符串
static id localDict = nil;

+ (NSString*)localizedStringWithKey:(NSString*)key
{
	NSString* result = key;
    
    if (!localDict) {
//        localDict = [[UPXPlistUtils reloadPlistWithType:kPlistTypeLocalization] retain];
    }
    if (localDict){
        result = [localDict objectForKey:key];
    }
	return result;
}

+ (NSArray*)localizedArrayWithKey:(NSString*)key
{
    NSArray* result = nil;
    
    if (!localDict) {
//        localDict = [[UPXPlistUtils reloadPlistWithType:kPlistTypeLocalization] retain];
    }
    if (localDict){
        result = [localDict objectForKey:key];
    }
	return result;
}

#pragma mark -
#pragma mark 写文件
// fileName格式 ****/****/**.ext
+ (void)writeFile:(NSString*)fileName data:(NSData*)data append:(BOOL)append
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths firstObject];
    
    NSMutableString* dirPath = [[NSMutableString alloc] initWithString:docDir];
    NSArray* array = [fileName componentsSeparatedByString:@"/"];
    NSInteger count = [array count];
    for (int i = 0; i < count-1; i++) {
        [dirPath appendFormat:@"/%@",array[i]];
    }
    NSString* filePath = [dirPath stringByAppendingPathComponent:[array objectAtIndex:count-1]];
    
    NSFileManager* fm = [NSFileManager defaultManager];
    if (!Y_FILEEXIST(dirPath)) {
        [fm createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    if (!Y_FILEEXIST(filePath)) {
        [fm createFileAtPath:filePath contents:data attributes:nil];
    }
    
    NSFileHandle *file = [NSFileHandle fileHandleForWritingAtPath:filePath];
    if (append) {
        [file seekToEndOfFile];
    }
    
    [file writeData:data];
    [file closeFile];
}

#pragma mark -
#pragma mark 读文件

+ (NSData*)readFile:(NSString*)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSFileHandle *file = [NSFileHandle fileHandleForReadingAtPath:path];
    NSData *data = [file readDataToEndOfFile];
    [file closeFile];
    return data;
}

#pragma mark -
#pragma mark 删除文件

+ (void)removeFile:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString* path = [documentsDirectory stringByAppendingString:fileName];
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}


#pragma mark - //  沙盒目录
- (NSString *)dataFilePath:(NSString *)fileName{
    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(
														  NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths1 objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

// 写全局配置文件
- (BOOL)saveConfigsWithObject:(id)object key:(NSString *)key {
    NSMutableDictionary *configDic=[NSMutableDictionary dictionaryWithContentsOfFile:[self dataFilePath:kConfigFileName]];
    if (configDic==nil) {
        configDic=[NSMutableDictionary dictionaryWithCapacity:0];
    }
    [configDic setObject:object forKey:key];
    return [configDic writeToFile:[self dataFilePath:kConfigFileName] atomically:YES];
}
- (NSDictionary *)readConfigsFromDocuments {
    NSMutableDictionary *configDic=[NSMutableDictionary dictionaryWithContentsOfFile:[self dataFilePath:kConfigFileName]];
    if (configDic==nil) {
        configDic=[NSMutableDictionary dictionaryWithCapacity:0];
    }
    return configDic;
}

#pragma mark - // 存储用户名和密码
- (void)saveUserLoginInfoWithUserName:(NSString *)userName password:(NSString *)password autoLogin:(BOOL)autoLogin{
    // 存储username  autoLogin到config.plist
    NSDictionary *loginInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                               userName,kKeyUserName,
                               [NSNumber numberWithBool:autoLogin],kKeyIsAutoLogin, nil];
    [self saveConfigsWithObject:loginInfo key:kKeyLoginInfo];
    
    // save to keychain
    [SFHFKeychainUtils storeUsername:userName
                         andPassword:password
                      forServiceName:kKeyLoginKeychainServiceName
                      updateExisting:YES
                               error:nil];
}

#pragma mark - // 读取用户名，密码
- (NSDictionary *)readUserLoginInfo {
    NSDictionary *dic = [self readConfigsFromDocuments];
    NSMutableDictionary *loginInfo = [dic objectForKey:kKeyLoginInfo];
    if (loginInfo) {
        // 用户名存在,读取密码，放入字典，返回
        NSString *userName = [loginInfo objectForKey:kKeyUserName];
        NSString *password = [SFHFKeychainUtils getPasswordForUsername:userName
                                                        andServiceName:kKeyLoginKeychainServiceName error:nil];
        if (password) {
            [loginInfo setObject:password forKey:kKeyPassword];
        }
        
    }
    return loginInfo;
}
- (NSString *) getPasswordForUsername: (NSString *) username
								error: (NSError **) error {
    
    // 先判断，是否已经登陆过
    NSDictionary *userInfo = [self readUserLoginInfo];
    if ([username isEqualToString:[userInfo objectForKey:kKeyUserName]]) {
        // 存储的用户名
        NSString *password = [SFHFKeychainUtils getPasswordForUsername:username
                                                        andServiceName:kKeyLoginKeychainServiceName
                                                                 error:error];
        
        return password;
    }else {
        return nil;
    }
}
#pragma mark - // 删除用户名，密码
- (void)deletePasswordForUserName:(NSString *)userName {
    
    // 删除密码
    [SFHFKeychainUtils deleteItemForUsername:userName
                              andServiceName:kKeyLoginKeychainServiceName
                                       error:nil];
    
    // 将 config.plist 文件中的数据 置空；
    NSDictionary *loginInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"",kKeyUserName,
                               [NSNumber numberWithBool:NO],kKeyIsAutoLogin, nil];
    [self saveConfigsWithObject:loginInfo key:kKeyLoginInfo];
    
}

#pragma mark -
#pragma mark 从String创建URL
+ (NSURL*)urlWithString:(NSString *)value
{
    NSURL* url = nil;
    if (![NSString isEmptyString:value]) {
        url = [NSURL URLWithString:value];
    }
    return url;
}

#pragma mark -
#pragma mark 获取UIImage， 如果图片找不到或者尺寸为0 返回nil
+ (UIImage*)getImage:(NSString*) imageName
{
    UIImage* image = [UIImage imageNamed:imageName];
    if (!image) {
        DDERROR(@"getImage error! Miss image:%@",imageName);
        return nil;
    }
    if ( CGSizeEqualToSize(image.size, CGSizeZero)) {
        DDERROR(@"getImage error! %@  size = zero!",imageName);
        return nil;
    }
    return image;
}


#pragma mark -
#pragma mark  runtime

+ (NSArray*)propertyFromClass:(Class) cls
{
    NSMutableArray* result = [NSMutableArray array];
    unsigned int count;
    objc_property_t *props = class_copyPropertyList(cls, &count);
    for (int i = 0; i < count; ++i){
        const char *propName = property_getName(props[i]);
        [result addObject:[NSString stringWithUTF8String:propName]];
    }
    free(props);
    return result;
}

+ (NSArray*)propertyArray:(Class) cls
{
    NSMutableArray* result = [NSMutableArray array];
    
    Class classOfObject = cls;
    while(![classOfObject isEqual:[NSObject class]])
    {
        [result addObjectsFromArray:[self propertyFromClass:classOfObject]];
        classOfObject = [classOfObject superclass];
    }
    return result;
}

+ (NSDictionary*)dictionaryFromObject:(id)object
{
    NSMutableDictionary* d = [NSMutableDictionary dictionary];
    NSArray* p = [self propertyArray:[object class]];
    for (NSString* k in p) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks" 
        id v = [object performSelector:NSSelectorFromString(k)];
#pragma clang diagnostic pop
        if (v) {
            [d setObject:v forKey:k];
        }
    }
    return d;
}

+ (id)objectFromDictionary:(NSDictionary*) dict ofClass:(Class) cls
{
    id r = [[cls alloc] init];
    NSArray* p = [self propertyArray:cls];
    for (NSString* k in p) {
        id v = [dict valueForKey:k];
        if (v) {
            [r setValue:v forKey:k];
        }
    }
    return r;
}



#pragma mark -
#pragma mark  device token
+ (void)saveDeviceToken:(NSString*)token
{
    [Y_USERDEFAULT setValue:token forKey:kKeyUDDeviceToken];
    [Y_USERDEFAULT synchronize];
}

+ (NSString*)deviceToken
{
    return (NSString*)[Y_USERDEFAULT objectForKey:kKeyUDDeviceToken];
}

+ (BOOL)isNeedUpdateDeviceToken:(NSString*)token
{
    if (!token || [YUtils isAllowRemoteNotification])
        return NO;
    return [token isEqualToString:[YUtils deviceToken]];
}

+ (BOOL)isAllowRemoteNotification
{
    UIRemoteNotificationType t = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    return (t&UIRemoteNotificationTypeBadge)|(t&UIRemoteNotificationTypeSound)|(t&UIRemoteNotificationTypeAlert);
    
}

#pragma mark - 对象转JsonString

/* parse the object to string */
+ (NSString*)parseObjectToJsonString:(id)object
{
    NSString * jsonString = nil;
    if (object && [object isKindOfClass:[NSDictionary class]]) {
        jsonString = [object JSONString];
    }
    return jsonString;
}
/* format bank card number */
+ (NSString*)formatCardNumber:(NSString *)cardNumber
{
    NSInteger length = [cardNumber length];
    if (length < 8) return cardNumber;
    NSRange range = NSMakeRange(0, 4);
    NSString * frontSubString = [cardNumber substringWithRange:range];
    range = NSMakeRange(length - 4, 4);
    NSString * behindSubString = [cardNumber substringWithRange:range];
    return [NSString stringWithFormat:@"%@%@%@",frontSubString, @" **** **** ", behindSubString];
}

/* format money */
+ (NSString*)convertMoneyFormat:(NSString *)moneyString
{
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    [formatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [formatter setCurrencySymbol:@""];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSNumber * number = [NSNumber numberWithDouble:[moneyString doubleValue] * 0.01];
    NSString * formatMoneyString = [formatter stringFromNumber:number];
    return [formatMoneyString stringByAppendingString:@"元"];
}


#pragma mark - 清除本地登录状态

+ (void)clearLoginStatus
{
}

+ (UIView *)getTableViewLoadMoreView{
    //自定义加载更多的view
    UIView *loadMoreView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityIndicatorView startAnimating];
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 70, 20)];
    [textLabel setBackgroundColor:[UIColor clearColor]];
    [textLabel setFont:[UIFont systemFontOfSize:14.0]];
    [textLabel setTextColor:Y_COL_RGB(0x666666)];
    [textLabel setText:@"正在加载..."];
    [textLabel setCenter:CGPointMake(textLabel.center.x, textLabel.center.y)];
    [loadMoreView addSubview:activityIndicatorView];
    [loadMoreView addSubview:textLabel];
    
    return loadMoreView;
}


#pragma mark 根据folder拼网络图片URL

+ (NSURL*)urlWithFolder:(NSString*)folder withURL:(NSString*)org
{
    NSString* last = [org lastPathComponent];
    NSMutableString* tmp = [NSMutableString stringWithString:org];
    [tmp deleteCharactersInRange:NSMakeRange([org length] - [last length], [last length])];
    NSString* urlString = [NSString stringWithFormat:@"%@%@/%@",tmp,folder,last];
    return [NSURL URLWithString:urlString];
}



@end
