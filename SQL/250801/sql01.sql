USE SCHOOL;
DESC STUDENTS;
SELECT * FROM students;
DELETE FROM students WHERE id=3;

ALTER TABLE students MODIFY COLUMN age VARCHAR(20) NOT NULL; 
UPDATE students SET age = "15세" WHERE ID = 1; # "15세"는 byte 충돌 그래서 문자로 바꿔야함
UPDATE students SET age = "15세" WHERE ID = 2;
UPDATE students SET age = "17세" WHERE ID = 4;
UPDATE students SET age = "16세" WHERE ID = 5;
UPDATE students SET age = "15세" WHERE ID = 6;

SELECT name FROM students;
SELECT name, age FROM students;
SELECT * FROM students WHERE age = "16세";
SELECT * FROM students WHERE age != "16세";
SELECT * FROM students WHERE age <> "16세";
SELECT * FROM students WHERE age > "16세";
SELECT * FROM students WHERE age <= "15세";

UPDATE students SET grade = "8학년" WHERE id = 1;
UPDATE students SET grade = "8학년" WHERE id = 2;
UPDATE students SET grade = "10학년" WHERE id = 4;
UPDATE students SET grade = "9학년" WHERE id = 5;
UPDATE students SET grade = "8학년" WHERE id = 6;
INSERT INTO students (name, age, grade) VALUE ("강백호","15살","8학년");

DELETE FROM students WHERE id=7;

SELECT * FROM students WHERE grade != "10학년";
SELECT * FROM students 
WHERE age >= "15세" and grade = "10학년";

SELECT * FROM students 
WHERE age <= "16세" or grade = "8학년";
WHERE (age <= "16세") or (grade = "8학년"); # 이렇게 보기쉽게 표현해도 돼요!

INSERT INTO students (id, grade, name, age) value(4,"10학년", "채치수", "17세");

SELECT * FROM students
WHERE name = "강백호";

SELECT * FROM students
WHERE name LIKE  "%백%"; # %는 0개여도 되고, 1개여도 된다.
SELECT * FROM students
WHERE name LIKE  "_백_"; # _는 %보다 엄격하게 일치하는 데이터를 찾아오고자 할 때.
SELECT * FROM students
WHERE name LIKE  "___";

UPDATE students SET age = "17세", grade = "10학년" WHERE id = 4;