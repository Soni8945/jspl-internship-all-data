create table employee(emp_id INT, emp_name varchar(40),  emp_mail varchar(40), emp_lastname varchar(40));
select * from employee;

alter table employee add column is_active boolean default TRUE;

insert into employee( emp_id , emp_name , emp_mail , emp_lastname) values (101 , 'Rajat' , '2022csrajat12649@poornima.edu.in' ,'Soni');
select * from employee;

alter table employee add column last_submit TIMESTAMP;

update employee set last_submit = now()-interval '1 day' where emp_id = 101;
select emp_mail , emp_name from employee
where is_active = TRUE and last_submit<now()-interval '0 days';

select * from employee;





