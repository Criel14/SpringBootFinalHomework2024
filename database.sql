DROP DATABASE springboot_final;
CREATE DATABASE springboot_final;
USE springboot_final;

-- 创建用户表
CREATE TABLE user (
    userId INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    phoneNumber VARCHAR(15) NOT NULL ,
    image VARCHAR(200) NOT NULL,
    isVip TINYINT NOT NULL DEFAULT 0
);

-- 创建电影表
CREATE TABLE movie (
    movieId INT AUTO_INCREMENT PRIMARY KEY,
    movieTitle VARCHAR(100) NOT NULL,
    movieCoverUrl VARCHAR(100) NOT NULL,
    movieDescription TEXT,
    releaseDate DATE,
    needVip TINYINT NOT NULL DEFAULT 0,
    movieLocalUrl VARCHAR(200),
    movieRegion VARCHAR(50),
    movieType VARCHAR(50),
    movieScore DECIMAL(3,2)
);

-- 创建主创人员表
CREATE TABLE staff (
    staffId INT AUTO_INCREMENT PRIMARY KEY,
    movieId INT NOT NULL,
    staffName VARCHAR(50) NOT NULL,
    staffRole TINYINT NOT NULL,
    FOREIGN KEY (movieId) REFERENCES movie(movieId)
);

-- 创建电影播放表
CREATE TABLE moviePlayback (
    movieId INT NOT NULL,
    playOneDay INT NOT NULL DEFAULT 0,
    playDate DATE,
    PRIMARY KEY (movieId),
    FOREIGN KEY (movieId) REFERENCES movie(movieId)
);

-- 创建个人播放历史表
CREATE TABLE userPlaybackHistory (
    userId INT NOT NULL,
    movieId INT NOT NULL,
    viewingTimestamp DATETIME NOT NULL,
    PRIMARY KEY (userId, movieId),
    FOREIGN KEY (userId) REFERENCES user(userId),
    FOREIGN KEY (movieId) REFERENCES movie(movieId)
);

