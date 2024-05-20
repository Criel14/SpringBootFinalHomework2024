DROP DATABASE springboot_final;
CREATE DATABASE springboot_final;
USE finalExam;

-- 创建用户表
CREATE TABLE user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    is_vip TINYINT NOT NULL DEFAULT 0
);

-- 创建电影表
CREATE TABLE movie (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    movie_title VARCHAR(100) NOT NULL,
    movie_description TEXT,
    release_date DATE,
    need_vip TINYINT NOT NULL DEFAULT 0,
    movie_link VARCHAR(200),
    movie_region VARCHAR(50),
    movie_genre VARCHAR(50),
    movie_ratings DECIMAL(3,2)
);

-- 创建主创人员表
CREATE TABLE person (
    person_id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT NOT NULL,
    person_name VARCHAR(50) NOT NULL,
    person_role TINYINT NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
);

-- 创建电影播放表
CREATE TABLE movie_playback (
    movie_id INT NOT NULL,
    playback_all INT NOT NULL DEFAULT 0,
    playback_byWeek INT NOT NULL DEFAULT 0,
    playback_byMonth INT NOT NULL DEFAULT 0,
    PRIMARY KEY (movie_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
);

-- 创建个人播放历史表
CREATE TABLE user_playback_history (
    user_id INT NOT NULL,
    movie_id INT NOT NULL,
    watch_time DATETIME NOT NULL,
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
);



-- 插入数据
-- 插入10条电影数据
INSERT INTO movie (movie_title, movie_description, release_date, need_vip, movie_link, movie_region, movie_genre, movie_ratings) VALUES
('The Shawshank Redemption', '两个因谋杀罪而入狱的男子当了二十几年的狱友,扮演人物由摩根freeman和tim robbins分别主演。', '1994-10-14', 0, 'https://www.imdb.com/title/tt0111161/', '美国', '剧情', 9.3),
('The Godfather', '马龙白兰度执导的黑帮电影,通过宗家的兴衰描写了一个原本很像梦的家族如何逐渐沦为黑帮的命运。', '1972-03-24', 0, 'https://www.imdb.com/title/tt0068646/', '美国', '剧情/犯罪', 9.2),
('The Dark Knight', '蝙蝠侠需要对抗小丑的恐怖行为,同时也要维护哥谭市的和平。', '2008-07-18', 0, 'https://www.imdb.com/title/tt0468569/', '美国', '动作/犯罪', 9.0),
('Pulp Fiction', '昆汀·塔伦蒂诺执导的绚丽多线叙事犯罪电影。', '1994-10-14', 0, 'https://www.imdb.com/title/tt0110912/', '美国', '犯罪/剧情', 8.9),
('Inception', '有关"共享梦境"技术的科幻电影,由莱昂纳多·迪卡普里奥主演。', '2010-07-16', 0, 'https://www.imdb.com/title/tt1375666/', '美国/英国', '科幻/悬疑', 8.8),
('Fight Club', '一部探讨现代社会病态及人性中暴力面的影片。', '1999-10-15', 1, 'https://www.imdb.com/title/tt0137523/', '美国/德国', '剧情', 8.8),
('Forrest Gump', '一个天生智力较低但心地纯良的男子经历了二战、越战等重大历史事件。', '1994-07-06', 0, 'https://www.imdb.com/title/tt0109830/', '美国', '剧情/喜剧', 8.8),
('Goodfellas', '马丁·斯科塞斯执导的黑帮电影,描述了一个小混混如何被纽约黑手党所吸引。', '1990-09-19', 1, 'https://www.imdb.com/title/tt0099685/', '美国', '传记/犯罪', 8.7),
('The Matrix', '人工智能战胜人类后,利用仿真构筑了另一个虚拟世界,人类正生存在这个世界里。', '1999-03-31', 0, 'https://www.imdb.com/title/tt0133093/', '美国', '科幻/动作', 8.7),
('The Lord of the Rings: The Return of the King', '《指环王》三部曲的最后一部,弗罗多一行人要完成最后的任务。', '2003-12-17', 0, 'https://www.imdb.com/title/tt0167260/', '美国/新西兰', '奇幻/冒险', 8.9);

-- 插入10条主创人员数据
INSERT INTO person (movie_id, person_name, person_role) VALUES
(1, 'Tim Robbins', 0),
(1, 'Morgan Freeman', 0),
(2, 'Marlon Brando', 0),
(2, 'Al Pacino', 0),
(2, 'Francis Ford Coppola', 1),
(3, 'Christian Bale', 0),
(3, 'Heath Ledger', 0),
(3, 'Christopher Nolan', 1),
(4, 'John Travolta', 0),
(4, 'Samuel L. Jackson', 0);

-- 插入10条电影播放数据
INSERT INTO movie_playback (movie_id, playback_all, playback_byWeek, playback_byMonth) VALUES
(1, 28460512, 12543, 87621),
(2, 25061401, 8732, 62487),
(3, 27904051, 19287, 134563),
(4, 21356937, 6421, 51265),
(5, 29654821, 24187, 165324),
(6, 16025503, 3287, 28965),
(7, 24450901, 11876, 85432),
(8, 18501119, 5619, 41265),
(9, 25368856, 16543, 112876),
(10, 30237890, 28965, 201543);