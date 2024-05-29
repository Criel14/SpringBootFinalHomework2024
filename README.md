#  SpringBootFinalHomework2024



## 技术栈

前端：html + css + js, 部分jQuery, 部分Thymeleaf

后端：springboot (**jdk-21**), mybatis plus, redis

其他：支付宝沙箱支付技术，POI报表技术，echarts图表



## 主要功能

### 用户功能

(1) 登录与注册

(2) 会员充值功能：用户登陆后，在“会员中心”页面充值成为VIP会员

(3) 权限控制：会员专享电影非会员无法观看，并且提示充值

(4) 播放历史：展示个人播放的历史记录

### 电影展示

(1) 分类展示：主页提供热播以及不同地区与类型的按钮，点击展示相应电影，结果采用分页展示

(2) 电影排行：多个排行榜，热度榜、必看榜、本周榜、本月榜、好评榜

### 搜索功能

可依据电影名称、电影类型、电影地区、导演、演员搜索

### 其他功能

(1) 在排行页面下载当前排行榜的Excel报表

(2) 每部电影的播放页面下方展示近期每日播放量的变化折线图，在主页展示电影库中的类型分布柱状图和地区分布饼状图



## 数据库设计

数据库**springboot_final**

**(1) user(用户表)**

<u>user_id</u> (用户主键)

username (用户名)

phone_number (手机号)

password (密码)

image(头像)

is_vip (角色, 0: 普通用户, 1: VIP用户)



**(2) movie(电影表)**

<u>movie_id</u> (电影主键)

movie_title (电影标题)

movie_cover_url (电影封面路径)

movie_description (电影描述)

release_date (上映日期)

need_vip (是否VIP影片, 0: 否, 1: 是)

video_url (电影视频路径)

movie_region (电影地区)

movie_type (电影类型)

movie_score (电影评分)



**(3) staff(主创人员表)**

<u>staff_id</u> (主键)

movie_id (电影外键)

staff_name (姓名)

staff_role (角色,0:演员,1:导演)



**(4) movie_playback(电影播放)**

<u>movie_id</u> (电影外键)

play_date (日期)

play_one_day (当日播放)



**(5) user_playback_history(个人播放历史)**

user_id (用户外键)

movie_id (电影外键)

viewing_timestamp (观看时间)



## 部署在你的电脑上

### 下载

二选一

- 选择Code>Download ZIP，解压后通过IDEA打开
- 选择Code>Https>复制url，打开IDEA>File>Close Project关闭你当前的项目>Get from VCS，粘贴url即可

### 导入数据库

打开项目根目录下的database.sql，在你的Mysql Command Line Client中使用如下命令，或直接复制sql文件的内容

```powershell
source /project_path/database.sql;
```

请保证你打开sql时使用utf-8

### 打开Redis

确保你的电脑安装了Redis

```powershell
redis-server
```

### 运行

在IDEA中点击运行项目，在浏览器输入以下地址即可进入网站首页

```
http://localhost:8090/index
```



## 注意事项

(1) 因为网页中的视频采用b站视频外链，所以运行时请保证网络连接通畅

(2) 支付页面的二维码需要使用沙箱支付宝来扫码而不是原版支付宝，具体请访问支付宝沙箱支付官网

(3) 前端页面没有适配所有尺寸的屏幕，需自行缩放网页

(4) 项目部署在本地电脑的时候，沙箱支付的支付信息无法从阿里的服务器传递回来（需要公网IP），因此我们设置了在支付页面按下"p"键即可完成支付



## 关于

本项目是学校2023-2024学年第二学期Springboot课程的期末大作业，以实现作业要求为目标编写，因此许多功能并未完善，代码也比较混乱。

本项目由宿舍4个人共同完成，在Gitee上协作开发，现开源至github

如有疑问，可联系1298373079@qq.com

