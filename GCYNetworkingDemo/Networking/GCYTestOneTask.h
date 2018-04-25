//
//  GCYTestOneTask.h
//  GCYNetworkingDemo
//
//  Created by gaochongyang on 2018/4/25.
//  Copyright © 2018年 gaochongyang. All rights reserved.
//

#import "GCYNetworkingBase.h"

@interface GCYTestOneTask : GCYNetworkingBase

+ (GCYTestOneTask *)sharedInstance;

- (id)get:(NSString *)URLString
parameters:(NSDictionary *)parameters
  success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (id)post:(NSString *)URLString
parameters:(NSDictionary *)parameters
   success:(SuccessBlock)success
   failure:(FailureBlock)failure;

- (id)delete:(NSString *)URLString
parameters:(NSDictionary *)parameters
    success:(SuccessBlock)success
    failure:(FailureBlock)failure;

@end
