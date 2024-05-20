#  SpringBootFinalHomework2024



## 技术栈

SpringBoot + Mybatis + Redis + Thymeleaf



## 数据库设计（待完善）

数据库名springboot_final

**(1) user(用户表)**

<u>user_id</u> (用户主键)

username (用户名)

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

movie_ local_url (电影视频路径)

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