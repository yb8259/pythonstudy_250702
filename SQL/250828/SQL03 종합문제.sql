USE sakila;
# 1. 각 고객별 결제 금액에 따른 순위를 출력해주세요.
# 고객 ID, rental_id, 고객의 결제 금액에 따른 순위
# 순위를 출력할 때, 동일한 값이 있을 경우, 순위를 부여하고, 다음순위는 건거뛰지않습니다. DENSE_RANK()

SELECT
	customer_id, rental_id,
    amount,
    DENSE_RANK() OVER 
		(PARTITION BY customer_id ORDER BY amount DESC) amount_rank
FROM payment;
#---------------------------
# 2. 고객별 대여날짜 시간 순(*오름차순)으로 정렬 후 아래 내용을 출력하셈
# 출력 내용 : 고객ID, 렌탈ID, 대여날짜 시간, 
# 해당 대여날짜 시간을 기준으로 다음 대여날짜 시간 LEAD()

SELECT
	customer_id, rental_id, rental_date,
    LEAD(rental_date) OVER (PARTITION BY customer_id ORDER BY rental_date) next_rental_date
FROM rental;
#---------------------------
# 3. 각 등급별로 대여기간이 가장 긴 영화 제목을 출력하세요.
SELECT
	DISTINCT rating,
    FIRST_VALUE(title) OVER
		(PARTITION BY rating ORDER BY rental_duration DESC) 
        logest_rental_movie
FROM film;
#---------------------------
# 4. 각 고객을 활동 상태가 높은 순으로 정렬하고, 이를 기준으로 3개의 그룹으로 나누세요.
# 그룹 내 고객의 순서를 customer_id가 낮은 순으로 정렬해주세요.
# 정렬후 행 번호를 매겨주세요.
# customer_id, first_name, last_name, active, active_group

WITH a AS (
SELECT
	customer_id,
    first_name, last_name, active
FROM customer
ORDER BY active DESC
),
active_group as(
	SELECT
		customer_id,
		first_name, last_name, active,
		NTILE(3) OVER () three
FROM a
)

SELECT
	customer_id,
	first_name, last_name, active,
    ROW_NUMBER () OVER(ORDER BY active)
FROM active_group
ORDER BY customer_id DESC;