USE mysql;

SELECT host, user FROM user;

CREATE USER 'david7'@'localhost'
IDENTIFIED BY 'david1234';# 만들어서 비밀번호 설정

CREATE USER 'david8'@'%'
IDENTIFIED BY 'david1234';

SET PASSWORD FOR 'david7'@'localhost'= 'david5678';

DROP USER 'david7'@'localhost'; #삭제
DROP USER 'david8'@'%';

SHOW GRANTS FOR 'root'@'localhost'; #권한보기
SHOW GRANTS FOR 'david7'@'localhost';
GRANT SELECT ON school.students TO 'david7'@'localhost'; #권한주기
GRANT ALL ON school.* TO 'david7'@'localhost';