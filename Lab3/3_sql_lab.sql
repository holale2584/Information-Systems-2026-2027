-- q1: All info of all employees.
select *
from employees;

-- q2: All info of all departments.
select *
from departments;

-- q3: Full names of all employees.
select distinct first_name, last_name
from employees;

-- q4: Names of all departments.
select dept_name
from departments;

-- q5: Full names of employees working in “Sales” department.
select distinct e.first_name, e.last_name
from employees as e
join dept_emp as de
    on e.emp_no = de.emp_no
join departments as d
    on de.dept_no = d.dept_no
where d.dept_name = 'Sales';

-- q6: Full names of male employees working in “Finance” department.
select distinct e.first_name, e.last_name
from employees as e
join dept_emp as de
    on e.emp_no = de.emp_no
join departments as d
    on de.dept_no = d.dept_no
where d.dept_name = 'Finance' and e.gender = 'M';

-- q7: Salaries of female employees working in “Marketing” department.
select distinct s.salary
from employees as e
join dept_emp as de
    on e.emp_no = de.emp_no
join departments as d
    on de.dept_no = d.dept_no
join salaries as s
    on e.emp_no = s.emp_no
    and s.from_date < de.to_date and s.to_date > de.from_date
where d.dept_name = 'Marketing' and e.gender = 'F';

-- q8: Full names of employees who have the same last name as their manager.
select distinct e.first_name, e.last_name
from employees as e
join dept_emp as de
    on e.emp_no = de.emp_no
join dept_manager as dm
    on de.dept_no = dm.dept_no
    and de.from_date < dm.to_date and de.to_date > dm.from_date
join employees as m
    on dm.emp_no = m.emp_no
where e.last_name = m.last_name and e.emp_no <> m.emp_no;

-- q9: Full names of managers who have been doing the job at least twice.
select e.first_name, e.last_name
from employees as e
join dept_manager as dm
    on e.emp_no = dm.emp_no
group by e.emp_no, e.first_name, e.last_name
having count(*) >= 2;

-- q10: Full names of employees who was paid more than $100000.
select distinct e.first_name, e.last_name
from employees as e
join salaries as s
    on e.emp_no = s.emp_no
where s.salary > 100000;

-- q11: Names of all departments that have employees paid more than $100000.
select distinct d.dept_name
from departments as d
join dept_emp as de
    on d.dept_no = de.dept_no
join salaries as s
    on de.emp_no = s.emp_no
    and s.from_date < de.to_date and s.to_date > de.from_date
where s.salary > 100000;
