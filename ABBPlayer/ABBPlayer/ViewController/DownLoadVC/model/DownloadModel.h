//
//  DownloadModel.h
//  ABBPlayer
//
//  Created by beyondsoft-聂小波 on 16/9/20.
//  Copyright © 2016年 NieXiaobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WHC_DownloadObject.h"
#import <WHCNetWorkKit/WHC_HttpManager.h>

@protocol DownloadModelDeleget <NSObject>

- (void)showMsg:(NSString *)message;

@end

@interface DownloadModel : NSObject

@property (nonatomic, strong) id <DownloadModelDeleget> deleget;


- (void)downLoadWith:(NSString *)playUrl title:(NSString *)title;
@end
