# neflic 데이터 베이스 만들기
# 넥플릭스 안에 table 만들기
# 만든 후 컬럼 넣기
CREATE DATABASE Netflix;
USE Netflix;
CREATE TABLE IF NOT EXISTS users(
	user_id int primary key,
    user_name VARCHAR(50)
);
DESC users;
INSERT INTO users (user_id,user_name) 
VALUES (1,"Alice"), (2,"David"),(3,"Cathy");

SELECT * FROM users;
CREATE TABLE watch_history(
	watch_id INT PRIMARY KEY,
    user_id INT,
    date_time DATE,
    hours_watched DECIMAL(4,1),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
# 테이블 내에 PRIMARY KEY, 테이블 외의 FOREIGN KEY, -> 참고할거 FOREIGN KEY (user_id) REFERENCES 참고 하려는 대상 users(user_id)
DESC watch_history;

INSERT INTO watch_history  (watch_id, user_id, date_time, hours_watched)
VALUES 
(101, 1,"2025-07-10", 5.5),
(102, 1,"2025-07-15", 3.0),
(103, 2,"2025-07-20", 7.0),
(104, 3,"2025-07-30", 2.5),
(105, 2,"2025-07-05", 4.0),
(106, 3,"2025-07-12", 6.5),
(107, 1,"2025-06-25", 1.0),
(108, 2,"2025-07-30", 2.0);
SELECT * FROM watch_history;

# 특정 사용자의 영상 시청시간 기준, 내림차순

# AS 생략 가능
SELECT u.user_id, u.user_name, SUM(w.hours_watched) AS total_hours
FROM users AS u
JOIN watch_history AS w 
ON u.user_id = w.user_id
WHERE w.date_time >= CURDATE()-INTERVAL 1 MONTH
GROUP BY u.user_id, u.user_name
ORDER BY total_hours DESC; #현재시점 기점으로 한달전