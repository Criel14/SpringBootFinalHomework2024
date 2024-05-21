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
    FOREIGN KEY (user_id) REFERENCES user(userid),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
);

insert into user(username,phone_number,password) VALUES('aa','123456','123456');
