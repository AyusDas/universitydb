select * from department;

--
SELECT AVG(salary),
	   COUNT(prof_name),
	   MAX(salary)
FROM instructor 
WHERE dept_name like 'EL%';

--
SELECT dept_id,
	SUM(salary), COUNT(prof_name)
FROM instructor 
GROUP BY dept_id;

--
SELECT dept_id,
	SUM(salary), COUNT(prof_name)
FROM instructor 
GROUP BY dept_id
HAVING AVG(salary) > 25000;

--
SELECT dept_id, prof_id, AVG(salary), dept_name
FROM instructor
GROUP BY GROUPING SETS
(dept_id,dept_name),(prof_id,prof_name);

--
SELECT building_name
FROM sections
UNION
SELECT building_name
FROM classroom;

--select classrooms that have been alloted to sections
SELECT building_name
FROM sections
INTERSECT
SELECT building_name
FROM classroom;

--select departments where currently there is no course
SELECT dept_name
FROM department
EXCEPT
SELECT dept_name
FROM course;

--
SELECT course_title, dept_name
FROM course
WHERE fees > (
	SELECT AVG(fees)
	FROM course c
	WHERE c.course_id = course_id
);

--count no. of students in each department
SELECT dept_name, COUNT(student_id)
FROM student
GROUP BY dept_name;

--finding employee with second highest salary
SELECT MAX(salary)
FROM instructor
WHERE salary < (
	SELECT MAX(salary) 
	FROM instructor
);

--finding employee with highest salary from every department
SELECT dept_name, MAX(salary)
FROM instructor
GROUP BY dept_name;

--display only even (or odd) numbered rows
SELECT * FROM (
	SELECT row_number() over() AS r, dept_name
	FROM department
	ORDER BY r )
WHERE MOD(r,2) != 0;

--finding data with frequency greater than a certain threshold in descending order
SELECT building_name, COUNT(*)
FROM sections
GROUP BY building_name
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;

--display instructors whose names start or end with letter 'E'
SELECT prof_name 
FROM instructor
WHERE prof_name LIKE '%E%' 
AND prof_name LIKE '%A%';

SELECT prof_name 
FROM instructor
WHERE prof_name LIKE '%N';

SELECT prof_name 
FROM instructor
WHERE prof_name LIKE '%N%'

SELECT prof_name 
FROM instructor
WHERE prof_name NOT LIKE '%N%'

--display instructors whose names have 5 letters
SELECT prof_name 
FROM instructor
WHERE prof_name LIKE '_____';

--display instructors whose names have 2nd letter as E
SELECT prof_name 
FROM instructor
WHERE prof_name LIKE '_E%';

--display only the 3rd and 4th row
SELECT * FROM (
	SELECT row_number() over() AS r, dept_name
	FROM department
	ORDER BY r )
WHERE r < 5
EXCEPT
SELECT * FROM (
	SELECT row_number() over() AS r, dept_name
	FROM department
	ORDER BY r )
WHERE r < 3;

SELECT * FROM (
	SELECT row_number() over() AS r, dept_name
	FROM department
	ORDER BY r )
WHERE r = 2
UNION
SELECT * FROM (
	SELECT row_number() over() AS r, dept_name
	FROM department
	ORDER BY r )
WHERE r = 3;

SELECT * FROM (
	SELECT row_number() over() AS r, dept_name
	FROM department
	ORDER BY r )
WHERE r IN (2,5,7); 

--cartesian product
SELECT c.course_id, p.course_id
FROM course c, prereq p;

--outer join 2 tables
SELECT i.prof_name, d.dept_name, i.salary
FROM department d, instructor i
WHERE d.dept_id = i.dept_id
AND i.salary > 25000;

--outer join more than 2 tables
SELECT s.sec_id, c.dept_name, s.room_no, cl.capacity
FROM course c, sections s, classroom cl
WHERE c.course_id = s.course_id 
AND s.room_no = cl.room_no 
AND s.building_name = cl.building_name; 

--inner join
SELECT s.sec_id, cr.course_id, s.building_name, s.room_no, c.capacity
FROM sections s
INNER JOIN classroom c
ON s.building_name = c.building_name
AND s.room_no = c.room_no
INNER JOIN course cr
USING (course_id);

--left outer and right outer join
SELECT s.sec_id, s.building_name, s.room_no, c.room_no, c.capacity, s.course_id, cr.course_id
FROM sections s
LEFT JOIN classroom c
ON s.building_name = c.building_name
AND s.room_no = c.room_no
RIGHT JOIN course cr
ON s.course_id = cr.course_id;

