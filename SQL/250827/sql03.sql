SELECT
	customer_id,
    rental_date,
    COUNT(*) OVER (PARTITION BY customer_id ORDER BY rental_date) count
    # customer_id을 기준으로 부분집합을 만들겠다.
    # rental_date을 정렬..?
FROM rental;

# 고객별 대여날짜 누적 대여 횟수 계산
SELECT
	customer_id,
	rental_date,
    COUNT(*) OVER (PARTITION BY customer_id ORDER BY rental_date
					ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) counts
FROM rental;
# 파티션을 통해서 부분집합을 만들었는데, 그 부분집합을 통해서 개수를 했다.
# 첫번째 행부터 하나씩 읽어내려간다. 순회하면서 읽고있다..ㅋ?

SELECT
	customer_id,
	rental_date,
    COUNT(*) OVER (PARTITION BY customer_id ORDER BY rental_date
					ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) counts
FROM rental;

SELECT
	customer_id,
	rental_date,
    COUNT(*) OVER (PARTITION BY customer_id ORDER BY rental_date
					ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) counts
FROM rental;

SELECT
	R.customer_id,
	R.rental_date,
	P.amount,
    DATE(R.rental_date),
    SUM(P.amount) OVER (PARTITION BY R.customer_id ORDER BY rental_date
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) sample
FROM payment P
JOIN rental R USING (rental_id);

SELECT
	R.customer_id,
	R.rental_date,
	P.amount,
    DATE(R.rental_date),
    SUM(P.amount) OVER (PARTITION BY R.customer_id ORDER BY DATE(rental_date)
						RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) sample
FROM payment P
JOIN rental R USING (rental_id);
#RANGE 하나의 그룹으로 값 계산?



#누적평균
SELECT
	R.customer_id,
	R.rental_date,
	P.amount,
    AVG(P.amount) OVER (PARTITION BY R.customer_id ORDER BY rental_date
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) sample
FROM payment P
JOIN rental R USING (rental_id);

SELECT 
	I.film_id,
	P.amount,
    P.payment_date,
    SUM(P.amount) OVER (PARTITION BY film_id ORDER BY 
				P.payment_date ROWS BETWEEN UNBOUNDED PRECEDING AND
                CURRENT ROW) revenue
FROM payment P
JOIN rental R USING (rental_id)
JOIN inventory I USING (inventory_id);


# 장르별 영화 대여 수익
# 영화 장르의 수익성 분석이 필요합니다!
# 영화 장르별 대여 수익의 누적합계와 전체 대여 수익 대비 비율을 출력해주세요.

WITH genre_revenue as (
	SELECT
		C.name genre,
		SUM(P.amount) revenue
	FROM rental R
	JOIN payment P USING(rental_id)
	JOIN inventory I USING(inventory_id)
	JOIN film_category FC USING(film_id)
	JOIN category C USING(category_id)
	GROUP BY C.name
)
SELECT
	genre,
    revenue,
    SUM(revenue) OVER (ORDER BY revenue DESC
					ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) revenue2,
	revenue / SUM(revenue) OVER	() revenue_ratio
FROM genre_revenue;
# PARTITION BY revenue 누적합계를 원할시, 생략하세요! SUM(revenue) OVER이것 자체를 기준으로 한다.


SELECT
	rental_id,
    rental_date,
    LAG(rental_id, 1, 0) OVER (ORDER BY rental_date) prev_rental,
    LEAD(rental_id, 1, 0) OVER (ORDER BY rental_date) next_rental
FROM rental;

SELECT 
	I.film_id,
    R.rental_date,
    FIRST_VALUE(R.rental_date) OVER (PARTITION BY I.film_id ORDER BY R.rental_date),
	LAST_VALUE(R.rental_date) OVER (PARTITION BY I.film_id ORDER BY R.rental_date
									ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) 
FROM rental R
JOIN inventory I USING(inventory_id);

SELECT 
	I.film_id,
    R.rental_date,
    FIRST_VALUE(R.rental_date) OVER (PARTITION BY I.film_id ORDER BY R.rental_date),
	LAST_VALUE(R.rental_date) OVER (PARTITION BY I.film_id ORDER BY R.rental_date) 
FROM rental R
JOIN inventory I USING(inventory_id);

