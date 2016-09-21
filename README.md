# ABBPlayerKit
playing and downloading

# 实现功能 ：播放视频  后台下载

## 1、使用ZFPlayer播放视频（可以在线和本地播放）
## 2、使用WHCNetWorkKit 下载，后台下载


# 设置

CocoaPods 命令使用：
$ cd /Users/wangzz/Desktop/CocoaPodsTest  
$ touch Podfile  
$ vim Podfile 

### 添加库
pod 'Masonry'  (约束库)
pod 'SDWebImage'  
pod 'FDFullscreenPopGesture'
pod 'WHCNetWorkKit' (下载库)
//拖入ZFPlayer文件到项目中  (播放器)
$ pod install --verbose --no-repo-update
或者
$ pod update --verbose --no-repo-update

### 项目设置
1、项目（General） - Capabilities - Background Modes 开启（ON），Background fetch

//添加_sqlite3.tbd 依赖（项目中导入了数据库操作库）

### 功能代码 （下载demo）