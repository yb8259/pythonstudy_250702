CREATE DATABASE IF NOT EXISTS interpark;
SHOW DATABASES;
USE interpark;
CREATE TABLE IF NOT EXISTS performances (
	id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    date_range VARCHAR(100),
    place VARCHAR(100)
);
DESC performances;
SELECT * FROM performances;  