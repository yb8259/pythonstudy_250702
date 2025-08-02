CREATE DATABASE IF NOT EXISTS membership;
USE membership;  
SHOW DATABASES;
CREATE TABLE membership_db (
	count_no TINYINT NOT NULL, #auto_increment primary key 
    name CHAR(20) NOT NULL, 
    email CHAR(20)NOT NULL, #중복되는 값 빼기, UNIQUE
    birth CHAR(20)NOT NULL, #DATE타입, '0000-00-00'이렇게 생겼어요
    account CHAR(20) NOT NULL, #DATATIME 'YYYY-MM-DD HH:MM:SS'
    point TINYINT NOT NULL, 
    sex CHAR(10) NOT NULL,
    PRIMARY KEY (count_no)
);
DESC membership_db;
SELECT * FROM membership_db;

ALTER TABLE membership_db MODIFY COLUMN point INT NOT NULL;
INSERT INTO membership_db VALUES 
(1,"김나무","tree123@google.com","1999년 5월 5일","2025년 07월 30일",1, "F"),
(2,"이나비","fly123@google.com","1995년 4월 15일","2025년 06월 18일",1, "M"),
(3,"김꽃","flower123@naver.com","1993년 6월 7일","2025년 11월 24일",11, "F");

UPDATE membership_db SET point = 966 WHERE count_no = 1;
UPDATE membership_db SET point = 1666 WHERE count_no = 2;
UPDATE membership_db SET point = 1255 WHERE count_no = 3;

SELECT * FROM membership_db WHERE point > 1000;
SELECT * FROM membership_db WHERE email LIKE "%@google.com";

DROP TABLE membership_db;

CREATE TABLE IF NOT EXISTS members (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL, 
    email VARCHAR(100) UNIQUE, #중복되는 값 빼기, UNIQUE
    birth_date DATE, #DATE타입, '0000-00-00'이렇게 생겼어요
    signup_time DATETIME DEFAULT CURRENT_TIMESTAMP, #DATATIME 'YYYY-MM-DD HH:MM:SS'
    points DECIMAL(10, 2),#10진수 DECIMAL(정수부, 소수부)
    gender ENUM('남','여') NOT NULL #ENUM()
);

DESC members;
INSERT INTO members (name, email, birth_data, points, gender)
VALUES 
('마동석','dong@google.com','1980-05-05',1000.50,'남'),
('장첸','jang@naver.com','1982-07-29',3500.75,'남'),
('정마담','jung@google.com','1998-11-24',120.10,'여');

SELECT * FROM members;

SELECT name, points FROM members 
WHERE points >= 1000;

SELECT name, email FROM members 
WHERE email LIKE '%@google.com';

SELECT name, birth_data FROM members
ORDER BY birth_data ASC; # ASC : 오름차순, DESC : 내림차순