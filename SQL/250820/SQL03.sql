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
# 없는 데이터의 갯수 출력!!!(*INNER JOIN, RIGHT (OUTER) JOIN)
SELECT *  FROM address; #603
SELECT * FROM customer; #599
# INNER JOIN
SELECT
COUNT(A.address_id)
FROM address A 
JOIN customer C USING (address_id);
# 한쪽에 값이 없으면 값을 버려버림

SELECT
	(SELECT COUNT(*) FROM address) - 
	(SELECT
	COUNT(A.address_id)
	FROM address A 
	JOIN customer C USING (address_id))
    AS no_customer_address; 
# = 피연산자
# 1+2 =3 사칙연산식

# RIGHT (OUTER) JOIN
SELECT COUNT(*) AS no_customer_address
FROM customer C
RIGHT OUTER JOIN address A # outer 생략 가능!
ON A.address_id = C.address_id
WHERE customer_id IS NULL; 
#오른쪽 테이블(B) 기준으로 모든 행을 가져옴
#왼쪽 테이블(A)에 매칭되는 값이 없으면 → NULL로 채움
#---------------------------	

# 문제 11. 캐나다 고객에게 이메일 마케팅 캠페인을 진행하고자 합니다.
# 캐나다 고객의 이름과 이메일 주소 리스트를 출력해주세요.
SELECT * FROM country; #country_id
SELECT * FROM city; # country_id, city_id
SELECT * FROM address; # address_id, city_id
SELECT * FROM customer; #address_id


SELECT
CS.customer_id,
C.country,
CONCAT(CS.first_name, " ", CS.last_name) Name,
CS.email
FROM country C
JOIN city CT USING (country_id)
JOIN address A USING (city_id)
JOIN customer CS USING (address_id)
WHERE C.country = 'Canada';
#---------------------------	

# 문제 12. 신혼부부 타겟 고객들의 매출이 최근 저조해져서 가족영화를 홍보대상으로
# 삼고자 합니다. 가족 영화로 분류된 모든 영화 리스트를 출력해주세요.
SELECT * FROM category; #category_id
SELECT * FROM film_category; #category_id, film_id
SELECT * FROM film; #film_id

SELECT 
F.film_id,
F.title
FROM film F
JOIN film_category FC USING(film_id)
JOIN category C USING(category_id)
WHERE C.name = 'Family';
#---------------------------	

#문제 13. 가장 자주 대여하는 영화 리스트를 참고로 보고 싶습니다.
# 가장 자주 대여하는 영화 순으로 100개만 뽑아주세요.
# 영화 제목, 렌탈횟수
SELECT * FROM rental; # rental_id,inventory_id
SELECT * FROM inventory; # inventory_id, film_id
SELECT * FROM film; # film_id

SELECT
F.title,
COUNT(*) Rentals
FROM film F
JOIN inventory I USING (film_id)
JOIN rental R USING (inventory_id)
GROUP BY F.film_id
ORDER BY Rentals DESC
LIMIT 100;
#---------------------------	

# 문제 14. 각 스토어 별로 매출을 확인하고 싶습니다. 관련 데이터를 출력해주세요.
# "도시, 국가" // 스토어ID // 스토어별 총 매출 
SELECT * FROM store; #store_id, address_id
SELECT * FROM staff; #store_id, address_id, staff_id
SELECT * FROM payment; # amount, staff_id
SELECT * FROM address; # address_id, city_id
SELECT * FROM city; # country_id, city_id
SELECT * FROM country; # country_id

SELECT
	STO.store_id "Store_ID",
    CONCAT(C.city, ", ", CO.country) "Store",
	SUM(P.amount) Total_Sales
FROM payment P
JOIN staff STA USING (staff_id)
JOIN store STO USING (store_id)
JOIN address A ON STO.address_id = A.address_id
JOIN city C USING (city_id)
JOIN country CO USING (country_id)
GROUP BY STO.store_id;
#---------------------------	

# 문제 15. 가장 렌탈비용을 많이 지불한 상위 10명의 vip 고객에게 선물을 배송하고자합니다.
# 해당 vip 고객들의 주소와 이메일 그리고 각 고객별 그동안 총 지불비용을 출력해주세요.
SELECT * FROM customer; #customer_id, email, address_id, name
SELECT * FROM address; #address_id
SELECT * FROM payment; #rental_id, customer_id

SELECT
CONCAT(C.first_name, " ", C.last_name) Name,
A.address,
C.email,
SUM(P.amount) Total_Sales
FROM customer C
JOIN address A ON A.address_id = C.address_id
JOIN payment P ON P.customer_id = C.customer_id
GROUP BY C.customer_id
ORDER BY Total_Sales DESC
LIMIT 10;
#---------------------------	

