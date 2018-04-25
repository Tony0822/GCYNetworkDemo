//
//  GCYConfig.h
//  GCYNetworkingDemo
//
//  Created by gaochongyang on 2018/4/25.
//  Copyright © 2018年 gaochongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IS_ONE [GWConfig shareInstance].appMode==GWAppMode_Gewara
#define IS_TWO [GWConfig shareInstance].appMode==GWAppMode_Yupiao
#define IS_THIRD [GWConfig shareInstance].appMode==GWAppMode_Offline

typedef enum : NSUInteger {
    GWAppMode_Gewara,
    GWAppMode_Yupiao,
    GWAppMode_Offline,
} GCYAppMode;

@interface GCYConfig : NSObject
+ (GCYConfig *)shareInstance;

- (void)saveCurrentConfigWith:(NSInteger)index;

- (NSString *)getURLString;

- (NSMutableArray *)getURLTitleArray;


@end
