USE sakila;
SHOW TABLES;
DESC actor;
SELECT * FROM actor LIMIT 1;

# 각 고객이 어떤 영화 카테고리를 가장 자주 대여하는지 알고싶습니다.
# 각 고객별로 가장 많이 대여한 영화 카테고리와 해당 카테고리에서의 
# 총 대여 횟수, 해당 고객 이름을 조회 할 수 있는 SQL 쿼리문을 작성해주세요!!!

# A고객 : 액션, 드라마, 패밀리
# A - 액션 : 2
# A - 드라마 : 1
# A - 패밀리 : 3

# A - 액션 / 드라마 / 패밀리 중 가장 렌탈한 횟수가 많은 카테고리를 1번더 필터링
SELECT * FROM category; #category_id, name
SELECT * FROM customer; #customer_id, store_id, first_name,last_name
SELECT * FROM film_category; # film_id, category_id
SELECT * FROM rental; # customer_id, rental_id, inventory_id
SELECT * FROM film;
SELECT * FROM inventory; #inventory_id, film_id, store_id

SELECT 
	CONCAT(CU.first_name," ",CU.last_name) Name,
    CA.name Category,
    COUNT(*) rental_count
FROM
customer CU
JOIN rental R USING (customer_id)
JOIN inventory I USING (inventory_id)
JOIN film_category FC USING (film_id)
JOIN category CA USING (category_id)
GROUP BY CU.customer_id, category_id
HAVING COUNT(*) = ( # 그 가운데서 가장 큰 값!
	SELECT COUNT(*) FROM rental R2
	JOIN inventory I2 USING (inventory_id)
    JOIN film_category FC2 USING (film_id)
    WHERE R2.customer_id = CU.customer_id # 고객을 기준
    GROUP BY FC2.category_id # 카테고리를 기준
    ORDER BY COUNT(*) DESC # 내림차순
    LIMIT 1 # 중에 첫번째 -> 제일 큰 값!
);
#---------------------------
# 2006-02-14 날짜를 기준으로, 2006-01-15부터, 2006-02-14날짜까지 영화를
# 대여하지 않은 고객을 찾아주세요.

SELECT * FROM customer_id; #customer_id
SELECT * FROM rental; #customer_id, rental_id

SELECT
CONCAT(C.first_name, " ", C.last_name) Name,
rental_date
FROM customer C
LEFT OUTER JOIN rental R ON R.customer_id = C.customer_id
AND TIMESTAMPDIFF(DAY, R.rental_date, "2006-02-14") <= 30
WHERE R.rental_id IS NULL;
#---------------------------

# 가장 최근의 영화를 반납한 상위 10명의 고객 이름과
# 해당 고객들이 대여한 영화의 이름 그리고 대여 기간을 출력해주세요.
SELECT * FROM customer; #customer_id, name
SELECT * FROM film; # title, film_id
SELECT * FROM rental; # inventory_id, rental_date, customer_id
SELECT * FROM inventory; # inventory_id, film_id

SELECT 
CONCAT(C.first_name, " ", C.last_name) Name,
F.title,
R.return_date,
TIMESTAMPDIFF(DAY, R.rental_date, R.return_date) rental_days
FROM customer C
JOIN rental R USING (customer_id)
JOIN inventory I USING (inventory_id)
JOIN film F USING (film_id) 
ORDER BY return_date DESC
LIMIT 10;
#---------------------------

# 각 직원의 매출을 찾고, 각 직원의 매출이 회사 전체 매출 중 어느 정도 비율을
# 차지하는지 출력해주세요. 출력결과물은 직원id, 직원이름, 직원 매출, 비율
# 회사 전체 매출 기준 직원 매출의 비율 까지 출력!

SELECT * FROM staff; # staff_id, name
SELECT * FROM payment; # amount, staff_id, payment_id

SELECT 
	S.staff_id, 
	CONCAT(S.first_name, " ", S.last_name) Name,
	SUM(P.AMOUNT) staff_revenue,
	(SUM(P.AMOUNT) / (SELECT SUM(AMOUNT) FROM payment) * 100) revenue_percentage
FROM staff S
JOIN payment P USING (staff_id)
GROUP BY S.staff_id;
#---------------------------

