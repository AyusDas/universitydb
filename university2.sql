CREATE TABLE student (
	student_id int,
	full_name varchar(20) NOT NULL,
	dept_name varchar(20) NOT NULL,
	total_credits int NOT NULL,
	PRIMARY KEY ( student_id )
);

INSERT INTO student VALUES
(169, 'AYUS', 'MECHANICAL', 30),
(221, 'SAGNIK', 'MECHANICAL', 33),
(243, 'DEBAYAN', 'MECHANICAL', 38),
(177, 'SWAPNENDU', 'CHEMICAL', 42),
(178, 'DEBARNO', 'CHEMICAL', 37),
(128, 'RIDDHIMAN', 'ELECTRICAL', 39),
(167, 'AYAN', 'ELECTRICAL', 42);

SELECT * FROM student;


CREATE TABLE department (
	dept_id int,
	dept_name varchar(20) NOT NULL,
	building_name varchar(40) NOT NULL,
	budget int NOT NULL,
	PRIMARY KEY ( dept_id )
);

INSERT INTO department VALUES
(110, 'MECHANICAL', 'BLUE EARTH', 31000),
(112, 'ELECTRICAL', 'ILLUMINATION HALL', 36000),
(122, 'CIVIL', 'TEQUIP', 38000),
(177, 'METALURGY', 'LAKE SIDE HALL', 42000),
(178, 'COMPUTER', 'GANDHI BHAVAN', 37000),
(128, 'CHEMICAL', 'AUROBINDO BHAVAN', 39000);

SELECT * FROM department;


CREATE TABLE instructor (
	prof_id int,
	prof_name varchar(20) NOT NULL,
	dept_id int NOT NULL,
	dept_name varchar(20) NOT NULL,
	salary int NOT NULL,
	PRIMARY KEY ( prof_id )
);

INSERT INTO instructor VALUES
(1211, 'ANDREW', 110,'MECHANICAL', 28000),
(1521, 'LAUREN', 122,'CIVIL', 30000),
(1201, 'ELON', 110,'MECHANICAL', 28000),
(1471, 'TESLA', 112,'ELECTRICAL', 25000),
(1541, 'EDDISON', 122,'CIVIL', 25000),
(1451, 'FEYNMAN', 112,'ELECTRICAL', 75000),
(1361, 'JANE', 128,'CHEMICAL', 24000),
(1741, 'EMILY', 177,'METALURGY', 24000),
(1381, 'PEARL', 128,'CHEMICAL', 24000);

SELECT * FROM instructor;


CREATE TABLE course (
	course_id int,
    course_title varchar(40) NOT NULL,
    dept_name varchar(20) NOT NULL,
    credits int NOT NULL,
    fees int NOT NULL,
    PRIMARY KEY ( course_id ) 
);

INSERT INTO course VALUES 
(112, 'B.E. MECHANICAL (DAY)', 'MECHANICAL', 42, 10000),
(102, 'M.S. MECHANICAL (DAY)', 'MECHANICAL', 32, 12000),
(110, 'B.E. MECHANICAL (EVENING)', 'MECHANICAL', 32, 13000),
(100, 'M.S. MECHANICAL (EVENING)', 'MECHANICAL', 22, 14000),
(113, 'B.E. ELETRICAL (DAY)', 'ELECTRICAL', 42, 11000),
(103, 'M.S. ELETRICAL (DAY)', 'ELECTRICAL', 32, 11500),
(114, 'B.E. ELETRICAL (EVENING)', 'ELECTRICAL', 32, 15000),
(104, 'M.S. ELETRICAL (EVENING)', 'ELECTRICAL', 22, 13500);

SELECT * FROM course;


CREATE TABLE classroom (
	building_name varchar(40) NOT NULL,
    room_no varchar(10) NOT NULL,
    capacity int NOT NULL,
    PRIMARY KEY (building_name,room_no) 
); 

INSERT INTO classroom VALUES 
('BLUE EARTH', 'M321', 60),
('BLUE EARTH', 'M121', 50),
('TEQUIP', 'C111', 45),
('BLUE EARTH', 'M100', 55),
('TEQUIP', 'C101', 35),
('GANDHI BHAVAN', 'E220', 40),
('GANDHI BHAVAN', 'E223', 45),
('TEQUIP', 'C223', 35);

SELECT * FROM classroom;


CREATE TABLE sections (
	sec_id int NOT NULL,
	course_id int NOT NULL,
	semester int NOT NULL,
	current_year int NOT NULL,
	building_name varchar(40) NOT NULL,
	room_no varchar(10) NOT NULL,
	time_slot_id int,
	PRIMARY KEY ( sec_id, course_id, semester, current_year )
);

INSERT INTO sections VALUES 
(202, 112, 2, 4, 'BLUE EARTH', 'M321', 10),
(201, 102, 1, 2, 'BLUE EARTH', 'M121', 16),
(203, 303, 3, 2, 'TEQUIP', 'C111', 15),
(204, 110, 5, 3, 'BLUE EARTH', 'M100', 14),
(205, 301, 4, 2, 'TEQUIP', 'C101', 13),
(206, 113, 6, 3, 'GANDHI BHAVAN', 'E220', 17),
(207, 103, 7, 4,'GANDHI BHAVAN', 'E223', 12);

SELECT * FROM sections;


CREATE SEQUENCE dept01_id
INCREMENT BY 10
START WITH 120
MAXVALUE 300
NO CYCLE;

SELECT sequence_schema, sequence_name
FROM information_schema.sequences
ORDER BY sequence_name;

INSERT INTO department VALUES
(176,'PRODUCTION','ASHUTOSH BHAVAN',35000);

CREATE SEQUENCE prereq_id_seq
INCREMENT BY 10
START WITH 120
MAXVALUE 300
CACHE 1
NO CYCLE;

CREATE TABLE prereq (
	prereq_id int NOT NULL,
	course_id int NOT NULL,
	PRIMARY KEY ( prereq_id, course_id )
);

SELECT nextval('prereq_id_seq');
SELECT currval('prereq_id_seq');

INSERT INTO prereq VALUES
(nextval('prereq_id_seq'),100),
(nextval('prereq_id_seq'),113),
(nextval('prereq_id_seq'),104),
(nextval('prereq_id_seq'),114),
(nextval('prereq_id_seq'),103);

SELECT * FROM prereq;

CREATE INDEX classroom_idx
ON classroom(building_name);

--confirm all the present indexes
SELECT 
    schemaname, 
    tablename, 
    indexname, 
    indexdef
FROM 
    pg_indexes
WHERE 
    schemaname NOT IN ('pg_catalog', 'information_schema');

--creating a table for testing self join
CREATE TABLE non_teaching_staff (
staff_id int PRIMARY KEY,
staff_name varchar(20),
manager_id int
);

CREATE SEQUENCE staff_id_seq
INCREMENT BY 1
START WITH 710
MAXVALUE 721
CACHE 2
NO CYCLE;

INSERT INTO non_teaching_staff VALUES
(nextval('staff_id_seq'),'A',712),
(nextval('staff_id_seq'),'B',712),
(nextval('staff_id_seq'),'C',712),
(nextval('staff_id_seq'),'D',712),
(nextval('staff_id_seq'),'E',715),
(nextval('staff_id_seq'),'F',715),
(nextval('staff_id_seq'),'G',715),
(nextval('staff_id_seq'),'H',718),
(nextval('staff_id_seq'),'J',718),
(nextval('staff_id_seq'),'K',718);

SELECT * FROM non_teaching_staff;
