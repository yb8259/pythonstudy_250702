USE interpark;

SELECT * FROM performances;
# 1. 크롤링한 전체 데이터 개수
SELECT count(*) AS Total_performances FROM performances;

# 특정 컬럼의 값을 집계하고자 할땐 GROUP BY 써줘야함.
# 2. 크롤링한 데이터 가운데 어떤 지역. 장소에서 가장 많이 공연을 하고 있는지 확인
SELECT place, COUNT(*) AS 개수
FROM performances 
GROUP BY place 
ORDER BY count(*) DESC;

# 3. 특정 장소 공연 조회 
SELECT * FROM performances
WHERE place LIKE "%전국 각 지역%"; 

# 4. 공연 일정이 가까운 순 정렬 (*시작일을 기준) / SUB제거할거야 
SELECT title, place, SUBSTRING_INDEX(date_range, ' - ', 1) AS start_date
FROM performances
ORDER BY start_date DESC; 