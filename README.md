# ABBPlayerKit
playing and downloading

# 实现功能 ：播放视频  后台下载

## 1、使用 [ZFPlayer](https://github.com/renzifeng/ZFPlayer) 播放视频（可以在线和本地播放）
## 2、使用[WHCNetWorkKit](https://github.com/netyouli/WHCNetWorkKit) 下载，后台下载


# 设置

### CocoaPods 命令使用：

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

### 注意事项：
        播放音视频的demo设置全局断点All Exceptions 会导致（Xcode异常：0 __cxa_throw） libc++abi.dylib`__cxa_throw:0x10df1bc6b <+0>: pushq %rbp，........（但是不是崩溃，不连接xcode运行不会崩溃，连接xcode运行时就会停顿在这里），是因为添加了全局断点：All Exceptions，但是没有设置oc！

![Exceptions](images/stifF.png)


##运行效果

[ZFPlayer播放展示图](https://github.com/renzifeng/ZFPlayer)

![Picture effect](https://github.com/renzifeng/ZFPlayer/raw/master/screen.gif)

![Sound adjustment demonstration](https://github.com/renzifeng/ZFPlayer/raw/master/volume.png)

![Brightness adjustment demonstration](https://github.com/renzifeng/ZFPlayer/raw/master/brightness.png)

![Progress adjustment demonstration](https://github.com/renzifeng/ZFPlayer/raw/master/progress.png)

[WHCNetWorkKit下载展示图](https://github.com/netyouli/WHCNetWorkKit)


![](https://github.com/netyouli/WHCNetWorkKit/blob/master/show.gif)




