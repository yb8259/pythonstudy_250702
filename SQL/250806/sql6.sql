CREATE DATABASE IF NOT EXISTS sqlDB;
USE sqlDB;
CREATE TABLE IF NOT EXISTS userTbl(
	userID CHAR(8) NOT NULL PRIMARY KEY,
    name VARCHAR(10) UNIQUE NOT NULL,
    birthYear INT NOT NULL,
    addr CHAR(2) NOT NULL,
    mobile1 CHAR(3),
    mobile2 CHAR(8),
    height SMALLINT,
    mDate DATE
);

CREATE TABLE IF NOT EXISTS buyTbl(
	num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    userID CHAR(8) NOT NULL,
    prodName CHAR(4),
    groupName CHAR(4),
    price INT NOT NULL,
    amount SMALLINT NOT NULL,
    FOREIGN KEY (userID) REFERENCES userTbl(userID)
);

INSERT INTO userTbl (userID, name, birthYear, addr, mobile1, mobile2, height, mDate)
VALUES ("DAVID", "박세진",2000, "서울", "010", "12345678", 182, '2000-01-01');

INSERT INTO buyTbl (userID, prodName, groupName, price, amount)
VALUES ("DAVID", "에어조던","패션잡화", 30, 2);

SELECT * FROM userTbl;
DELETE FROM userTbl WHERE userID = "DAVID";