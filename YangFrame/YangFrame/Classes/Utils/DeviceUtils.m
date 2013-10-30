//
//  YDeviceUtils.m
//  YangFrame
//
//  Created by Yang Shichang on 13-10-26.
//  Copyright (c) 2013年 Yang152412. All rights reserved.
//

#import "DeviceUtils.h"
#import <CommonCrypto/CommonDigest.h>
#include <sys/sysctl.h>
#include <netinet/in.h>
#include <net/if.h>
#include <net/if_dl.h>

static CGSize       g_screenSize = {0,0};
static BOOL         g_isIphone5Simulator =NO;


@implementation DeviceUtils

/* Return a string description of the UUID, such as "E621E1F8-C36C-495A-93FC-0C247A3E6E5F" */
+ (NSString*)vendorIdentifier
{
    if ([[DeviceUtils deviceOSVersion] floatValue] >= 6.0) {
        return UIDevice.currentDevice.identifierForVendor.UUIDString;
    }
    else{
        return [self getMD5MAC];
    }
}


+ (NSString*)macaddress
{
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        //        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        //        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        //        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        //        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

+ (NSString*)getMD5MAC
{
    
    static NSString* uniqueIdentifier = nil;
    
    if (uniqueIdentifier == nil)
    {
        
        NSString *macaddress = [DeviceUtils macaddress];
        
        if(macaddress == nil || [macaddress length] == 0)
            return nil;
        
        const char *value = [macaddress UTF8String];
        
        unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
        CC_MD5(value, strlen(value), outputBuffer);
        
        NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
        for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
            [outputString appendFormat:@"%02x",outputBuffer[count]];
        }
        
        
        uniqueIdentifier = [[NSString alloc] initWithString:outputString];
    }
    
    return uniqueIdentifier;
}




//iPhone OS Name
+ (NSString*)deviceOSName
{
    return [[UIDevice currentDevice] systemName];
}
//4.3.3
+ (NSString*)deviceOSVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

//iPhone
+ (NSString*)deviceModel {
    return [[UIDevice currentDevice] model];
}

+ (NSString*)machineType
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *answer = (char*)malloc(size);
    sysctlbyname("hw.machine", answer, &size, NULL, 0);
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];//iPhone3,1
    free(answer);
    return results;
}

+ (NSString*)machineTypeMap
{
	NSString *platform = [DeviceUtils machineType];
	if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone1-1";
	if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone1-2";
	if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone2-1";
	if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone3-1";
	if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone4-1";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone5-1";
    
	if ([platform isEqualToString:@"iPod1,1"])   return @"iPod1-1";
	if ([platform isEqualToString:@"iPod2,1"])   return @"iPod2-1";
	if ([platform isEqualToString:@"iPod3,1"])   return @"iPod3-1";
	if ([platform isEqualToString:@"iPad1,1"])   return @"iPad1-1";
	if ([platform isEqualToString:@"iPad2,1"])   return @"iPad2-1";
    
	if ([platform hasPrefix:@"iPhone"]) return @"iPhone";
	if ([platform hasPrefix:@"iPod"]) return @"iPod";
	if ([platform hasPrefix:@"iPad"]) return @"iPad";
    
    if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"])
    {
        return @"Simulator";
    }
    
	return nil;
}

+ (int)machineTypeInt
{
	NSString *platform = [DeviceUtils machineType];
	if ([platform isEqualToString:@"iPhone1,1"]) return UIDevice1GiPhone;
	if ([platform isEqualToString:@"iPhone1,2"]) return UIDevice3GiPhone;
	if ([platform isEqualToString:@"iPhone2,1"]) return UIDevice3GSiPhone;
	if ([platform isEqualToString:@"iPhone3,1"]) return UIDevice4GiPhone;
	if ([platform isEqualToString:@"iPhone4,1"]) return UIDevice4GSiPhone;
    if ([platform isEqualToString:@"iPhone5,1"]) return UIDevice5iPhone;
	if ([platform isEqualToString:@"iPod1,1"])   return UIDevice1GiPod;
	if ([platform isEqualToString:@"iPod2,1"])   return UIDevice2GiPod;
	if ([platform isEqualToString:@"iPod3,1"])   return UIDevice3GiPod;
	if ([platform isEqualToString:@"iPad1,1"])   return UIDevice1GiPad;
	if ([platform isEqualToString:@"iPad2,1"])   return UIDevice2GiPad;
	if ([platform hasPrefix:@"iPhone"]) return UIDeviceUnknowniPhone;
	if ([platform hasPrefix:@"iPod"]) return UIDeviceUnknowniPod;
	if ([platform hasPrefix:@"iPad"]) return UIDeviceUnknowniPad;
    if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"])
    {
        if (g_isIphone5Simulator) {
            return UIDeviceiPhone5Simulator;
        }else
            return UIDeviceSimulator;
    }
	return UIDeviceUnknown;
}

+ (void)setIsIphone5Simulator:(BOOL) isOrNot
{
    g_isIphone5Simulator = isOrNot;
}

+ (CGSize)deviceScreenBound
{
    if ((g_screenSize.height ==0) && (g_screenSize.width ==0)) {
        if (([self machineTypeInt] == UIDevice5iPhone) || ([self machineTypeInt] == UIDeviceiPhone5Simulator))
        {      //主要是因为iphone5存在兼容模式 而在兼容模式下获取的bounds不对
            g_screenSize =CGSizeMake(320, 568);
        }else
        {
            g_screenSize =[UIScreen mainScreen].bounds.size;
        }
    }
    return g_screenSize;
}


