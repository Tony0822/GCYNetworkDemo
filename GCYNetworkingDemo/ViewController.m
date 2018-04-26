//
//  ViewController.m
//  GCYNetworkingDemo
//
//  Created by gaochongyang on 2018/4/25.
//  Copyright © 2018年 gaochongyang. All rights reserved.
//

#import "ViewController.h"
#import "GCYTestOneTask.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"click" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}
- (void)buttonClick {
    [self createTestOneTask];

}

- (void)createTestOneTask {
    [[GCYTestOneTask sharedInstance] get:@"GCYBase" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
