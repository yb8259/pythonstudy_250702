# 영화 길이에 대한 백분위 순위와 누적분포 계산
# 백분위 순위 : 전체를 100% -> 0 ~ 1 => PERCENT_RANK() 주어진 행의 퍼센트 순위를 계산 = (rank - 1) /(전체 행 수 -1)
# 누적분포 : 전체를 기준으로 각 그룹의 비율이 몇 프로대 까지인지를 누적해서 보는 것 => CUME_DIST()

SELECT
	title, length,
    PERCENT_RANK() OVER(ORDER BY length) percent, # 백분위 순위를 legnth를 기준으로 출력
    CUME_DIST() OVER(ORDER BY length) cume # 누적분포를 legnth를 기준으로 출력
FROM film;
#---------------------------
SELECT
	customer_id,
	CONCAT(first_name, " ", last_name) customer_name,
    NTILE(4) OVER(ORDER BY customer_id) customer_group
FROM customer;
#---------------------------
#payment 테이블에서 각 고객들의 결제금액을 출력하세요.
# 단, 출력 내용은 다음과 같아야 합니다.
# 고객 ID, 고객 결제금액, 해당 행의 결제 금액의 이전 결제금액, 해당 행의 결제 금액의 다음 결제금액
# 고객의 대한 매출 흐름이 상승곡선? 아닌가? 확인가능

SELECT
	C.customer_id,
    P.amount,
    LAG(P.amount) OVER (PARTITION BY customer_id ORDER BY payment_date) previous_amount,
    #customer_id 가 하나의 부분 집합으로써 payment_date 정렬 시켜줌
    LEAD(P.amount) OVER (PARTITION BY customer_id ORDER BY payment_date) next_amount
FROM customer C
JOIN payment P USING (customer_id);
#---------------------------
# rental 테이블에서 각 고객 별로 첫번째 대여일자 와 마지막 대여일자를 출력하세요.
# 출력 결과물에는 고객아이디, 첫번째 대여일자, 마지막 대여일자가 포함되어있음 됨.
SELECT 
	DISTINCT customer_id,
    FIRST_VALUE(rental_date) OVER (PARTITION BY customer_id ORDER BY rental_date) first_rental_date,
	LAST_VALUE(rental_date) OVER (PARTITION BY customer_id ORDER BY rental_date
									ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                                    ) last_rental_date
FROM rental;
#---------------------------
# payment 테이블에서 각 직원이 처리한 첫번째 결제와 마지막 결제 금액을 출력해주세요
# 직원id, 해당 직원이 처리한 첫번째 결제금액, 해당직원이 처리한 마지막 결제금액

SELECT
	DISTINCT staff_id,
    FIRST_VALUE(amount) OVER (PARTITION BY staff_id ORDER BY payment_date) first_payment_date,
	LAST_VALUE(amount) OVER (PARTITION BY staff_id ORDER BY payment_date
									ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                                    ) last_payment_date
FROM payment;
#---------------------------
# film 테이블에서 각 영화의 대여기간에 대한 백분위 순위, 누적분포를 계산해주세요.
# 출력 값은 영화제목, 대여기간, 백분위 순위

SELECT
	title, rental_duration,
    PERCENT_RANK() OVER (ORDER BY rental_duration) percentile_rank,
    CUME_DIST() OVER (ORDER BY rental_duration) cumulative_distribution
FROM film;
#---------------------------
# customer 테이블에서 각 고객의 결제 금액에 대한 백분위 순위와 누적분포를 계산해주세요.
# 출력 결과값 고객id, 총 결제금액, 백분위 순위 누적분포

SELECT	
	customer_id,
    SUM(amount) total_amount,
    PERCENT_RANK() OVER (ORDER BY SUM(amount)) percentile_rank,
    CUME_DIST() OVER (ORDER BY SUM(amount)) cumulative_distribution
FROM customer
JOIN payment USING (customer_id)
GROUP BY customer_id;

SELECT	
	C.customer_id,
    SUM(P.amount) total_amount,
    PERCENT_RANK() OVER (ORDER BY SUM(P.amount )DESC) percentile_rank,
    CUME_DIST() OVER (ORDER BY SUM(P.amount )DESC) cumulative_distribution
FROM customer C
JOIN payment P USING (customer_id)
GROUP BY C.customer_id
ORDER BY total_amount;
#---------------------------
# rental 테이블에서 각 고객별로 대여순서에 따른 누적 대여 횟수를 출력해주세요.
# 대여 순서는 대여한 날짜를 오름차순으로 정렬한 것 
# 대여ID, 고객ID, 대여 날짜, 누적 대여 횟수 

SELECT
    rental_id,
    customer_id,
    rental_date,
    COUNT(*) OVER (
        PARTITION BY customer_id
        ORDER BY rental_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_distribution
FROM rental;
#---------------------------
# payment 테이블에서 각 고객별로 결제 일자에 따른 누적 결제 금액을 출력해주세요.
# 결제ID, 고객ID, 결제 날짜, 결제 금액, 누적 결제 금액

SELECT
	payment_id, customer_id, payment_date,
    SUM(amount) OVER (PARTITION BY customer_id ORDER BY payment_date 
					ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
                    cumulative_amount
                    # row가 없으면 같은 날짜의 여러 결제는 중복 계산 가능.
FROM payment;
# ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
# 따라서 같은 날짜라도 중복되지 않고, 각 행별 누적 합계가 계산됩니다.
#---------------------------
# rental 테이블에서 각 직원들의 대열 날짜에 따른 대여횟수와 각 직원별 누적 대여 횟수 출력
# 대여id, 직원id, 대여 날짜, 대여 횟수, 누적대여 횟수

SELECT 
	rental_id, staff_id, rental_date,
    COUNT(*) OVER (PARTITION BY staff_id, DATE(rental_date) ORDER BY DATE(rental_date)
					ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) rental_count,
    COUNT(*) OVER (PARTITION BY staff_id ORDER BY DATE(rental_date)
					ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_count
FROM rental;