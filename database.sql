DROP DATABASE springboot_final;
CREATE DATABASE springboot_final;
USE springboot_final;

-- 创建用户表
CREATE TABLE user
(
    user_id      INT AUTO_INCREMENT PRIMARY KEY,
    username     VARCHAR(50)  NOT NULL UNIQUE,
    password     VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15)  NOT NULL,
    image        VARCHAR(200)          DEFAULT null,
    is_vip       TINYINT      NOT NULL DEFAULT 0
);

-- 创建电影表
CREATE TABLE movie
(
    movie_id          INT AUTO_INCREMENT PRIMARY KEY,
    movie_title       VARCHAR(100) NOT NULL,
    movie_cover_url   VARCHAR(100) NOT NULL,
    movie_description TEXT,
    release_date      DATE,
    need_vip          TINYINT      NOT NULL DEFAULT 0,
    movie_local_url   VARCHAR(200),
    movie_region      VARCHAR(50),
    movie_type        VARCHAR(50),
    movie_score       DECIMAL(3, 2)
);

-- 创建主创人员表
CREATE TABLE staff
(
    staff_id   INT AUTO_INCREMENT PRIMARY KEY,
    movie_id   INT         NOT NULL,
    staff_name VARCHAR(50) NOT NULL,
    staff_role TINYINT     NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES movie (movie_id)
);

-- 创建电影播放表
CREATE TABLE movie_playback
(
    movie_id     INT NOT NULL,
    play_one_day INT NOT NULL DEFAULT 0,
    play_date    DATE,
    FOREIGN KEY (movie_id) REFERENCES movie (movie_id)
);

-- 创建个人播放历史表
CREATE TABLE user_playback_history
(
    user_id           INT      NOT NULL,
    movie_id          INT      NOT NULL,
    viewing_timestamp DATETIME NOT NULL,
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (user_id) REFERENCES user (user_id),
    FOREIGN KEY (movie_id) REFERENCES movie (movie_id)
);

-- 插入测试用户数据
insert into user(username, phone_number, password)
VALUES ('aa', '123456', '123456');

-- 插入电影数据
INSERT INTO movie (movie_id, movie_title, movie_description, release_date, need_vip, movie_cover_url, movie_local_url,
                   movie_region, movie_type, movie_score)
VALUES (1, '美丽人生',
        '犹太青年圭多（罗伯托·贝尼尼）邂逅美丽的女教师多拉（尼可莱塔·布拉斯基），他彬彬有礼的向多拉鞠躬：“早安！公主！”。历经诸多令人啼笑皆非的周折后，天遂人愿，两人幸福美满的生活在一起。',
        '1997-12-20 00:00:00', 1, 'cover001.jpg', 'video001.mp4', '意大利', 'comedy', 9.5);
INSERT INTO movie (movie_id, movie_title, movie_description, release_date, need_vip, movie_cover_url, movie_local_url,
                   movie_region, movie_type, movie_score)
VALUES (2, '三傻大闹宝莱坞',
        '本片根据印度畅销书作家奇坦·巴哈特（Chetan Bhagat）的处女作小说《五点人》（Five Point Someone）改编而成。法兰（马德哈万 R Madhavan 饰）、拉杜（沙曼·乔希 Sharman Joshi 饰）与兰乔（阿米尔·汗 Aamir Khan 饰）是皇家工程学院的学生，三人共居一室，结为好友。在以严格著称的学院里，兰乔是个非常与众不同的学生，他不死记硬背，甚至还公然顶撞校长“病毒”（波曼·伊拉尼 Boman Irani 饰），质疑他的教学方法。他不仅鼓动法兰与拉杜去勇敢追寻理想，还劝说校长的二女儿碧雅（卡琳娜·卡普 Kareena Kapoor 饰）离开满眼铜臭的未婚夫。兰乔的特立独行引起了模范学生“消音器”（奥米·维嘉 Omi Vaidya 饰）的不满，他约定十年后再与兰乔一决高下，看哪种生活方式更能取得成功。',
        '2009-12-25 00:00:00', 0, 'cover002.jpg', 'video002.mp4', '印度', 'comedy', 9.2);
