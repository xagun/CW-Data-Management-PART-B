
--1 Use appropriate data types and write the SQL statements to create the tables defined in the schema above

create table employee(
empId varchar2(10) not null primary key,
name varchar2(100),
address varchar2(100),
DOB date,
job varchar2(100),
salaryCode varchar2(10),
deptId varchar2(10),
manager varchar2(100),
schemeId varchar2(10));

create table department(
deptId varchar2(10) not null primary key,
name varchar2(100));


create table salarygrade(
salaryCode varchar2(10) not null primary key,
startSalary number,
finishSalary number );

create table pensionScheme(
schemeId varchar2(10) not null primary key,
name varchar2(100),
rate decimal(5,2) );


ALTER TABLE employee ADD CONSTRAINT salaryCode_FK FOREIGN KEY (salaryCode) REFERENCES salarygrade(salaryCode);
ALTER TABLE employee ADD CONSTRAINT deptId_FK FOREIGN KEY (deptId) REFERENCES department(deptId);
ALTER TABLE employee ADD CONSTRAINT schemeId_FK FOREIGN KEY (schemeId) REFERENCES pensionscheme(schemeId);





insert into department (deptid, name) values('D10', 'Administration');
insert into department (deptid, name) values('D20', 'Finance');
insert into department (deptid, name) values('D30', 'Sales');
insert into department (deptid, name) values('D40', 'Maintenance');
insert into department (deptid, name) values('D50', 'IT Support');


select * from department;


insert into salarygrade (salarycode, startsalary, finishsalary) values('S1', '15000', '18000');
insert into salarygrade (salarycode, startsalary, finishsalary) values('S2', '18001', '22000');
insert into salarygrade (salarycode, startsalary, finishsalary) values('S3', '22001', '25000');
insert into salarygrade (salarycode, startsalary, finishsalary) values('S4', '25001', '29000');
insert into salarygrade (salarycode, startsalary, finishsalary) values('S5', '29001', '38000');

select * from salarygrade;



insert into pensionscheme (schemeId, name, rate) values('S110', 'AXA', '0.5');
insert into pensionscheme (schemeId, name, rate) values('S121', 'Premier', '0.6');
insert into pensionscheme (schemeId, name, rate) values('S124', 'Stakeholder', '0.4');
insert into pensionscheme (schemeId, name, rate) values('S116', 'Standard', '0.4');

select * from pensionscheme;



insert into employee (empid, name, address, dob, job, salarycode, deptid, manager, schemeid) 
values('E101', 'Young, S.', '199 London Road', TO_DATE('1976-03-05','YYYY-MM-DD'), 'Clerk', 'S1','D10', 'E110', 'S116');
insert into employee (empid, name, address, dob, job, salarycode, deptid, manager, schemeid) 
values('E301', 'April, H.', '20 Glade close', TO_DATE('1979-03-10','YYYY-MM-DD'), 'Sales Person', 'S2','D30', 'E310', 'S124');
insert into employee (empid, name, address, dob, job, salarycode, deptid, manager, schemeid) 
values('E310', 'Newgate,E.', '10 Heap Street', TO_DATE('1980-11-28','YYYY-MM-DD'), 'Manager', 'S5','D30', '', 'S121');
insert into employee (empid, name, address, dob, job, salarycode, deptid, manager, schemeid) 
values('E501', 'Teach, E.', '22 railway road', TO_DATE('1972-02-12','YYYY-MM-DD'), 'Analyst', 'S5','D50', '', 'S121');
insert into employee (empid, name, address, dob, job, salarycode, deptid, manager, schemeid) 
values('E102', 'Hawkins, M.', '3 High Street', TO_DATE('1974-07-13','YYYY-MM-DD'), 'Clerk', 'S1','D10', 'E110', 'S116');
insert into employee (empid, name, address, dob, job, salarycode, deptid, manager, schemeid) 
values('E110', 'Watkins,J.', '11 crescent road', TO_DATE('1969-06-25','YYYY-MM-DD'), 'Manager', 'S5','D10', '', 'S121');

select * from employee;



--2--
--a The name (in ascending order), the starting salary and department id of each employee within a descending order of department ids.
select e.name, s.startsalary, d.deptid from
employee e 
join salarygrade s on s.salarycode = e.salarycode
join department d on d.deptid = e.deptid
order by e.name asc, d.deptid desc;


--b Give the number of employees for each of the pension schemes offered by the company. Result
--listing should include the name of each scheme and its corresponding number of employees
--who join the scheme
select distinct p.name,(select COUNT(*) from employee e where p.schemeid = e.schemeid) as employee_count 
from employee e join pensionscheme p on p.schemeid = e.schemeid; 


--c Give the total number of employees who are not managers but currently receive an annual salary of over £35,000.
select count(*) as total_no_of_employee from employee e 
inner join salarygrade s
on e.salarycode=s.salarycode
where s.finishsalary>35000 and e.empid NOT IN
(select manager from employee e where manager IS NOT NULL );


--d List the id and name of each employee along with his/her manager’s name.
select e.empid,e.name as employee_name ,e2.name as manager_name 
from employee e inner join employee e2
on e.manager=e2.empid;
