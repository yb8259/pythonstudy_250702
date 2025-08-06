SHOW TABLES;
SELECT COUNT(*) FROM film;
SELECT * FROM film
LIMIT 10;

SELECT DISTINCT rating FROM film; #아마도 분류확인 하는 것 같음

# film 테이블에 존재하는 영화 연도를 출력해주세요
SELECT DISTINCT release_year FROM film;

SELECT * FROM rental
LIMIT 10;

#렌털 테이블에서 인벤토리 아이디값이 367인 값만 출력한다면?
SELECT * FROM rental WHERE inventory_id = 367;

# 고객관련 데이터를 찾아보고 싶다
SELECT COUNT(*) FROM customer;
SELECT * FROM customer LIMIT 5;

SELECT COUNT(*) FROM payment;
SELECT * FROM payment
LIMIT 5;

SELECT 
	SUM(amount), AVG(amount),
    MAX(amount), MIN(amount)
FROM payment;

# rental 테이블에서 inventory_id가 367이고, staff_id 가 1인 값을 찾아오세요.
SELECT COUNT(*) FROM rental;
SELECT * FROM rental 
WHERE inventory_id = 367 and staff_id = 1;