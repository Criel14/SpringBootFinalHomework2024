DROP DATABASE springboot_final;
CREATE DATABASE springboot_final;
USE springboot_final;

-- 创建用户表
CREATE TABLE user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) NOT NULL ,
    image VARCHAR(200)  DEFAULT null,
    is_vip TINYINT NOT NULL DEFAULT 0
);

-- 创建电影表
CREATE TABLE movie (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    movie_title VARCHAR(100) NOT NULL,
    movie_cover_url VARCHAR(100) NOT NULL,
    movie_description TEXT,
    release_date DATE,
    need_vip TINYINT NOT NULL DEFAULT 0,
    movie_local_url VARCHAR(200),
    movie_region VARCHAR(50),
    movie_type VARCHAR(50),
    movie_score DECIMAL(3,2)
);

-- 创建主创人员表
CREATE TABLE staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT NOT NULL,
    staff_name VARCHAR(50) NOT NULL,
    staff_role TINYINT NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
);

-- 创建电影播放表
CREATE TABLE movie_playback (
    movie_id INT NOT NULL,
    play_one_day INT NOT NULL DEFAULT 0,
    play_date DATE,
    PRIMARY KEY (movie_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
);

-- 创建个人播放历史表
CREATE TABLE user_playback_history (
    user_id INT NOT NULL,
    movie_id INT NOT NULL,
    viewing_timestamp DATETIME NOT NULL,
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
);

insert into user(username,phone_number,password) VALUES('aa','123456','123456');

INSERT INTO movie (movie_title, movie_cover_url, movie_description, release_date, need_vip, movie_local_url, movie_region, movie_type, movie_score)
VALUES
('肖申克的救赎', 'cover000.jpg', '一部关于希望、坚韧和友谊的励志经典电影。', '1994-10-14', 0, NULL, '美国', '剧情', 9.30),
('教父', 'cover000.jpg', '讲述了科里昂家族的犯罪帝国及其家族纷争的经典黑帮电影。', '1972-03-24', 0, NULL, '美国', '动作', 9.20),
('霸王别姬', 'cover000.jpg', '一部展现京剧传统艺术和同性爱情主题的经典国产电影。', '1993-01-01', 1, 'https://example.com/farewell-my-concubine.mp4', '中国', '剧情', 9.50),
('哈利·波特与魔法石', 'cover000.jpg', '改编自J.K.罗琳小说的奇幻冒险系列电影的第一部。', '2001-11-16', 0, NULL, '英国,美国', 'action', 7.60),
('疯狂动物城', 'cover000.jpg', '一部充满想象力和富有教育意义的动画电影,探讨了种族歧视和平等机会等重要议题。', '2016-03-04', 0, NULL, '美国', '动画', 8.10),
('我不是药神', 'cover000.jpg', '一部根据真实事件改编的国产电影,讲述了一个普通男人为了活下去而走上买卖仿制药的道路。', '2018-07-05', 0, 'https://example.com/dying-to-survive.mp4', '中国', '喜剧', 8.70);
