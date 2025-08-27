#Sakila DB를 참고해서, 가장 많은 영화를 대여한 고객
#(*단,  가장 많은 영화의 기준 -> 동일한 영화를 반복해서 대여한 경우의 수는 제외, 
# 오직 서로 다른 영화를 대여했다는 기준으로만) 
#을 찾아내고, 해당 고객이 대여한 영화 갯수를 찾아주세요. 
# 또한 해당 고객이 대여한 영화가 가장 많이 속한 카테고리
# (*단, 이때에는 동일한 영화를 반복해서 대여한 경우의 수도 포함)도 찾아주세요.

USE sakila;
SELECT * FROM customer; #customer_id, name
SELECT * FROM film; #film_id, title
SELECT * FROM rental; # rental_id, customer_id, inventory_id
SELECT * FROM inventory; #inventory_id, film_id
SELECT * FROM category; #category_id, name
SELECT * FROM film_category; #film_id, category_id

WITH customer_best as (
	SELECT
	CU.customer_id,
	CONCAT(first_name," ",last_name) Name,
	count(DISTINCT I.film_id) rental_count #DISTINCT 중복값 제외
	FROM customer CU
	JOIN rental R USING (customer_id)
	JOIN inventory I USING (inventory_id)
	JOIN film F USING (film_id)
	GROUP BY customer_id
    ORDER BY rental_count DESC
    LIMIT 1
    )
	SELECT 
		CB.customer_id,
		CB.Name,
		CA.name,
		COUNT(*) total_rental_count 
    FROM customer_best CB
    JOIN rental R2 ON R2.customer_id = CB.customer_id 
    JOIN inventory I USING (inventory_id)
	JOIN film F USING (film_id)
    JOIN film_category FC USING (film_id)
	JOIN category CA USING (category_id)
	GROUP BY CB.customer_id, CB.Name, CA.name
    ORDER BY total_rental_count desc
    LIMIT 1;