+ (NSString*)machineTypeString
{
	switch ([DeviceUtils machineTypeInt])
	{
		case UIDevice1GiPhone: return IPHONE_1G_NAMESTRING;
		case UIDevice3GiPhone: return IPHONE_3G_NAMESTRING;
		case UIDeviceUnknowniPhone: return IPHONE_UNKNOWN_NAMESTRING;
		case UIDevice3GSiPhone: return IPHONE_3GS_NAMESTRING;
		case UIDevice4GiPhone: return IPHONE_4G_NAMESTRING;
		case UIDevice4GSiPhone: return IPHONE_4GS_NAMESTRING;
        case UIDevice5iPhone:   return IPHONE_5_NAMESTRING;
        case UIDeviceSimulator: return SIMULATOR_NAMESTRING;
		case UIDevice1GiPod: return IPOD_1G_NAMESTRING;
		case UIDevice2GiPod: return IPOD_2G_NAMESTRING;
		case UIDevice3GiPod: return IPOD_3G_NAMESTRING;
		case UIDevice1GiPad: return IPAD_1G_NAMESTRING;
		case UIDevice2GiPad: return IPAD_2G_NAMESTRING;
		case UIDeviceUnknowniPad: return IPAD_UNKNOWN_NAMESTRING;
		case UIDeviceUnknowniPod: return IPOD_UNKNOWN_NAMESTRING;
            
		default: return nil;
	}
}

+ (int)deviceResolution{
	switch ([DeviceUtils machineTypeInt])
	{
		case UIDevice1GiPhone: return UIDeviceScreen320X480;
		case UIDevice3GiPhone: return UIDeviceScreen320X480;
		case UIDeviceUnknowniPhone: return UIDeviceScreen320X480;
		case UIDevice3GSiPhone: return UIDeviceScreen320X480;
		case UIDevice4GiPhone: return UIDeviceScreen640X960;
		case UIDevice4GSiPhone:	return UIDeviceScreen640X960;
		case UIDevice1GiPod: return UIDeviceScreen320X480;
		case UIDevice2GiPod: return UIDeviceScreen320X480;
		case UIDevice3GiPod: return UIDeviceScreen640X960;
		case UIDevice1GiPad: return UIDeviceScreen768X1024;
		case UIDevice2GiPad: return UIDeviceScreen768X1024;
		case UIDeviceUnknowniPad: return UIDeviceScreen768X1024;
		case UIDeviceUnknowniPod: return UIDeviceScreen320X480;
			
		default: return UIDeviceScreen320X480;
	}
    
}

+ (int)platformCapabilities
{
	switch ([DeviceUtils machineTypeInt])
	{
		case UIDevice1GiPhone: return UIDeviceBuiltInSpeaker | UIDeviceBuiltInCamera | UIDeviceBuiltInMicrophone | UIDeviceSupportsExternalMicrophone | UIDeviceSupportsTelephony | UIDeviceSupportsVibration;
		case UIDevice3GiPhone: return UIDeviceSupportsGPS | UIDeviceBuiltInSpeaker | UIDeviceBuiltInCamera | UIDeviceBuiltInMicrophone | UIDeviceSupportsExternalMicrophone | UIDeviceSupportsTelephony | UIDeviceSupportsVibration;
		case UIDeviceUnknowniPhone: return UIDeviceBuiltInSpeaker | UIDeviceBuiltInCamera | UIDeviceBuiltInMicrophone | UIDeviceSupportsExternalMicrophone | UIDeviceSupportsTelephony | UIDeviceSupportsVibration;
            
		case UIDevice1GiPod: return 0;
		case UIDevice2GiPod: return UIDeviceBuiltInSpeaker | UIDeviceBuiltInMicrophone | UIDeviceSupportsExternalMicrophone;
		case UIDeviceUnknowniPod: return 0;
            
		default: return 0;
	}
}

+ (NSString*)deviceWidth
{
    CGRect mainRect =  [UIScreen mainScreen].bounds;
	CGFloat scale = [UIScreen mainScreen].scale;
    int width =(int) mainRect.size.width*scale;
    NSString* strWidth = [NSString stringWithFormat:@"%d",width];
    return strWidth;
}

+ (NSString*)deviceHeight
{
    CGRect mainRect =  [UIScreen mainScreen].bounds;
	CGFloat scale = [UIScreen mainScreen].scale;
    int height =(int) mainRect.size.height*scale;
    NSString* strHeight = [NSString stringWithFormat:@"%d",height];
    return strHeight;
}

#pragma mark -
#pragma mark 是否retina

+ (BOOL)isRetina
{
    static BOOL isRetinaSkin = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isRetinaSkin = [UIScreen mainScreen].scale > 1.0;
    });
    return isRetinaSkin;
}

#pragma mark -
#pragma mark 判断是否越狱

+ (BOOL)isJailbroken
{
    
    //If the app is running on the simulator
#if TARGET_IPHONE_SIMULATOR
    return NO;
    
    //If its running on an actual device
#else
    BOOL isJailbroken = NO;
    
    //This line checks for the existence of Cydia
    
    BOOL cydiaInstalled = [[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"];
    
    FILE *f = fopen("/bin/bash", "r");
    
    if (!(errno == ENOENT) || cydiaInstalled) {
        
        //Device is jailbroken
        isJailbroken = YES;
    }
    fclose(f);
    return isJailbroken;
#endif
}

@end