--self join
SELECT staff.staff_name || ' works for ' ||  manager.staff_name as works_for
FROM non_teaching_staff staff, non_teaching_staff manager
WHERE staff.manager_id = manager.staff_id;

SELECT staff.staff_name || ' works for ' ||  manager.staff_name as works_for
FROM non_teaching_staff staff
JOIN non_teaching_staff manager
ON (staff.manager_id = manager.staff_id);

--select first and last row of a table
SELECT * FROM (
	SELECT row_number() over() as r, staff_id, staff_name, manager_id
	FROM non_teaching_staff )
WHERE r = 1
OR r = ( SELECT COUNT(*) FROM non_teaching_staff );

--select last 3 rows from a table
SELECT * FROM (
	SELECT row_number() over() as r, staff_id, staff_name, manager_id
	FROM non_teaching_staff )
WHERE r between
( SELECT COUNT(*) FROM non_teaching_staff ) - 2
AND 
( SELECT COUNT(*) FROM non_teaching_staff );

--select 3th highest salary
SELECT * FROM (
	SELECT row_number() over() as r, salary
	FROM (
		SELECT salary 
		FROM instructor
		ORDER BY salary DESC
		)
	)
WHERE r = 3;

--intersect
SELECT dept_name FROM course
INTERSECT
SELECT dept_name FROM department;

--use of on update cascade and on delete cascade
ALTER TABLE prereq
ADD CONSTRAINT fk_course_id
FOREIGN KEY (course_id)
REFERENCES course(course_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

SELECT p.prereq_id, c.course_id, c.fees
FROM prereq p
INNER JOIN course c
ON p.course_id = c.course_id;

UPDATE course
SET course_id = 115
WHERE course_id = 114;

--standard deviation
SELECT stddev(total_credits)
FROM student;

--display the no. of distinct departments from instructor table
SELECT COUNT(*) 
FROM (
	SELECT dept_name
	FROM student
	GROUP BY dept_name
);

SELECT COUNT(DISTINCT(dept_name)) 
FROM student;

--grouping multiple fields
SELECT SUM(salary), dept_id, prof_id
FROM instructor
GROUP BY (dept_id, prof_id);

--using group by and order by together
SELECT prof_name, SUM(salary) AS pay_roll
FROM instructor
GROUP BY prof_name
HAVING prof_name NOT LIKE '%A%'
ORDER BY pay_roll DESC;

--using two aggregate functions
SELECT MAX(avg_sal), dept_name
FROM (
	SELECT avg(salary) as avg_sal, dept_name
	FROM instructor
	GROUP BY dept_name
)
GROUP BY dept_name;

--multiple subqueries
select prof_id, prof_name, dept_id, salary
from instructor
where dept_id = (
	select dept_id
	from instructor
	where prof_id = 1521
)
and salary > (
	select salary 
	from instructor
	where prof_id = 1381
);

--using aggregating functions in subqueries
select prof_id, prof_name, salary
from instructor
where salary = (
	select min(salary) 
	from instructor
);

select dept_id, min(salary)
from instructor
group by dept_id
having min(salary) > (
	select min(salary)
	from instructor
	group by dept_id
	having dept_id = 128
);

--two agregator functions with subqueris. IMPORTANT !!
select dept_id, avg(salary)
from instructor
group by dept_id
having avg(salary) > (
	select min(sal)
	from (
		select avg(salary) as sal
		from instructor
		group by dept_id
	)
);

--lexcicographical ordering
select prof_name, dept_name 
from instructor
where dept_id = 110
or dept_id = 112
order by prof_name desc;

--
select prof_name, salary
from instructor
where 
(salary between 25000 and 30000)
and
(dept_id in (110,112));

--
select full_name 
from student 
where student_id is null;

--
select i.prof_name, d.dept_name, i.salary, d.budget
from instructor i
inner join department d
on (d.dept_id = i.dept_id)
order by i.salary, d.budget;

--
select * from (
	select i.prof_name, d.dept_name, 
	i.salary as sal, d.budget as bud
	from instructor i
	inner join department d
	on (d.dept_id = i.dept_id)
	)
where sal + bud < 60000;

--
select lower(prof_name), length(prof_name)
from instructor
where prof_name like 'A%'
or prof_name like 'E%'
or prof_name like 'T%'
order by prof_name;

--lpad
select dept_name, lpad(to_char(budget,'9,999'),10,'$') 
from department;

--current date and time
select now();

