USE musinsa_db;
SELECT * FROM reviews;

#글자수가 300 이상인 리뷰를 반응이 좋다고 생각하여 기준을 잡았습니다.
SELECT 
상품명 AS Cash_Cow,
COUNT(*) Count,
length(리뷰) 글자수
FROM reviews
WHERE length(리뷰) > 300
GROUP BY Cash_Cow, 리뷰;

# 글자수 300이상인 상품을 [상품명 - 리뷰] 형식으로 나타내었고 내림차순 하였습니다.
CREATE OR REPLACE VIEW Musinsa_tshirt AS
SELECT 
    CONCAT(상품명, ' - ', 리뷰) AS Cash_Cow_Review,
    LENGTH(리뷰) AS 글자수
FROM reviews
WHERE LENGTH(리뷰) > 300
ORDER BY 글자수 DESC;

SELECT * FROM Musinsa_tshirt;
DROP VIEW Musinsa_tshirt;