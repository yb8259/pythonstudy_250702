# 문제1. category 테이블에서 Comedy, Sports, Family 카테고리의 
# category_id와 카테고리명을 출력해주세요.
SELECT * FROM category;

#1.
SELECT 
	category_id, 
	name 
FROM category
WHERE name = 'Comedy' OR name = 'Sports' OR name = 'Family';

#2.
SELECT 
	category_id, 
	name 
FROM category
WHERE name IN ('Comedy', 'Sports', 'Family');
#---------------------------

# 문제2. film_category 테이블에서 차테고리 id별 영화 갯수 확인
SELECT 
	category_id,
	COUNT(*) film_count
FROM film_category
GROUP BY category_id;
#---------------------------

# 문제3. 카페고리가 Comedy인 영화 갯수 확인 및 출력(*JOIN)
SELECT * FROM category;
SELECT * FROM film_category;
SELECT
category_id,
name,
COUNT(*) count
FROM category C
JOIN film_category FC USING (category_id)
WHERE C.name = 'Comedy'
GROUP BY category_id;
#---------------------------

# 문제4. 카페고리가 Comedy인 영화 갯수 확인 및 출력(*Subquery)

SELECT 
COUNT(*) 
FROM film_category 
WHERE category_id IN (
	SELECT category_id FROM category 
    WHERE name = 'Comedy'
);
# C.category_id, C.name도 포함
SELECT 
    C.category_id,
    C.name,
    COUNT(*) AS count
FROM film_category FC
JOIN (
    SELECT category_id, name
    FROM category
    WHERE name = 'Comedy'
) C ON FC.category_id = C.category_id
GROUP BY C.category_id, C.name;
#---------------------------

# 문제5. Comedy, Sports, Family 각각의 카테고리별 영화 수 확인하기(JOIN)
SELECT * FROM category;
SELECT * FROM film_category;

SELECT 
	C.category_id, 
	C.name,
    COUNT(*) count
FROM category C
JOIN film_category FC USING (category_id)
WHERE name IN ('Comedy', 'Sports', 'Family')
GROUP BY C.category_id;
#---------------------------

# 문제6. 각 카테고리를 기준으로 영화 갯수가 70 이상인 카테고리명을 출력해주세요. 
SELECT 
	C.category_id, 
	C.name,
    COUNT(*) count
FROM category C
JOIN film_category FC USING (category_id)
GROUP BY C.category_id
HAVING COUNT(*) >= 70;
#---------------------------

# 문제7. 각 카테고리에 포함된 영화들의 렌탈 횟수 구하기
SELECT * FROM category; #category_id
SELECT * FROM rental; #rental_id, inventory_id
SELECT * FROM inventory; #inventory_id, film_id
SELECT * FROM film_category; #film_id, category_id
# 렌탈횟수 -> 현재 우리가 가지고 있는 DVD 전체 총 아이템을 기준으로
# 각 아이템들이 몇번씩 렌탈이 되었는가?
# 렌탈정보 rental -> inventory_id
# inventory -> inventory_id, film_id
# film_category -> #film_id, category_id
# category -> category_id

SELECT 
C.category_id,
C.name,
COUNT(*) count
FROM category C
JOIN film_category FC USING (category_id)
JOIN inventory I USING (film_id)
JOIN rental R USING (inventory_id)
GROUP BY category_id;
#---------------------------

# 문제8. Comedy, Sports, Family 카테고리에 포함되는 영화들의 렌탈 횟수 구하기
SELECT
C.category_id,
C.name,
COUNT(*) count
FROM category C
JOIN film_category FC USING (category_id)
JOIN inventory I USING (film_id)
JOIN rental R USING (inventory_id)
WHERE C.name IN ('Comedy', 'Sports', 'Family')
GROUP BY category_id;
#---------------------------

# 문제 9. 카테고리가 Comedy인 데이터의 렌탈 획수 출력 (*서브쿼리)
# 내가 가져올 수 있는 큰 값에 잘라내가는것 서브쿼리..
SELECT
COUNT(*) count
FROM rental R
WHERE inventory_id IN (
	SELECT inventory_id FROM inventory WHERE film_id IN (
		SELECT film_id FROM film_category WHERE category_id In ( 
			SELECT category_id FROM category
			WHERE name = 'Comedy'
            )
		)
	);
#---------------------------

# 문제 10. address 테이블에는 address_id가 있지만, customer 테이블에는 
# 없는 데이터의 갯수 출력!!!(*RIGHT JOIN)
SELECT
A.address_id,
COUNT(C.customer_id)
FROM customer C
RIGHT JOIN address A ON C.address_id = A.address_id
WHERE C.customer_id IS NULL
GROUP BY A.address_id;


	