# 문제 16.actor 테이블의 배우 이름을 first_name과 last_name의 조합으로 
# 출력해주세요. 단, 소문자로 출력
SELECT 
#LOWER(CONCAT(first_name, " ", last_name))
CONCAT(
	UPPER(LEFT(first_name, 1)), 
    LOWER(SUBSTRING(first_name, 2)),
    " ",
	UPPER(LEFT(last_name, 1)), 
    LOWER(SUBSTRING(last_name, 2))
    ) Actor_Name
#왼쪽에서부터 1번째 글자만 대문자
#SUBSTRING 2번째 글자부터 잘라와서 소문자
FROM actor;
#---------------------------

# 문제 17.언어가 영어인 영화 중 영화 타이틀이 K와 Q로 시작하는 영화의 타이틀만 출력!
# 서브쿼리로 가져오세요!
SELECT * FROM language; #language_id
SELECT * FROM film; #language_id, film_id

SELECT
title
FROM film 
WHERE language_id IN (
	SELECT
    language_id
    FROM language
    WHERE name = 'English'
) AND (title LIKE "K%" OR title LIKE "Q%")
GROUP BY film_id;
#---------------------------

# 문제 18. Along Trip에 나오는 배우 이름을 모두 출력하세요.
# 단, 배우 이름은 actor_name이라는 필드명으로 출력해주세요.
# 서브쿼리
SELECT * FROM actor; # actor_id
SELECT * FROM film_actor; # actor_id, film_id
SELECT * FROM film; # title, film_id

SELECT 
CONCAT(first_name, " ", last_name) actor_name
FROM actor
WHERE actor_id IN (
	SELECT actor_id FROM film_actor
		WHERE film_id IN(
			SELECT film_id FROM film
				WHERE title = "Along Trip"
    )
);
#---------------------------

# 문제 19. 2005년 8월에 각 스태프 멤버가 올린 매출을 출력해주세요.
# 스태프 멤버의 필드명은 Staff_Member로, 매출 필드명은 Total_Amount로 해주세요.
SELECT * FROM payment; # payment_date, staff_id
SELECT * FROM staff; # staff_id

SELECT 
	CONCAT(S.first_name, " ", S.last_name) Staff_Member,
	SUM(P.amount) Total_Amount
FROM staff S
JOIN payment P USING (staff_id)
#WHERE payment_date LIKE "2005-08%"
WHERE 
	EXTRACT(YEAR FROM payment_date) = 2005 and
	EXTRACT(MONTH FROM payment_date) = 8
#WHERE 
	#YEAR(payment_date) = 2005 and
    #MONTH(payment_date) = 8
GROUP BY S.staff_id;
#---------------------------

# 문제 20. 각 카테고리의 평균 영화 러닝타임이 전체 평균 러닝타임보다 큰
# 카테고리들의 카테고리명과 해당 카테고리의 평균 러닝 타임을 출력하세요.
SELECT * FROM film; #title, length, film_id
SELECT * FROM category; #name, category_id
SELECT * FROM film_category; # film_id, category_id

SELECT 
	C.name,
	AVG(F.length) film_length
FROM film F
JOIN film_category FC USING (film_id)
JOIN category C USING (category_id)
GROUP BY C.name
HAVING film_length > (
	SELECT AVG(length) FROM film
);
#---------------------------

# 문제 21. 각 카테고리별 평균 영화 대여시간과 해당 카테고리명을 출력하세요.
# 단, 영화 대여시간은 => 영화 대여 및 반납 시간의 차이, hour를 단위로 사용
SELECT * FROM category; #name, category_id
SELECT * FROM film_category; # film_id, category_id
SELECT * FROM rental; # rental_id, inventory_id
SELECT * FROM inventory; # film_id, inventory_id

SELECT 
C.name,
AVG(TIMESTAMPDIFF(HOUR, R.rental_date, R.return_date)) AS diff_time
FROM rental R
JOIN  inventory I USING (inventory_id)
JOIN  film_category FC USING (film_id)
JOIN  category C USING (category_id)
GROUP BY C.name;     
#---------------------------

# 문제. 22 새로운 임원이 부임했습니다. 총 매출액 상위 5개 장르의 매출액을 수시로 확인하고자 합니다.
# 각 장르별 총 매출액(Total Sales), 각 장르(Genre) 이름으로 해당 데이터를 수시로 
# 확인 할 수 있는 VIEW를 생성해주세요.
# VIEW의 이름은 top5_genres로 만들어주시고, 총 매출액 상위 5개 장르의 매출액이
# 출력될 수 있도록 해주세요.
SELECT * FROM payment; #amount, rental_id
SELECT * FROM category; #category_id
SELECT * FROM rental; # rental_id, inventory_id
SELECT * FROM inventory; # film_id, inventory_id
SELECT * FROM film_category; #category_id, film_id

CREATE OR REPLACE VIEW top5_genres AS 
SELECT
	C.name Genre,
	SUM(P.amount) Total_Sales
