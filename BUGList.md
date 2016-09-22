# bug

## 修改暂停下载提示语“下载失败” -> “暂停下载”  ✅
## 下载过程中无断网提示  下载状态没有改变 ✅
## 进入下载中心，未下载完成的任务，初始化进度错误 ✅

        - (void)updateDownloadValue {
            _titleLabel.text = _downloadObject.fileName;
            _progressBar.progress = _downloadObject.downloadProcessValue;
            _downloadValueLabel.text = _downloadObject.downloadProcessText;
            NSString * strSpeed = _downloadObject.downloadSpeed;
            if (_downloadObject.downloadState != WHCDownloading) {
            [self removeDownloadAnimtion];
            }else {

            [_downloadObject writeDiskCache]; //增加保存进度

            [self startDownloadAnimation];
            }

## 重复下载提示语“下载失败” -> “已下载“

## 添加下载百分比