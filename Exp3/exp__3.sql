
use ADBMS_1;

--------------------------------------MEDIUM-----------------------------------------------------------------
CREATE TABLE department (
    id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);


CREATE TABLE employee (
    id INT,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(id)
);



INSERT INTO department (id, dept_name) VALUES
(1, 'IT'),
(2, 'SALES');



INSERT INTO employee (id, name, salary, department_id) VALUES
(1, 'JOE', 70000, 1),
(2, 'JIM', 90000, 1),
(3, 'HENRY', 80000, 2),
(4, 'SAM', 60000, 2),
(5, 'MAX', 90000, 1);



select d.dept_name, e.name, e.salary
	from employee e INNER JOIN department d on e.department_id = d.id
	where salary in 
	(
		select max(e2.salary)
			from employee e2 where e2.department_id = e.department_id
	) 
	order by d.dept_name;


select d.dept_name, e.name, e.salary
	from employee e INNER JOIN department d on e.department_id = d.id
	where salary in 
	(
		select max(e2.salary)
			from employee e2 group by e2.department_id
	) 
	order by d.dept_name;

-----------------------------------------------HARD----------------------------------------

create table tab_a(
	EmpID int primary key,
	Ename varchar(5),
	Salary int
);


create table tab_b(
	EmpID int primary key,
	Ename varchar(5),
	Salary int
);


insert into tab_a values(1, 'AA', 1000), (2, 'BB', 300);


insert into tab_b values(2, 'BB', 400), (3, 'CC', 100);



with res_set as 
(	select a.* from tab_a a
	UNION ALL
	select b.* from tab_b b
)
select EmpID, Ename, min(Salary) as Salary from res_set r
	group by EmpID, Ename;