INSERT INTO movie (movie_id, movie_title, movie_description, release_date, need_vip, movie_cover_url, movie_local_url,
                   movie_region, movie_type, movie_score)
VALUES (3, '机器人总动员',
        '公元2805年，人类文明高度发展，却因污染和生活垃圾大量增加使得地球不再适于人类居住。地球人被迫乘坐飞船离开故乡，进行一次漫长无边的宇宙之旅。临行前他们委托Buynlarge的公司对地球垃圾进行清理，该公司开发了名为WALL·E（Waste Allocation Load Lifters – Earth 地球废品分装员）的机器人担当此重任。',
        '2008-06-27 00:00:00', 1, 'cover003.jpg', 'video003.mp4', '美国', 'animation', 9.3);
INSERT INTO movie (movie_id, movie_title, movie_description, release_date, need_vip, movie_cover_url, movie_local_url,
                   movie_region, movie_type, movie_score)
VALUES (4, '无间道',
        '1991年，香港黑帮三合会会员刘健明（刘德华）听从老大韩琛（曾志伟）的吩咐，加入警察部队成为黑帮卧底，韩琛许诺刘健明会帮其在七年后晋升为见习督察。1992年，警察训练学校优秀学员陈永仁（梁朝伟）被上级要求深入到三合会做卧底，终极目标是成为韩琛身边的红人。2002年，两人都不负重望，也都身背重压，刘健明渐想成为一个真正的好人，陈永仁则盼着尽快回归警察身份。',
        '2002-12-12 00:00:00', 1, 'cover004.jpg', 'video004.mp4', '中国', 'action', 9.3);
INSERT INTO movie (movie_id, movie_title, movie_description, release_date, need_vip, movie_cover_url, movie_local_url,
                   movie_region, movie_type, movie_score)
VALUES (5, '大话西游之大圣娶亲',
        '至尊宝（周星驰 饰）被月光宝盒带回到五百年前，遇见紫霞仙子（朱茵 饰），被对方打上烙印成为对方的人，并发觉自己已变成孙悟空。',
        '1995-02-04 00:00:00', 0, 'cover005.jpg', 'video005.mp4', '中国', 'comedy', 9.2);
INSERT INTO movie (movie_id, movie_title, movie_description, release_date, need_vip, movie_cover_url, movie_local_url,
                   movie_region, movie_type, movie_score)
VALUES (6, '千与千寻',
        '千寻和爸爸妈妈一同驱车前往新家，在郊外的小路上不慎进入了神秘的隧道——他们去到了另外一个诡异世界—一个中世纪的小镇。远处飘来食物的香味，爸爸妈妈大快朵颐，孰料之后变成了猪！这时小镇上渐渐来了许多样子古怪、半透明的人。',
        '2001-07-20 00:00:00', 1, 'cover006.jpg', 'video006.mp4', '日本', 'animation', 9.4);
INSERT INTO movie (movie_id, movie_title, movie_description, release_date, need_vip, movie_cover_url, movie_local_url,
                   movie_region, movie_type, movie_score)
VALUES (7, '这个杀手不太冷',
        '里昂（让·雷诺饰）是名孤独的职业杀手，受人雇佣。一天，邻居家小姑娘马蒂尔达（纳塔丽·波特曼饰)敲开他的房门，要求在他那里暂避杀身之祸。原来邻居家的主人是警方缉毒组的眼线，只因贪污了一小包毒品而遭恶警（加里·奥德曼饰）杀害全家的惩罚。马蒂尔达得到里昂的留救，幸免于难，并留在里昂那里。里昂教小女孩使枪，她教里昂法文，两人关系日趋亲密，相处融洽。',
        '1994-09-14 00:00:00', 1, 'cover007.jpg', 'video007.mp4', '法国', 'action', 9.4);
INSERT INTO movie (movie_id, movie_title, movie_description, release_date, need_vip, movie_cover_url, movie_local_url,
                   movie_region, movie_type, movie_score)
