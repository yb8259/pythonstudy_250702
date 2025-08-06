SELECT rating FROM film
GROUP BY rating;

SELECT COUNT(*) rating FROM film
GROUP BY rating; # 그룹이 없다면 film 총 카운트를 가져오는 것.

SELECT COUNT(*) rating FROM film
WHERE rating = "PG" OR rating ="G"
GROUP BY rating;

# 필름 테이블에서 영화등급이 g등급인 영화 제목을 모두 출력해주세요.
SELECT * FROM film WHERE rating = "G" LIMIT 5; 
SELECT rating, title FROM film WHERE rating = "G";
SELECT rating, title FROM film WHERE rating = "G" GROUP BY title;
# 필름 테이블에서 영화등급이 g, pg등급인 영화 제목을 모두 출력해주세요.
SELECT rating FROM film;
SELECT title, rating FROM film 
WHERE rating = "G" OR rating = "PG";

# 필름 테이블에서 영화개봉 년도가 2006년 또는 2007년이고, 영화등급이 PG 또는 G등급인 영화의 제목만 출력해주세요!
SELECT * FROM film WHERE rating = "G" or rating = "PG" LIMIT 5;
SELECT release_year FROM film GROUP BY release_year;
SELECT release_year, title FROM film 
WHERE 
	(release_year = 2006 OR release_year = 2007) AND 
    (rating = "G" OR rating = "PG");
    
# film 테이블에서 rating으로 그룹을 묶어서, 각 등급별 영화 갯수와 등급, 각 그룹별 평균 rental_rate을 출력해주세요.
SELECT * FROM film LIMIT 5;
SELECT 
	rating, 
	COUNT(*) rating, 
	AVG(rental_rate) 
FROM film 
GROUP BY rating;

# GROUP BY -> 집계함수를 사용해서 들어오면, 해당 컬럼값이 실제 그룹핑과 관계가 없더라도 출력값으로 허용(*예외조항) 

# 필름테이블에서 rating으로 그룹을 묶어서 각 등급별 영화 개수 각 등급별 평균 렌탈비용을 출력하는데, 평균 렌탈비용이 높은 순으로 출력해주세요.
SELECT 
	rating, 
	COUNT(*) rating, 
	AVG(rental_rate) 
FROM film 
GROUP BY rating 
ORDER BY AVG(rental_rate) DESC;


SELECT 
	rating, 
	COUNT(*) total_films,  
	AVG(rental_rate) avg_rental_rate 
FROM film 
GROUP BY rating 
ORDER BY AVG(rental_rate) DESC;

# 각 등급별 영화 길이가 130분 이상인 영화의 갯수와 등급을 출력해보세요!!
SELECT * FROM film LIMIT 1;
SELECT 
	rating,
	COUNT(*) filmcount
FROM film 
WHERE length >= 130
GROUP BY rating
ORDER BY COUNT(*) DESC;