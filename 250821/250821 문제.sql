# 각 고객이 어떤 영화 카테고리를 가장 자주 대여하는지 알고 싶습니다. 
# 각 고객별로 가장많이 대여한 영화 카테고리와 해당 카테고리에서의 총 대여 횟수, 
# 그리고 해당 고객 이름을 조회하는 SQL 구문을 작성해주세요. 
# 자주 대여하는 카테고리에 동률이 있을 경우 모두 보여주세요.
USE sakila;
SELECT * FROM customer; # customer_id, 
SELECT * FROM category; #category_id, name
SELECT * FROM film_category; # film_id, category_id
SELECT * FROM rental; # rental_id, inventory_id, customer_id,
SELECT * FROM inventory; # film_id, inventory_id

SELECT 
customer_id,
CONCAT(first_name, " ", last_name) Name,
CA.name Category_name,
COUNT(*)
FROM customer C
JOIN rental R USING (customer_id)
JOIN inventory I USING (inventory_id)
JOIN film_category FC USING (film_id)
JOIN category CA USING (category_id)
GROUP BY customer_id, Name;