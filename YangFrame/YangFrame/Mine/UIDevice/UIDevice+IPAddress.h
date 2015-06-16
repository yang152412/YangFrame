//
//  UIDevice+IPAddress.h
//  neighborhood
//
//  Created by 杨世昌 on 15/6/15.
//  Copyright (c) 2015年 iYaYa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (IPAddress)

// wifi
- (NSString *)getWifiIPAddress;

// 只有 ip
- (NSString *)getIPAddress:(BOOL)preferIPv4;
- (NSDictionary *)getIPAddresses;

// Get All ipv4 interface,包括掩码，网关
- (NSDictionary *)getAllIPV4Addresses;

@end
