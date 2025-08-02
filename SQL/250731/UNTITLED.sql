/*
# 현재 이 공간을 통해서 SQL 언어를 작성할 예정!!!
# 해당 공간에 한 줄씩 코드를 작성 -> 쿼리(문)
# 하나의 쿼리가 종료되었다는 것을 정의 -> ;
*/

# 1. DB생성 : CREATE DATABASE dbname
# 2. DB목록확인 : SHOW DATABASES
# 3. DB접속 : USE dbname
# 4. Table생성 : create TABLE mytable
# 5. Data삽입 : (id INT, name VARCHAR(50), PRIMARY);
# 6. DB삭제 :DROP DATABASE IF EXISTS dbname // DROP DATABASE 있으면 삭제, 없으면 말하지마~ 조건 방지용

/*
create TABLE mytable (
	id INT, name VARCHAR(50), PRIMARY 숫자, 문자
);
*/

-- CREATE DATABASE david;
-- USE david;
-- CREATE TABLE mytable(
-- 	id TINYINT Unsigned,
--     name VARCHAR(50),
--     primary key(id)
-- );

-- CREATE TABLE mytable(
-- 	id float Unsigned,
--     name VARCHAR(50),
--     primary key(id)
-- );

-- CREATE TABLE mytable(
-- 	id INT NOT NULL auto_increment, # 필수 조건 값을 넣어라, 자동으로 증가하는 값
--     name VARCHAR(50),
--     primary key(id)
-- );

-- CREATE TABLE mytable(
-- 	id INT NOT NULL auto_increment, # 필수 조건 값을 넣어라, 자동으로 증가하는 값
--     name CHAR(50), # 50개의 문자열이 들어올 수 있는 공간을 항상 준비, 안들어와도 가능
--     city varchar(50), # 최대 50개까지 입력 -> 5개 
--     primary key(id)
-- );

-- CREATE TABLE mytable(
-- 	id INT NOT NULL auto_increment, # 필수 조건 값을 넣어라, 자동으로 증가하는 값
-- 	name VARCHAR(50), # 50개의 문자열이 들어올 수 있는 공간을 항상 준비, 안들어와도 가능
-- 	primary key(id, name) # 하나의 레코드 안에 프라이머리 키 복수 가능
-- );

CREATE TABLE mytable(
	id INT NOT NULL auto_increment, 
	name VARCHAR(50) NOT NULL,
    modelnumber varchar(15) NOT NULL,
    SERIES VARCHAR(30) NOT NULL,
	primary key(id)
);