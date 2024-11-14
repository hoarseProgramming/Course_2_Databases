
use ITHS;

drop table courses;
drop table studentsJoinExample;
drop table coursesStudentsJoinExample;

----------- Declare tables + junction table ---------------

create table courses
(
	id int,
	name nvarchar(max)
)

insert into courses values(1, 'C#');
insert into courses values(2, 'Data bases');
insert into courses values(3, 'Javascript');
insert into courses values(4, 'Data handling');
insert into courses values(5, 'Clean code');

create table studentsJoinExample
(
	id int,
	name nvarchar(max)
)

insert into studentsJoinExample values(1, 'Pelle');
insert into studentsJoinExample values(2, 'Rafael');
insert into studentsJoinExample values(3, 'Frida');
insert into studentsJoinExample values(4, 'Julia');
insert into studentsJoinExample values(5, 'Gunnar');
insert into studentsJoinExample values(6, 'Hampus');
insert into studentsJoinExample values(7, 'Felicia');

create table coursesStudentsJoinExample
(
	courseId int,
	studentId int
)

insert into coursesStudentsJoinExample values(1, 1)
insert into coursesStudentsJoinExample values(1, 4)
insert into coursesStudentsJoinExample values(1, 5)
insert into coursesStudentsJoinExample values(1, 7)
insert into coursesStudentsJoinExample values(2, 1)
insert into coursesStudentsJoinExample values(2, 4)
insert into coursesStudentsJoinExample values(2, 5)
insert into coursesStudentsJoinExample values(3, 3)
insert into coursesStudentsJoinExample values(3, 7)
insert into coursesStudentsJoinExample values(3, 2)
insert into coursesStudentsJoinExample values(4, 4)
insert into coursesStudentsJoinExample values(4, 5)
insert into coursesStudentsJoinExample values(4, 7)

select * from courses
select * from studentsJoinExample
select * from coursesStudentsJoinExample

--------------- Join Many-to-many -----------------

select
	s.name as 'Student',
	count(c.name) as 'Number of courses'
from
	courses c
	join coursesStudentsJoinExample cs on c.id = cs.courseId
	join studentsJoinExample s on s.id = cs.studentId
group by 
	s.name

select
	c.name as 'Course',
	count(s.name) as 'Number of students'
from
	courses c
	join coursesStudentsJoinExample cs on c.id = cs.courseId
	join studentsJoinExample s on s.id = cs.studentId
group by 
	c.name