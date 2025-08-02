CREATE DATABASE IF NOT EXISTS school;
USE school ;

-- CREATE TABLE students(
-- 	id INT UNSIGNED NOT NULL auto_increment,
--     primary key(ID)
-- );
CREATE TABLE students(
	id 	INT UNSIGNED NOT NULL auto_increment primary KEY,
    name VARCHAR(50) NOT NULL,
    age INT UNSIGNED,
    grade VARCHAR(10)
);
DESC students;

-- INSERT INTO students VALUES(1,"강백호",15,"8");
INSERT INTO students (name, age, grade) 
value("서태웅", 15, "8");

INSERT INTO students ( grade, name, age) 
value("10", "채치수17", 17);

INSERT INTO students ( grade, name, age) 
value("9", "정대만", 16);

INSERT INTO students ( grade, name, age) 
value("8", "송태섭", 15);

select * from students;
SELECT NAME FROM STUDENTS;
SELECT GRADE FROM STUDENTS;
SELECT NAME, GRADE FROM STUDENTS;

select * from students where age = 16;
select * from students where age != 16;
select * from students where age <> 16;