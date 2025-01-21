create table student (
	s_id int primary key,
	s_name varchar(20) not null,
	dept_name varchar(20) not null
);

insert into student values
(1,'ayus','mech'),
(2,'ayus','elec');

select * from student;

create table student02 (
	s_id int primary key,
	s_name varchar(20) not null
);

insert into student02 values
(1,'ayus'),
(2,'ayus');

select * from student02;

create table dept03 (
	s_name varchar(20) not null,
	dept_name varchar(20) primary key
);

insert into dept03 values
('ayus','mech'),
('ayus','elec');

select * from dept03;

select *
from student02 s2
inner join dept03 d3
on s2.s_name = d3.s_name;

create table dept04 (
	s_id int not null,
	dept_name varchar(20) primary key
);

insert into dept04 values
(1,'mech'),
(2,'elec');

select * from dept04;

select s2.s_id, s2.s_name, d4.dept_name
from student02 s2
inner join dept04 d4
on s2.s_id = d4.s_id;

create table r1 (
	a11 int,
	b11 int,
	c11 int,
	primary key ( a11,b11 )
);

create table r2 (
	a21 int,
	b11 int,
	a11 int,
	primary key (a21),
	foreign key (a11, b11) references r1
);

create table t112 (
	a1 int,
	c1 int,
	primary key (a1),
	foreign key (c1)
	references t112(a1)
	on delete cascade
);

insert into t112 values
(2,4),(3,4),(4,3),(5,2),(7,2),(9,5),(6,4);

select * from t112;

delete from t112 
where a1 = 2 and c1 = 4;
