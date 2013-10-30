//
//  YGlobalData.m
//  YangFrame
//
//  Created by Yang Shichang on 13-10-27.
//  Copyright (c) 2013年 Yang152412. All rights reserved.
//

#import "YGlobalData.h"

@implementation YGlobalData

+ (YGlobalData*)sharedData
{
    static YGlobalData* sharedData = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedData = [[self alloc] init];
    });
    
    return sharedData;
}


- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}



@end
