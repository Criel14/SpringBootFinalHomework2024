#  SpringBootFinalHomework2024



## 技术栈

SpringBoot + Mybatis + Redis + Thymeleaf



## 数据库设计（待完善）

数据库名springboot_final

**(1) user(用户表)**

<u>userId</u> (用户主键)

username (用户名)

phoneNumber (手机号)

password (密码)

image(头像)

isVip (角色, 0: 普通用户, 1: VIP用户)



**(2) movie(电影表)**

<u>movieId</u> (电影主键)

movieTitle (电影标题)

movieCoverUrl (电影封面路径)

movieDescription (电影描述)

releaseDate (上映日期)

needVip (是否VIP影片, 0: 否, 1: 是)

movieLocalUrl (电影视频路径)

movieRegion (电影地区)

movieType (电影类型)

movieScore (电影评分)



**(3) staff(主创人员表)**

<u>staffId</u> (主键)

movieId (电影外键)

staffName (姓名)

staffRole (角色,0:演员,1:导演)



**(4) moviePlayback(电影播放)**

<u>movieId</u> (电影外键)

playDate (日期)

playOneDay (当日播放)



**(5) userPlaybackHistory(个人播放历史)**

userId (用户外键)

movieId (电影外键)

viewingTimestamp (观看时间)



## 主要功能

### (1) 登录注册

主页右上角点击用户头像，进入登录界面，提供登录和注册按钮。

**登录**的时候输入手机号和密码；输入错误会提示”用户名或密码错误“。

**注册**的时候输入手机号、用户名、密码；手机号已存在会有提示。

注册完成后会提示用户充值会员，点击可跳转到会员中心界面

### (2) 会员中心

在会员中心充值**会员**，充值的时候使用支付宝沙箱支付（待研究）

### (3) 主页

参考爱奇艺https://www.iqiyi.com/dianying/



**上方菜单**：

​		最左边：名称/logo；

​		最右边：搜索按钮：点击进入搜索界面，下拉菜单选择”按电影名“或”按导演“或”按演员“

**左侧菜单（可能不做了，统一用顶部导航栏）**：

​		（从上往下）

​		用户头像和用户名（未登录时，用户名处显示”未登录“）：点击进入用户中心/登录界面

​		观看历史：显示当前登录用户的观看历史，若未登录，显示”请登录提示并提供“登录按钮跳转至登录界面

​		会员中心：进入会员中心

​		首页：点击回到首页（首页显示热播、各类型选项、地区选项，展示不同的电影；会员电影的封面右上角加个”会员专享“；使用echarts展示网站电影数据总览）

​		免费专区：查看免费电影

​		会员专享：查看会员电影

​		排行：点击进入排行页面，可以选择本周播放排行，本月播放排行，全部播放排行，好评排行；提供”榜单下载"按钮，生成Excel供用户下载报表

​		



