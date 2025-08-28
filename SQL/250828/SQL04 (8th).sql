# 문제1. sakila DB의 “영화 대여 내역”을 바탕으로 다음 항목을 모두 출력하는 SQL 쿼리문을 작성해주세요.
# 고객별 대여 순위, 이전 대여와의 간격, 다음 대여와의 간격,
# 고객별 첫 번째 및 마지막 대여 일자, 고객별 대여 건의 백분위 순위 및 누적분포, 
# 고객별 대여 내역의 3개 그룹 분할, 분할된 그룹 내 대여날짜 기준 오름차순 정렬
# 위 항목들을 customer_id, rental_date와 함께 “모두 포함하여 출력”하는 SQL 쿼리를 작성해주세요.

WITH customer_rental AS(
SELECT
	customer_id, rental_date,
	LAG(rental_date, 1, 0) OVER(PARTITION BY customer_id ORDER BY rental_date) before_rental_date, 
	LEAD(rental_date, 1, 0) OVER(PARTITION BY customer_id ORDER BY rental_date) after_rental_date
FROM rental
)
SELECT 
	customer_id, rental_date,
	RANK() OVER (PARTITION BY customer_id ORDER BY rental_date) customer_rank,
	TIMESTAMPDIFF(DAY, before_rental_date, rental_date) gap_before,
    TIMESTAMPDIFF(DAY, rental_date, after_rental_date ) gap_after,
    FIRST_VALUE(rental_date) OVER(PARTITION BY customer_id ORDER BY rental_date) first_rental_date,
	LAST_VALUE(rental_date) OVER(PARTITION BY customer_id ORDER BY rental_date
								ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                                ) last_rental_date,
    PERCENT_RANK() OVER(PARTITION BY customer_id ORDER BY rental_date) percentile_rank,
    CUME_DIST() OVER(PARTITION BY customer_id ORDER BY rental_date) cumulative_distribution,
    NTILE(3) OVER (PARTITION BY customer_id ORDER BY rental_date ASC) rental_group
FROM customer_rental;

