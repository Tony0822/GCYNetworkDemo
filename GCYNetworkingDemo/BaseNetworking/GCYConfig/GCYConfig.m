//
//  GCYConfig.m
//  GCYNetworkingDemo
//
//  Created by gaochongyang on 2018/4/25.
//  Copyright © 2018年 gaochongyang. All rights reserved.
//

#import "GCYConfig.h"




#define ServerUrlKey_GCY @"ServerUrlKey_GCY"

@interface GCYConfig ()
@property (nonatomic, strong) NSDictionary *apiDic;

@end


@implementation GCYConfig
+ (GCYConfig *)shareInstance {
    static GCYConfig *appConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!appConfig) {
            appConfig = [[GCYConfig alloc] init];
            appConfig.apiDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"GWConfigFile" ofType:@"plist"]];
        }
    });
    return appConfig;
}

- (void)saveCurrentConfigWith:(NSInteger)index {
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey: ServerUrlKey_GCY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *)getURLString {
    NSString *severurl;
    
    NSInteger sKey = [[[NSUserDefaults standardUserDefaults] objectForKey:ServerUrlKey_GCY] integerValue];
    NSArray *urlDicArray = self.apiDic[@"Test1"];
    if (sKey >= urlDicArray.count) {
        sKey = 0;
    }
    NSDictionary *dic = urlDicArray[sKey];
    severurl = dic[@"BaseURL"];
    
    return severurl;
}

- (NSMutableArray *)getURLTitleArray {
    NSArray *urlDicArray = self.apiDic[@"Test1"];
    NSMutableArray *titleArray = [NSMutableArray array];
    NSInteger sKey = [[[NSUserDefaults standardUserDefaults] objectForKey:ServerUrlKey_GCY] integerValue];
    for (NSDictionary *dic in urlDicArray) {
        NSString *title = dic[@"Title"];
        if (titleArray.count == sKey) {
            title = [title stringByAppendingString:@"(*)"];
        }
        [titleArray addObject:title];
    }
    return titleArray;
}
@end
