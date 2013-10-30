//
//  YNetEngine.m
//  MovieClient
//
//  Created by Yang Shichang on 13-10-27.
//  Copyright (c) 2013年 Yang152412. All rights reserved.
//

#import "YNetEngine.h"

@implementation YNetEngine

- (void)cancelAllOperations
{
    [self cancelAllOperations];
}

- (MKNetworkOperation*)post:(NSString*)body
                     header:(NSDictionary*)header
          completionHandler:(NKResponseDataBlock) completionBlock
               errorHandler:(NKErrorBlock) errorBlock
{
    
    NSDictionary* tmp = [NSDictionary dictionaryWithObject:body forKey:@"postDataKey"];
    
    MKNetworkOperation *op =[self operationWithURLString:KPOST_ADDR params:tmp httpMethod:@"POST"];
    
    DDINFO(@"POST ADDR %@",KPOST_ADDR);
    //MKNetworkKit不支持类似ASI的appendBodyData, 只有 addBody:forKey: , 只有通过这个补丁来setHttpBody
    [op setCustomPostDataEncodingHandler:^(NSDictionary* postDataDict){
        return [postDataDict objectForKey:@"postDataKey"];
    } forType:@"application/json"];
    
    //必须是MKNKPostDataEncodingTypeURL
    //    [op setPostDataEncoding:MKNKPostDataEncodingTypeJSON];
    [op addHeaders:header];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation){
        completionBlock([completedOperation responseData],completedOperation);
    }
                errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
                    errorBlock(error,errorOp);
                }];
    
    [self enqueueOperation:op];
    
    return op;
}


- (MKNetworkOperation*)post:(NSString*)url
                body:(NSString*)body
              header:(NSDictionary*)header
   completionHandler:(NKResponseDataBlock) completionBlock
        errorHandler:(NKErrorBlock) errorBlock
{
    if (Y_IS_NIL(url)) {
        return nil;
    }
    NSDictionary* tmp = [NSDictionary dictionaryWithObject:body forKey:@"postDataKey"];
    
    MKNetworkOperation *op = [self operationWithURLString:url
                                                   params:tmp
                                               httpMethod:@"POST"];
    
    //MKNetworkKit不支持类似ASI的appendBodyData, 只有 addBody:forKey: , 只有通过这个补丁来setHttpBody
    [op setCustomPostDataEncodingHandler:^(NSDictionary* postDataDict){
        return [postDataDict objectForKey:@"postDataKey"];
    } forType:@"application/json"];
    
    //必须是MKNKPostDataEncodingTypeURL
    //    [op setPostDataEncoding:MKNKPostDataEncodingTypeJSON];
    
    [op addHeaders:header];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation){
        completionBlock([completedOperation responseData],completedOperation);
    }
                errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
                    errorBlock(error,errorOp);
                }];
    
    [self enqueueOperation:op];
    
    return op;
    

}


@end