FROM category C
JOIN film_category FC USING (category_id)
JOIN inventory I USING (film_id)
JOIN rental R USING (inventory_id)
JOIN payment P USING (rental_id)
GROUP BY C.name
ORDER BY Total_Sales DESC
LIMIT 5;

DROP VIEW top5_genres;
SELECT * FROM top5_genres;
#---------------------------

# 문제 23. 2005년 5월에 가장 많이 대여된 영화 3개를 찾아주세요.
# 영화제목고 대여 횟수를 출력하면 됩니다!
SELECT * FROM film; #film_id
SELECT * FROM inventory; #film_id, inventory_id
SELECT * FROM rental; #rental_id, inventory_id

SELECT
F.title,
COUNT(*) Rental_Count
FROM film F
JOIN inventory I USING (film_id)
JOIN rental R USING (inventory_id)
WHERE 
	YEAR(rental_date) = 2005 and
    MONTH(rental_date) = 5
GROUP BY film_id
ORDER BY Rental_Count DESC
LIMIT 3;
#---------------------------

# 문제 24. 대여된 적이 없는 영화를 찾으세요.
SELECT * FROM film; #film_id
SELECT * FROM inventory; #film_id, inventory_id
SELECT * FROM rental; #rental_id, inventory_id
# 한번이라도 렌탈이 됐으면 inventory_id 있을 것!

SELECT
F.title
FROM film F
WHERE film_id NOT IN (
	SELECT film_id FROM inventory I
    JOIN rental R USING(inventory_id)
);
#---------------------------

# 문제 25. 각 고객의 총 지출 금액의 평균 보다 총 지출 금액이 더 큰 고객 리스트를 찾으세요.
# 그들의 이름과 그들이 지출한 총 금액을 보여주세요.
# 고객A 5번 렌트, 총 100달러
SELECT * FROM customer; #customer_id, name
SELECT * FROM payment; #customer_id, amount

SELECT
	CONCAT(first_name, " ", last_name) Name,
    SUM(P.amount) sum_amount
FROM payment P
JOIN customer C USING (customer_id)
GROUP BY C.customer_id
HAVING SUM(P.amount) > (
SELECT
    AVG(sum_amount)
FROM(
	SELECT
		SUM(P.amount) sum_amount
	FROM payment P
	GROUP BY customer_id
) AS sub_query);
#---------------------------

# 문제 26. 가장 많은 결제건을 처리한 직원이 누구인지 찾아주세요.
SELECT * FROM staff; 
SELECT * FROM payment; #staff_id

SELECT 
	CONCAT(first_name, " ", last_name) Name,
	COUNT(*)
FROM payment
JOIN staff USING (staff_id)
GROUP BY staff_id
ORDER BY COUNT(*) DESC
LIMIT 1;
#---------------------------

# 문제 27. "액션" 카테고리에서 높은 영화 영상 등급을 받은 순으로, 상의5개의 영화를 보여주세요.
# (*높은 영화 영상 등급 순으로 정렬은 ORDER BY rating DESC)
SELECT * FROM category; #category_id
SELECT * FROM film_category; # film_id, category_id
SELECT * FROM film; #film_id

SELECT 
F.title,
F.rating
FROM film F
JOIN film_category FC USING (film_id)
JOIN category C USING (category_id)
WHERE C.name = 'Action'
ORDER BY rating DESC
LIMIT 5;

SELECT 
    DISTINCT rating
FROM film;

DESC film;
#---------------------------

# 문제28. 각 영화 영상등급을 기준으로 영화별 대여기간의 평균을 찾아주세요.
SELECT * FROM film; #film_id, rental_duration
SELECT * FROM rental; #rental_id, inventory_id
SELECT * FROM inventory; #film_id, inventory_id

SELECT 
rating, AVG(rental_duration)
FROM film 
GROUP BY rating;
#---------------------------

# 문제 29. 매장 아이디별 총 매출을 보여주는 view를 생성하세요.
SELECT * FROM store; #store_id, address_id
SELECT * FROM payment; #staff_id, amount
SELECT * FROM staff; #staff_id, store_id

CREATE OR REPLACE VIEW Total_Amount AS
SELECT
STO.store_id,
SUM(P.amount) sum_amount
FROM payment P
JOIN staff STA USING(staff_id)
JOIN store STO USING(store_id)
GROUP BY store_id;

SELECT * FROM Total_Amount;
DROP VIEW Total_Amount;
#---------------------------

# 문제 30. 가장 많은 고객이 있는 상위 5개 국가를 보여주세요.
SELECT * FROM customer; #address_id
SELECT * FROM country; #country_id
SELECT * FROM address; #address_id, city_id
SELECT * FROM city; # country_id, city_id

SELECT 
    CO.country,
    COUNT(*) customer_count
FROM customer C
JOIN address A USING (address_id)
JOIN city CI USING (city_id)
JOIN country CO USING (country_id)
GROUP BY CO.country
ORDER BY customer_count DESC
LIMIT 5;
