//
//  GCYTestOneTask.m
//  GCYNetworkingDemo
//
//  Created by gaochongyang on 2018/4/25.
//  Copyright © 2018年 gaochongyang. All rights reserved.
//

#import "GCYTestOneTask.h"
#import "GCYConfig.h"
#import <AFNetworkActivityIndicatorManager.h>
#import "GCYNetworkingConfigure.h"

@implementation GCYTestOneTask
+ (GCYTestOneTask *)sharedInstance {
    static GCYTestOneTask *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[GCYTestOneTask alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.requestManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[[GCYConfig shareInstance] getURLString]]];
        
        self.requestManager.requestSerializer.timeoutInterval = kAPITimeOut;
        self.requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        self.requestManager.operationQueue.maxConcurrentOperationCount = 5;
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    }
    return self;
}
- (id)get:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    GCYNetworkingConfigure *configure = [GCYNetworkingConfigure configurer];
    configure.URLString = [self finalURLStringWithURLString:URLString];
    configure.parameters = parameters;
    configure.requestHttpMethod = GCYAPIRequestGET;
    
    __weak typeof(self) bself = self;
    return [self requestNetworkingConfigure:configure succsee:success notice:^(NSURLSessionDataTask *task, id responseObject) {
        if (failure) {
            failure(task, [bself convertNoticeResponeToError:responseObject]);
        }
    } failure:failure];
    
}
- (id)post:(NSString *)URLString parameters:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    GCYNetworkingConfigure *configure = [GCYNetworkingConfigure configurer];
    configure.URLString = [self finalURLStringWithURLString:URLString];
    configure.parameters = parameters;
    configure.requestHttpMethod = GCYAPIRequestPOST;
    
    __weak typeof(self) bself = self;
    return [self requestNetworkingConfigure:configure succsee:success notice:^(NSURLSessionDataTask *task, id responseObject) {
        if (failure) {
            failure(task, [bself convertNoticeResponeToError:responseObject]);
        }
    } failure:failure];
}

- (id)delete:(NSString *)URLString parameters:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    GCYNetworkingConfigure *configure = [GCYNetworkingConfigure configurer];
    configure.URLString = [self finalURLStringWithURLString:URLString];
    configure.parameters = parameters;
    configure.requestHttpMethod = GCYAPIRequestDELETE;
    
    __weak typeof(self) bself = self;
    return [self requestNetworkingConfigure:configure succsee:success notice:^(NSURLSessionDataTask *task, id responseObject) {
        if (failure) {
            failure(task, [bself convertNoticeResponeToError:responseObject]);
        }
    } failure:failure];
}
-(NSError *)convertNoticeResponeToError:(id)responseObject
{
    NSNumber * codeNumber = responseObject[@"code"];
    NSString * message = responseObject[@"error"];
    
    NSDictionary *errorDict = [NSDictionary dictionaryWithObjectsAndKeys:
                               message,NSLocalizedDescriptionKey,nil];
    
    NSError * error=[NSError errorWithDomain:@"Test" code:codeNumber.integerValue userInfo:errorDict];
    
    return error;
}

- (NSDictionary *)__finalParametersWithParams:(NSDictionary *)params
{
    return params;
}

- (NSString *)finalURLStringWithURLString:(NSString *)urlString
{
    return [NSString stringWithFormat:@"/%@", urlString];
}
@end
