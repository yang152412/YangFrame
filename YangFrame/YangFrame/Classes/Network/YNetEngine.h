//
//  YNetEngine.h
//  MovieClient
//
//  Created by Yang Shichang on 13-10-27.
//  Copyright (c) 2013年 Yang152412. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkEngine.h"

typedef void (^NKResponseDataBlock)(NSData* responseData,NSOperation* operation);
typedef void (^NKErrorBlock)(NSError* error,NSOperation* operation);

@interface YNetEngine : MKNetworkEngine


- (MKNetworkOperation*)post:(NSString*)body
                     header:(NSDictionary*)header
          completionHandler:(NKResponseDataBlock) completionBlock
               errorHandler:(NKErrorBlock) errorBlock;

- (void)cancelAllOperations;

- (MKNetworkOperation*)post:(NSString*)url
                body:(NSString*)body
              header:(NSDictionary*)header
   completionHandler:(NKResponseDataBlock) completionBlock
        errorHandler:(NKErrorBlock) errorBlock;

@end
