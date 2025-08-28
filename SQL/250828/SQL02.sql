# customer 테이블과 payment테이블을 사용해서 각 도시별 고객의 총 결제 금액 순위를 출력!
# 고객 id, 도시 총 결제 금액, 도시 순위
SELECT * FROM customer; # customer_id, address_id
SELECT * FROM payment; # customer_id
SELECT * FROM city; #city_id
SELECT * FROM address; #city_id, address_id
SELECT
	C.customer_id, CI.city,
    SUM(P.amount) total_amount,
    RANK() OVER (PARTITION BY CI.city ORDER BY SUM(P.amount)DESC) city_rank
FROM customer C
JOIN payment P USING (customer_id)
JOIN address A USING (address_id)
JOIN city CI USING (city_id)
GROUP BY C.customer_id;
#---------------------------
# customer 테이블에서 고객별 대여 횟수에 따라 4개의 그룹으로 나눠주세요.
# 고객 id, 대여횟수, 그룹 -> 출력 될 수 있도록 해주세요

SELECT
	C.customer_id, 
    COUNT(*) rental_count,
	NTILE(4) OVER(ORDER BY COUNT(*)DESC) rental_group
FROM customer C
JOIN rental R USING(customer_id)
GROUP BY C.customer_id;
#---------------------------
# film 테이블에서 영화를 대여기간에 따라서 5개의 그룹으로 나누어주세요.
# 영화 ID, 대여기간, 그룹 -> 

SELECT
	film_id, rental_duration,
    NTILE(5) OVER(ORDER BY rental_duration) rental_group
FROM film F;
#---------------------------
# payment 테이블에 각 고객별로 지불 내역에 행 번호를 부여해주세요.
# 고객별 지불 내역의 행 번호는 payment_date가 낮은 순으로 부여해주세요.
# 지불id, 고객id, 지불날짜, 지불 금액, 행 번호  

SELECT
	payment_id, customer_id, payment_date, amount,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY payment_date) ranking
FROM payment P
ORDER BY payment_date ASC;
#---------------------------
# film 테이블에서 각 등급별로 영화에 행 번호를 부여하세요
# 영화는 대여기간에 따라 정렬될 수 있도록 해주세요
# 영화id, 등급, 대여기간, 행 번호

SELECT
	film_id, rating, rental_duration,
    ROW_NUMBER () OVER (PARTITION BY rating ORDER BY rental_duration) row_numbers
FROM film;
#---------------------------
# customer 테이블과 payment 테이블을 사용해서 고객을 총 결제금액에 따라 10개의 그룹으로 나누고
# 각 그룹내에서 고객별 총 결제 금액에 따라 번호를 부여하세요.
# 고객 id, 총 결제금액, 그룹, 그룹 내 행 번호

WITH CustomerPayment AS( 
	SELECT 
		customer_id, SUM(amount) total_amount
	FROM customer C
	JOIN payment P USING (customer_id)
	GROUP BY customer_id
),
CustomerGroup AS (
SELECT 
	customer_id, total_amount,
    NTILE (10) OVER (ORDER BY total_amount) ten
    FROM CustomerPayment
)
SELECT
	customer_id, total_amount, ten,
    ROW_NUMBER () OVER(PARTITION BY ten ORDER BY total_amount) row_numbers
FROM CustomerGroup;