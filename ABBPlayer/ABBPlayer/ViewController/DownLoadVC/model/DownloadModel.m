//
//  DownloadModel.m
//  ABBPlayer
//
//  Created by beyondsoft-聂小波 on 16/9/20.
//  Copyright © 2016年 NieXiaobo. All rights reserved.
//

#import "DownloadModel.h"

@implementation DownloadModel

//defaultFormat 缺省下载格式：下载地址没有视频格式时设置
- (void)downLoadWith:(NSString *)playUrl title:(NSString *)title defaultFormat:(NSString *)defaultFormat {
    
    NSString * suffix = [[WHC_HttpManager shared] fileFormatWithUrl:playUrl];
     NSString * titleSuffix = [[WHC_HttpManager shared] fileFormatWithUrl:title];
    NSString * fileName = @"";
    if (titleSuffix) {
        fileName = title;
        
    } else {
        fileName = [NSString stringWithFormat:@"%@%@",
                    title,
                    suffix != nil ? suffix : defaultFormat];
    
    }
    
#if WHC_BackgroundDownload
[[WHC_SessionDownloadManager shared] setBundleIdentifier:@"com.WHC.WHCNetWorkKit.backgroundsession"];
WHC_DownloadSessionTask * downloadTask = [[WHC_SessionDownloadManager shared]
      download:playUrl
      savePath:[WHC_DownloadObject videoDirectory]
      saveFileName:fileName
      response:^(WHC_BaseOperation *operation, NSError *error, BOOL isOK) {
      } process:^(WHC_BaseOperation *operation, uint64_t recvLength, uint64_t totalLength, NSString *speed) {
          WHC_DownloadOperation * downloadOperation = (WHC_DownloadOperation*)operation;
          if (![WHC_DownloadObject existLocalSavePath:downloadOperation.saveFileName]) {
              WHC_DownloadObject * downloadObject = [WHC_DownloadObject new];
              [self toast:@"已经添加到下载队列"];
                            
              downloadObject.fileName = downloadOperation.saveFileName;
              downloadObject.downloadPath = downloadOperation.strUrl;
              downloadObject.downloadState = WHCDownloading;
              downloadObject.currentDownloadLenght = downloadOperation.recvDataLenght;
              downloadObject.totalLenght = downloadOperation.fileTotalLenght;
              //                  downloadObject.hostID = indexPath.row;
              [downloadObject writeDiskCache];
              
              
          }
          NSLog(@"后台下载：recvLength = %llu , totalLength = %llu , speed = %@",recvLength , totalLength , speed);
      } didFinished:^(WHC_BaseOperation *operation, NSData *data, NSError *error, BOOL isSuccess) {
          if (isSuccess) {
              [self toast:@"下载成功"];
              
              [self saveDownloadStateOperation:(WHC_DownloadOperation *)operation];
              
              WHC_DownloadOperation * downloadOperation = (WHC_DownloadOperation*)operation;
              WHC_DownloadObject * downloadObject = [WHC_DownloadObject readDiskCache:downloadOperation.saveFileName];
              downloadObject.fileName = downloadOperation.saveFileName;
              downloadObject.downloadPath = downloadOperation.strUrl;
              downloadObject.downloadState = WHCDownloading;
              downloadObject.currentDownloadLenght = downloadOperation.recvDataLenght;
              downloadObject.totalLenght = downloadOperation.fileTotalLenght;
              [downloadObject writeDiskCache];
              
          }else {
              [self toast:error.userInfo[NSLocalizedDescriptionKey]];
              if (error != nil &&
                  error.code == WHCCancelDownloadError) {
                  [self saveDownloadStateOperation:(WHC_DownloadOperation *)operation];
              }
          }
      }];

#else
WHC_DownloadOperation * downloadTask = nil;
downloadTask = [[WHC_HttpManager shared] download:playUrl
     savePath:[WHC_DownloadObject videoDirectory]
 saveFileName:fileName
     response:^(WHC_BaseOperation *operation, NSError *error, BOOL isOK) {
         if (isOK) {
             
             WHC_DownloadOperation * downloadOperation = (WHC_DownloadOperation*)operation;
             WHC_DownloadObject * downloadObject = [WHC_DownloadObject readDiskCache:downloadOperation.saveFileName];
             if (downloadObject == nil) {
                 [self toast:@"已经添加到下载队列"];
                 
                 downloadObject = [WHC_DownloadObject new];
             }
             downloadObject.fileName = downloadOperation.saveFileName;
             downloadObject.downloadPath = downloadOperation.strUrl;
             downloadObject.downloadState = WHCDownloading;
             downloadObject.currentDownloadLenght = downloadOperation.recvDataLenght;
             downloadObject.totalLenght = downloadOperation.fileTotalLenght;
             [downloadObject writeDiskCache];
         }else {
             [self errorHandle:(WHC_DownloadOperation *)operation error:error];
         }
     } process:^(WHC_BaseOperation *operation, uint64_t recvLength, uint64_t totalLength, NSString *speed) {
         NSLog(@"非后台下载：recvLength = %llu totalLength = %llu speed = %@",recvLength , totalLength , speed);
     } didFinished:^(WHC_BaseOperation *operation, NSData *data, NSError *error, BOOL isSuccess) {
         if (isSuccess) {
             [self toast:@"下载成功"];
             
             [self saveDownloadStateOperation:(WHC_DownloadOperation *)operation];
             
             WHC_DownloadOperation * downloadOperation = (WHC_DownloadOperation*)operation;
             WHC_DownloadObject * downloadObject = [WHC_DownloadObject readDiskCache:downloadOperation.saveFileName];
             downloadObject.fileName = downloadOperation.saveFileName;
             downloadObject.downloadPath = downloadOperation.strUrl;
             downloadObject.downloadState = WHCDownloading;
             downloadObject.currentDownloadLenght = downloadOperation.recvDataLenght;
             downloadObject.totalLenght = downloadOperation.fileTotalLenght;
             [downloadObject writeDiskCache];
             
         }else {
             [self errorHandle:(WHC_DownloadOperation *)operation error:error];
             if (error != nil &&
                 error.code == WHCCancelDownloadError) {
                 [self saveDownloadStateOperation:(WHC_DownloadOperation *)operation];
             }
         }
     }];
    
#endif
    if (downloadTask.requestStatus == WHCHttpRequestNone) {
#if WHC_BackgroundDownload
        if (![[WHC_SessionDownloadManager shared] waitingDownload]) {
            return;
        }
#else
        if (![[WHC_HttpManager shared] waitingDownload]) {
            return;
        }
#endif
        WHC_DownloadObject * downloadObject = [WHC_DownloadObject readDiskCache:downloadTask.saveFileName];
        if (downloadObject == nil) {
            [self toast:@"已经添加到下载队列"];
            
            downloadObject = [WHC_DownloadObject new];
            downloadObject.fileName = fileName;
            downloadObject.downloadPath = playUrl;
            downloadObject.downloadState = WHCDownloadWaitting;
            downloadObject.currentDownloadLenght = 0;
            downloadObject.totalLenght = 0;
            [downloadObject writeDiskCache];
        }
    }
}

- (void)saveDownloadStateOperation:(WHC_DownloadOperation *)operation {
    WHC_DownloadObject * downloadObject = [WHC_DownloadObject readDiskCache:operation.strUrl];
    if (downloadObject != nil) {
        downloadObject.currentDownloadLenght = operation.recvDataLenght;
        downloadObject.totalLenght = operation.fileTotalLenght;
        [downloadObject writeDiskCache];
    }
}

- (void) errorHandle:(WHC_DownloadOperation *)operation error:(NSError *)error {
    NSString * errInfo = error.userInfo[NSLocalizedDescriptionKey];
    if ([errInfo containsString:@"404"]) {
        [self toast:@"该文件不存在"];
        WHC_DownloadObject * downloadObject = [WHC_DownloadObject readDiskCache:operation.strUrl];
        if (downloadObject != nil) {
            [downloadObject removeFromDisk];
        }
    }else {
        if ([errInfo containsString:@"已经在下载中"]) {
            [self toast:errInfo];
        }else {
            [self toast:@"下载失败"];
        }
    }
}

- (void)toast:(NSString *)msg {
    if (self.showModelMssage) {
        self.showModelMssage(msg);
    }
}

@end
