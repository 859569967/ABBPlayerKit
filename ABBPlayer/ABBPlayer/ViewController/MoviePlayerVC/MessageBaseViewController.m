//
//  MessageBaseViewController.m
//  ABBPlayer
//
//  Created by beyondsoft-聂小波 on 16/9/21.
//  Copyright © 2016年 NieXiaobo. All rights reserved.
//

#import "MessageBaseViewController.h"
#import "DownloadModel.h"
@interface MessageBaseViewController ()<DownloadModelDeleget>

@end

@implementation MessageBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - 显示信息 DownloadModelDeleget
- (void)showMsg:(NSString *)message {
    [self.view toast:message];
}

@end