VALUES (8, '疯狂动物城',
        '故事发生在一个所有哺乳类动物和谐共存的美好世界中，兔子朱迪（金妮弗·古德温 Ginnifer Goodwin 配音）从小就梦想着能够成为一名惩恶扬善的刑警，凭借着智慧和努力，朱迪成功的从警校中毕业进入了疯狂动物城警察局，殊不知这里是大型肉食类动物的领地，作为第一只，也是唯一的小型食草类动物，朱迪会遇到怎样的故事呢？',
        '2016-03-04 00:00:00', 1, 'cover008.jpg', 'video008.mp4', '美国', 'animation', 9.2);
INSERT INTO movie (movie_id, movie_title, movie_description, release_date, need_vip, movie_cover_url, movie_local_url,
                   movie_region, movie_type, movie_score)
VALUES (9, '怦然心动',
        '布莱斯（卡兰•麦克奥利菲 Callan McAuliffe 饰）全家搬到小镇，邻家女孩朱丽（玛德琳•卡罗尔 Madeline Carroll 饰）前来帮忙。她对他一见钟情，心愿是获得他的吻。两人是同班同学，她一直想方设法接近他，但是他避之不及。她喜欢爬在高高的梧桐树上看风景。但因为施工，树被要被砍掉，她誓死捍卫，希望他并肩作战，但是他退缩了。她的事迹上了报纸，外公对她颇有好感，令他十分困惑。她凭借鸡下蛋的项目获得了科技展第一名，成了全场焦点，令他黯然失色。她把自家鸡蛋送给他，他听家人怀疑她家鸡蛋不卫生，便偷偷把鸡蛋丢掉。她得知真相，很伤心，两人关系跌入冰点。她跟家人诉说，引发争吵。原来父亲一直攒钱照顾傻弟弟，所以生活拮据。她理解了父母，自己动手，还得到了他外公的鼎力相助。他向她道歉，但是并未解决问题。他开始关注她。鸡蛋风波未平，家庭晚宴与午餐男孩评选... ',
        '2010-07-26 00:00:00', 1, 'cover009.jpg', 'video009.mp4', '美国', 'comedy', 9.1);
INSERT INTO movie (movie_id, movie_title, movie_description, release_date, need_vip, movie_cover_url, movie_local_url,
                   movie_region, movie_type, movie_score)
VALUES (10, '蝙蝠侠：黑暗骑士',
        '从亲眼目睹父母被人杀死的阴影中走出来的“蝙蝠侠”，经历了成长之后，已经不再是那个桀骜不的孤单英雄了。在警官吉姆·戈登和检查官哈维·登特的通力帮助下，“蝙蝠侠”无后顾之忧地继续满世界的奔波，与日益增长起来的犯罪威胁做着永无休止的争斗，而他所在的高谭市，也是进展最为明显的地方，犯罪率以一种惊人的速度持续下降着，毕竟对方是能够上天入地的“蝙蝠侠”，不借两个胆子谁还敢造次呢？不过像高谭这种科技与污秽并存的城市，平静是不可能维持太久的，果不其然，新一轮的混乱很快就席卷了整个城市，人们再一被被恐慌所笼罩着，而声称愿意为这一切负责的，自然就是所有混乱的源头以及支配者--“小丑”了。　　先不管“小丑”掀起一个又一个犯罪的狂潮的最终目的为何，他的企图都是邪恶的，所作所为更是早就危害到了高谭市民的正常生活……其中自然包括了“蝙蝠侠”身边几个非常重要的人，而他需要做的，就是将这股新的危机全部亲自用手捏得粉碎。然而在面对着这个有史以来最具针对性、最恶毒的对手时，“蝙蝠侠”却不得不从他的地下军械库里搬出每一件能够用得上的高科技武器，还得时刻纠结着为他曾经信仰的一切寻找答案。',
        '2008-07-14 00:00:00', 1, 'cover010.jpg', 'video010.mp4', '美国', 'action', 9.2);

