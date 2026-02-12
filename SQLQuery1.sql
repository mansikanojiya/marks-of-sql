CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    english INT,
    maths INT,
    science INT,
    total INT
);
INSERT INTO students VALUES (1, 'Amit', 78, 85, 90, 253);
INSERT INTO students VALUES (2, 'Priya', 88, 92, 79, 259);
INSERT INTO students VALUES (3, 'Rahul', 67, 73, 70, 210);
INSERT INTO students VALUES (4, 'Sneha', 90, 95, 93, 278);

---Display all records.
select * from students;

--Display only name and total.
select name,total from students;

--Display only english marks.
select english from students;

--Display student names only.
select name from students;

--Display students with their maths and science marks.
select name,maths,science from students;

--Students who scored more than 80 in English.
select * from students where english> 80 ;

--Students who scored less than 80 in Maths.
select * from students where maths<80;

--Students who scored exactly 90 in Science.
select * from students where science=90;

--Students whose total is greater than 250.
select * from students where total>250;

--Students whose total is less than or equal to 200.
select * from students where total<=200;

--Students who scored between 70 and 90 in English.
select * from students where english between 70 and 90;

--Students who scored more than 75 in all subjects.
select * from students where english >75 and maths>75 and science>75;

--Students who scored less than 60 in any subject.
select * from students where english <60 and maths<60 and science<60;

--Students whose name is 'Amit'.
select * from students where name ='amit';

--Students whose name starts with 'S'.
select name from students where name like 'S%';

--Students whose name ends with 'a'.
select name from students where name like '%a';

--Students whose name contains 'ri'.
select name from students where name like '%ri';

--Display students sorted by name (A-Z).
select * from students order by name asc;

--Display students sorted by name (Z-A).
select * from students order by name desc;

--Sort students by total (highest to lowest).
select * from students order by total desc;

--Sort students by English marks (lowest to highest).
select name, english from students order by english asc;

--Sort by maths, then by science.
select * from students order by maths ,science;

--Find maximum English marks.
select max(english) from students;

--Find minimum Maths marks.
select min(maths) from students;

--Find average Science marks.
select avg(science) from students;

--Find total sum of English marks.
select sum(english) from students;

--Count total number of students.
select count(name) from students;

--Find highest total.
select max(total) from students;

--Find lowest total.
select min(total) from students;

--Count students having same English marks.
select english, count(name) from students group by english 

--Find average total marks.
select avg(total) from students;

--Group students by maths marks.
SELECT maths, COUNT(*) AS number_of_students
FROM students
GROUP BY maths;

--Update English marks of student with id = 1
UPDATE students
SET english = 85
WHERE id = 1;

--Increase Maths marks by 5 for all students.
select maths,maths+5 from students;

--Update total = english + maths + science.
update students set  total = english + maths + science;

--Students who scored more than 80 in English AND Maths.
select * from students where english>80 and maths>80;

--Students who scored more than 85 in English OR Science.
select * from students where english >85 or science>85;

--Students NOT scoring more than 70 in Maths.
select * from students where maths <80;

--Find 2nd highest total.
select max(total) from employees where total<(select max(total) from employees);

--Find Student with Highest English Marks
select * from students where english= (select max(english) from students);

--add a new colmun grade
alter table students 
add grade nvarchar(50);

--display pass \fail
select name ,total,
case 
when total >=150 then 'pass'
else 'fail'
end as result 
from students;

--Above average total
select * from students where total > (select avg(total) from students);

--English below average
select * from students where english < (select avg(english) from students);

--Highest Maths
select * from students where maths= (select max(maths) from students);

--Lowest Science
SELECT * 
FROM students
WHERE science = (SELECT MIN(science) FROM students);

--total greater than average
select* 
from students
where total > (select avg(total) from students);

--Top 3 students by total
select top 3 * from students order by total desc;

--3rd highest total
select top 1 * from students order by total asc;

--Same total as highest
SELECT *
FROM students
WHERE total = (SELECT MAX(total) FROM students);

--Second lowest English
SELECT DISTINCT english
FROM students
ORDER BY english ASC
;

--Count Maths > 80
SELECT COUNT(*) 
FROM students
WHERE maths > 80;

--English groups having more than 1 student
SELECT english, COUNT(*) AS total_students
FROM students
GROUP BY english
HAVING COUNT(*) > 1;

--Average total > 200
SELECT AVG(total) AS avg_total
FROM students
HAVING AVG(total) > 200;

--Count passed students
SELECT COUNT(*) 
FROM students
WHERE total >= 150;

--Grade System
SELECT name, total,
CASE
    WHEN total >= 250 THEN 'A'
    WHEN total >= 200 THEN 'B'
    WHEN total >= 150 THEN 'C'
    ELSE 'Fail'
END AS grade
FROM students;

--Remarks
SELECT name,
CASE
    WHEN english > 85 AND maths > 85 AND science > 85 THEN 'Excellent'
    WHEN total > 200 THEN 'Good'
    ELSE 'Needs Improvement'
END AS remark
FROM students;


--Max difference between English & Maths
SELECT top 1 *
FROM students
ORDER BY ABS(english - maths) DESC;

--Maths > Science

SELECT *
FROM students
WHERE maths > science;

--English = Science
SELECT *
FROM students
WHERE english = science;


--Percentage
SELECT name,
(total / 300.0) * 100 AS percentage
FROM students;

---Total is even
SELECT *
FROM students
WHERE total % 2 = 0;

--Find 2nd Highest Total

SELECT MAX(total) AS second_highest
FROM students
WHERE total < (SELECT MAX(total) FROM students);

--Find 3rd Highest Total
SELECT total
FROM students s1
WHERE 2 = (
    SELECT COUNT(DISTINCT total)
    FROM students s2
    WHERE s2.total > s1.total
);

--Rank Students Based on Total
SELECT name, total,
RANK() OVER (ORDER BY total DESC) AS rank_position
FROM students;

--Dense Rank
SELECT name, total,
DENSE_RANK() OVER (ORDER BY total DESC) AS dense_rank
FROM students;

--Find Students Above Class Average in All Subjects
SELECT *
FROM students
WHERE english > (SELECT AVG(english) FROM students)
  AND maths > (SELECT AVG(maths) FROM students)
  AND science > (SELECT AVG(science) FROM students);

  ---Find Students Who Scored Highest in At Least One Subject
  SELECT *
FROM students
WHERE english = (SELECT MAX(english) FROM students)
   OR maths = (SELECT MAX(maths) FROM students)
   OR science = (SELECT MAX(science) FROM students);

   --Update Grade Automatically Based on Total

   UPDATE students
SET grade = CASE
    WHEN total >= 250 THEN 'A'
    WHEN total >= 200 THEN 'B'
    WHEN total >= 150 THEN 'C'
    ELSE 'Fail'
END;

--Find Students Scoring Above Average But Below Maximum

SELECT *
FROM students
WHERE total > (SELECT AVG(total) FROM students)
AND total < (SELECT MAX(total) FROM students);

--Find Percentage and Rank Together
SELECT name,
(total/300.0)*100 AS percentage,
RANK() OVER (ORDER BY total DESC) AS rank_position
FROM students;

--Find Duplicate Totals
SELECT total, COUNT(*)
FROM students
GROUP BY total
HAVING COUNT(*) > 1;

--Student With Highest Combined English + Maths Only
SELECT *
FROM students
ORDER BY (english + maths) DESC;








