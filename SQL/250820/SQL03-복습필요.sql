SELECT
	CONCAT(S.first_name, " ", last_name) Staff_Member,
    SUM(P.amount) Total_Amount
FROM staff S
JOIN payment P USING(staff_id)
WHERE payment_date LIKE "2005-08%"
GROUP BY P.staff_id;

SELECT
	CONCAT(S.first_name, " ", last_name) Staff_Member,
    SUM(P.amount) Total_Amount
FROM staff S
JOIN payment P USING(staff_id)
WHERE
	EXTRACT(YEAR FROM payment_date) = 2005 AND
    EXTRACT(MONTH FROM payment_date) = 8
GROUP BY P.staff_id;

SELECT
	CONCAT(S.first_name, " ", last_name) Staff_Member,
    SUM(P.amount) Total_Amount
FROM staff S
JOIN payment P USING(staff_id)
WHERE
	YEAR(payment_date) = 2005 AND
    MONTH(payment_date) = 8
GROUP BY P.staff_id;


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