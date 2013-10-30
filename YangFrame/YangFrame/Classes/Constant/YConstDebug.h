
//使用内部测试服务器 ,还需要修改本地化字符串，每次从default拷贝
//#define Y_BUILD_FOR_DEVELOP

//使用测试室服务器, 表示不再修改字符串，只拷贝第一次
//#define Y_BUILD_FOR_TEST 

//使用生产服务器, 表示不再修改字符串，只拷贝第一次
//#define Y_BUILD_FOR_RELEASE

//web app本地测试地址
//#define Y_WEB_APP_LOCAL_URL



#if !defined BUILD_FOR_DEVELOP && !defined BUILD_FOR_TEST && !defined BUILD_FOR_RELEASE
#define BUILD_FOR_DEVELOP
#endif

//打印LOG总开关

static const int ddLogLevel = LOG_LEVEL_VERBOSE;


#define DDERROR(xx, ...)  DDLogError(xx, ##__VA_ARGS__)

#define DDWARNING(xx, ...)  DDLogWarn(xx, ##__VA_ARGS__)

#define DDINFO(xx, ...)   DDLogInfo(xx, ##__VA_ARGS__)

#define DDVerbose(xx, ...)   DDLogVerbose(xx, ##__VA_ARGS__)

#define DDSTART()  DDLogVerbose(@"<<< %s",__PRETTY_FUNCTION__);

#define DDEND()   DDLogVerbose(@">>> %s",__PRETTY_FUNCTION__);

#if defined (__MM_DEBUG) || defined (__MM_UNIT_TEST)
#define DDLOG(fmt, ...) NSLog(@"%s [Line %d]\n" fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DDLOG(fmt, ...) ((void)0)
#endif

#define Y_RELEASE(X) 	if(X){[X release]; X = nil;}

#define Y_OBJATIDX(ARRAY,INDEX) (ARRAY&&(INDEX>=0)&&(INDEX<[ARRAY count]))?ARRAY[INDEX]:nil

#define Y_STR(X) [YUtils localizedStringWithKey:X]

#define Y_ARRAY(X) (NSArray*)[YUtils localizedArrayWithKey:X]

#define Y_COL_RGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define Y_COL_INT_RGB(r,g,b) [UIColor colorWithRed:((float)r)/255.0 green:((float)g)/255.0 blue:((float)b)/255.0 alpha:1.0]

#define Y_COL_STR(X)  [YUtils colorWithHexString:X]
 
#define Y_FILEEXIST(X) [[NSFileManager defaultManager] fileExistsAtPath:X]
// 判断string是否为00, 00表示JSON数据正常；
#define Y_RESPOK(X) ([X intValue] == kNetRespOkValue)

#define Y_ISRETINA [DeviceUtils isRetina]

#define Y_ISIPHONE5  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define Y_SHDAT    [YGlobleData sharedData]

#define Y_CGSizeScale(size, scale) CGSizeMake(size.width * scale, size.height * scale)

#define Y_CGRectScale(rect, scale) CGRectMake(rect.origin.x * scale, rect.origin.y * scale, rect.size.width * scale, rect.size.height * scale)

#define Y_GETIMG(X) [YUtils getImage:X]


#define Y_NC [NSNotificationCenter defaultCenter]

#define Y_USERDEFAULT  [NSUserDefaults standardUserDefaults]

#define Y_IOS_VERSION [[DeviceUtils deviceOSVersion] floatValue]

#define Y_PROPERTY(X) [YUtils propertyArray:X]

// 判断string是否为空 nil 或者 @"" 或者 @""；
#define Y_IS_NIL(X)  [YUtils isEmpty:X]

#define Y_URL(X)  [YUtils urlWithString:X]

//正则表达式
#define Y_REGEXP(X,REG)  [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", REG] evaluateWithObject:X]

#define Y_OBJINT(x)                        [NSNumber numberWithInteger:x]
#define Y_OBJNIL(x)                       (x == nil ? [NSNull null] : x)
#define Y_SAFESTRING(x)                   (x == nil ? @"" : x)

#define Y_App ((AppDelegate *)[UIApplication sharedApplication].delegate)

//打开URL
#define Y_CANOPENURL(appScheme) ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:appScheme]])
#define Y_OPENURL(appScheme) ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:appScheme]])

//DEPRECATED
#if defined(__GNUC__) && (__GNUC__ >= 4) && defined(__APPLE_CC__) && (__APPLE_CC__ >= 5465)
#define Y_DEPRECATED_ATTRIBUTE __attribute__((deprecated))
#else
#define Y_DEPRECATED_ATTRIBUTE
#endif

