-- CREATE DATABASE customer_db
USE customer_db;

CREATE TABLE customer(
	No INT NOT NULL auto_increment,
	Name char(20) NOT NULL,
    Age tinyint,
    Phone varchar(20),
    Email VARCHAR(30) NOT NULL,
    Address varchar(50),
    PRIMARY KEY(No)
);

-- DROP TABLE IF EXISTS customer; 

-- SHOW TABLES; 특정 테이블 안에 생성된 구조 확인하기
-- DESC customer ; #특정 테이블 안에 생성된 구조 확인하기

# 특정 테이블 내 속성 추가하기
-- ALTER TABLE customer ADD COLUMN Color VARCHAR(12);
-- DESC customer;
# 특정 테이블 내 속성타입 변경하기
-- ALTER TABLE customer MODIFY COLUMN Color VARCHAR(20) NOT NULL;
-- DESC customer;
# 특정 테이블 내 속성명 & 속성타입 변경하기
-- ALTER TABLE customer CHANGE COLUMN Phone Mobile VARCHAR(20) NOT NULL;
-- DESC customer;;

# 특정 테이블 내 속성 삭제하기
ALTER TABLE customer DROP column Color;
DESC customer;