-- 插入staff表数据
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (1, 1, '罗伯托·贝尼尼', 1);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (2, 1, '尼可莱塔·布拉斯基 ', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (3, 1, '乔治·坎塔里尼', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (4, 2, ' 拉吉库马尔·希拉尼', 1);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (5, 2, '阿米尔·汗 ', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (6, 2, '卡琳娜·卡普尔 ', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (7, 2, '马达范', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (8, 2, '沙尔曼·乔希 ', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (9, 3, '安德鲁·斯坦顿', 1);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (10, 3, ' 本·贝尔特', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (11, 3, '艾丽莎·奈特 ', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (12, 3, '杰夫·格尔林', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (13, 4, '刘伟强', 1);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (14, 4, '麦兆辉', 1);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (15, 4, '刘德华 ', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (16, 4, '梁朝伟', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (17, 4, ' 黄秋生', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (18, 5, '刘镇伟', 1);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (19, 5, '周星驰', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (20, 5, '朱茵', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (21, 5, '蔡少芬', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (22, 6, '宫崎骏', 1);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (23, 6, '柊瑠美', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (24, 6, '入野自由', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (25, 6, '夏木真理 ', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (26, 7, '吕克·贝松', 1);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (27, 7, '让·雷诺 ', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (28, 7, '娜塔莉·波特曼', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (29, 7, '加里·奥德曼', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (30, 8, '拜伦·霍华德 ', 1);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (31, 8, '瑞奇·摩尔', 1);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (32, 8, '杰拉德·布什', 1);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (33, 8, '金妮弗·古德温 ', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (34, 8, '杰森·贝特曼', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (35, 8, '伊德瑞斯·艾尔巴', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (36, 9, '罗伯·莱纳', 1);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (37, 9, '玛德琳·卡罗尔 ', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (38, 9, '卡兰·麦克奥利菲 ', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (39, 9, '瑞贝卡·德·莫妮', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (40, 9, '安东尼·爱德华兹 ', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (41, 10, '克里斯托弗·诺兰', 1);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (42, 10, '艾伦·艾克哈特', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (43, 10, '希斯·莱杰', 0);
INSERT INTO staff (staff_id, movie_id, staff_name, staff_role)
VALUES (44, 10, '克里斯蒂安·贝尔 ', 0);

-- 插入电影播放量数据
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 10000, '1998-01-01 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 12000, '1998-01-02 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 14000, '1998-01-03 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 13000, '1998-01-04 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 12000, '1998-01-05 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 11000, '1998-01-06 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 10000, '1998-01-07 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 9000, '1998-01-08 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 8000, '1998-01-09 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 7000, '1998-01-10 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 6500, '1998-01-09 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 6000, '1998-01-10 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 5500, '1998-01-02 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 5000, '1998-01-03 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 4500, '1998-01-04 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 4000, '1998-01-05 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 3800, '1998-01-06 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 3600, '1998-01-07 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 3400, '1998-01-08 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 3200, '1998-01-09 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 3000, '1998-01-10 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 2800, '1998-01-11 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 2600, '1998-01-12 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 2400, '1998-01-13 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 2200, '1998-01-14 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 2000, '1998-01-15 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 1800, '1998-01-16 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 1600, '1998-01-17 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 1400, '1998-01-18 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (1, 1200, '1998-01-19 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 15000, '2010-01-01 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 18000, '2010-01-02 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 20000, '2010-01-03 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 19000, '2010-01-04 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 17000, '2010-01-05 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 16000, '2010-01-06 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 15000, '2010-01-07 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 14000, '2010-01-08 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 13000, '2010-01-03 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 12000, '2010-01-04 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 11000, '2010-01-05 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 10000, '2010-01-06 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 9500, '2010-01-07 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 9000, '2010-01-08 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 8500, '2010-01-09 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 8000, '2010-01-10 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 7500, '2010-01-11 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 7000, '2010-01-12 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 6500, '2010-01-13 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 6000, '2010-01-14 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 5500, '2010-01-15 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 5000, '2010-01-16 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 4500, '2010-01-17 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 4000, '2010-01-18 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 3800, '2010-01-19 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 3600, '2010-01-20 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 3400, '2010-01-21 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 3200, '2010-01-22 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 3000, '2010-01-23 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (2, 2800, '2010-01-24 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 25000, '2008-06-28 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 30000, '2008-06-29 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 35000, '2008-06-30 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 32000, '2008-07-01 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 30000, '2008-07-02 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 28000, '2008-07-03 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 26000, '2008-07-04 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 24000, '2008-07-05 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 22000, '2008-07-06 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 20000, '2008-07-07 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 18000, '2008-07-08 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 16000, '2008-07-09 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 15000, '2008-07-10 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 14000, '2008-07-11 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 13000, '2008-07-12 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 12000, '2008-07-13 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 11000, '2008-07-14 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 10000, '2008-07-15 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 9000, '2008-07-16 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 8000, '2008-07-17 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 7500, '2008-07-18 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 7000, '2008-07-19 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 6500, '2008-07-20 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 6000, '2008-07-21 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 5800, '2008-07-22 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 5600, '2008-07-23 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 5400, '2008-07-24 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 5200, '2008-07-25 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 5000, '2008-07-26 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (3, 4800, '2008-07-27 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 20000, '2010-01-07 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 25000, '2010-01-08 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 30000, '2010-01-03 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 28000, '2010-01-04 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 26000, '2010-01-05 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 24000, '2010-01-06 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 22000, '2010-01-07 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 20000, '2010-01-08 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 18000, '2010-01-07 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 16000, '2010-01-08 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 15000, '2010-01-03 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 14000, '2010-01-04 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 13000, '2010-01-05 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 12000, '2010-01-06 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 11000, '2010-01-07 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 10000, '2010-01-08 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 9000, '2010-01-07 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 8000, '2010-01-08 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 7500, '2010-01-03 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 7000, '2010-01-04 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 6500, '2010-01-05 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 6000, '2010-01-06 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 5800, '2010-01-07 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 5600, '2010-01-08 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 5400, '2003-01-06 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 5200, '2003-01-07 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 5000, '2003-01-08 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 4800, '2003-01-09 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 4600, '2003-01-10 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (4, 4400, '2003-01-11 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 10000, '1995-02-05 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 15000, '1995-02-06 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 20000, '1995-02-07 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 18000, '1995-02-08 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 16000, '1995-02-09 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 14000, '1995-02-10 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 12000, '1995-02-11 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 11000, '1995-02-12 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 10000, '1995-02-13 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 9000, '1995-02-14 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 8500, '1995-02-15 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 8000, '1995-02-16 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 7500, '1995-02-17 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 7000, '1995-02-18 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 6500, '1995-02-19 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 6000, '1995-02-20 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 5800, '1995-02-21 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 5600, '1995-02-22 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 5400, '1995-02-23 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 5200, '1995-02-24 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 5000, '1995-02-25 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 4800, '1995-02-26 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 4600, '1995-02-27 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 4400, '1995-02-28 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 4200, '1995-03-01 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 4000, '1995-03-02 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 3800, '1995-03-03 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 3600, '1995-03-04 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 3400, '1995-03-05 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (5, 3200, '1995-03-06 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 35000, '2001-07-21 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 40000, '2001-07-22 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 45000, '2001-07-23 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 42000, '2001-07-24 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 40000, '2001-07-25 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 38000, '2001-07-26 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 36000, '2001-07-27 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 34000, '2001-07-28 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 32000, '2001-07-29 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 30000, '2001-07-30 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 28000, '2001-07-31 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 26000, '2001-08-01 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 24000, '2001-08-02 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 22000, '2001-08-03 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 20000, '2001-08-04 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 18000, '2001-08-05 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 16000, '2001-08-06 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 15000, '2001-08-07 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 14000, '2001-08-08 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 13000, '2001-08-09 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 12000, '2001-08-10 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 11000, '2001-08-11 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 10000, '2001-08-12 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 9500, '2001-08-13 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 9000, '2001-08-14 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 8500, '2001-08-15 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 8000, '2001-08-16 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 7500, '2001-08-17 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 7000, '2001-08-18 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (6, 6500, '2001-08-19 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 25000, '1994-09-15 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 30000, '1994-09-16 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 35000, '1994-09-17 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 32000, '1994-09-18 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 30000, '1994-09-19 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 28000, '1994-09-20 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 26000, '1994-09-21 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 24000, '1994-09-22 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 22000, '1994-09-23 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 20000, '1994-09-24 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 18000, '1994-09-25 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 16000, '1994-09-26 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 14000, '1994-09-27 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 12000, '1994-09-28 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 11000, '1994-09-29 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 10000, '1994-09-30 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 9500, '1994-10-01 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 9000, '1994-10-02 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 8500, '1994-10-03 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 8000, '1994-10-04 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 7500, '1994-10-05 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 7000, '1994-10-06 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 6800, '1994-10-07 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 6600, '1994-10-08 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 6400, '1994-10-09 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 6200, '2016-03-05 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 6000, '2016-03-06 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 5800, '2016-03-07 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 5600, '2016-03-08 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (7, 5400, '2016-03-09 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 40000, '2016-03-05 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 45000, '2016-03-06 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 50000, '2016-03-07 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 48000, '2016-03-08 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 46000, '2016-03-09 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 44000, '2016-03-10 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 42000, '2016-03-11 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 40000, '2016-03-12 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 38000, '2016-03-13 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 36000, '2016-03-14 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 34000, '2016-03-15 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 32000, '2016-03-16 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 30000, '2016-03-17 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 28000, '2016-03-18 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 26000, '2016-03-19 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 24000, '2016-03-20 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 22000, '2016-03-21 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 20000, '2016-03-22 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 18000, '2016-03-23 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 16000, '2016-03-24 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 14000, '2016-03-25 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 12000, '2016-03-26 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 11000, '2016-03-27 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 10000, '2016-03-28 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 9500, '2016-03-29 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 9000, '2016-03-30 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 8500, '2016-03-31 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 8000, '2016-04-01 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 7500, '2016-04-02 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (8, 7000, '2016-04-03 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 15000, '2010-07-27 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 18000, '2010-07-28 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 22000, '2010-07-29 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 20000, '2010-07-30 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 18000, '2010-07-31 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 16000, '2010-08-01 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 14000, '2010-08-02 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 12000, '2010-08-03 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 11000, '2010-08-04 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 10000, '2010-08-05 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 9500, '2010-08-06 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 9000, '2010-08-07 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 8500, '2010-08-08 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 8000, '2010-08-09 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 7500, '2010-08-10 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 7000, '2010-08-11 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 6800, '2010-08-12 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 6600, '2010-08-13 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 6400, '2010-08-14 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 6200, '2010-08-15 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 6000, '2010-08-16 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 5800, '2010-08-17 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 5600, '2010-08-18 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 5400, '2010-08-19 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 5200, '2010-08-20 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 5000, '2010-08-21 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 4800, '2010-08-22 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 4600, '2010-08-23 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 4400, '2010-08-24 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (9, 4200, '2010-08-25 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 40000, '2008-07-15 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 45000, '2008-07-16 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 50000, '2008-07-17 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 48000, '2008-07-18 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 46000, '2008-07-19 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 44000, '2008-07-20 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 42000, '2008-07-21 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 40000, '2008-07-22 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 38000, '2008-07-23 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 36000, '2008-07-24 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 34000, '2008-07-25 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 32000, '2008-07-26 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 30000, '2008-07-27 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 28000, '2008-07-28 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 26000, '2008-07-29 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 24000, '2008-07-30 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 22000, '2008-07-31 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 20000, '2008-08-01 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 18000, '2008-08-02 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 16000, '2008-08-03 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 14000, '2008-08-04 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 12000, '2008-08-05 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 11000, '2008-08-06 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 10000, '2008-08-07 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 9500, '2008-08-08 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 9000, '2008-08-09 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 8500, '2008-08-10 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 8000, '2008-08-11 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 7500, '2008-08-12 00:00:00');
INSERT INTO movie_playback (movie_id, play_one_day, play_date)
VALUES (10, 7000, '2008-08-13 00:00:00');
