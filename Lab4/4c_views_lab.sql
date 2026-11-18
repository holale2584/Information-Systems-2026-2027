-- q1: Who have the same name as the managers of the “Finance” department?
create or replace view finance_managers as
select m.emp_no, m.first_name, m.last_name
from dept_manager as dm
join departments as d
    on dm.dept_no = d.dept_no
join employees as m
    on dm.emp_no = m.emp_no
where d.dept_name = 'Finance';

select distinct e.emp_no, e.first_name, e.last_name
from employees as e
join finance_managers as m
    on e.first_name = m.first_name and e.last_name = m.last_name
    and e.emp_no <> m.emp_no;

-- q2: Who in the “Production” department were hired after the
-- promotion of the last manager in that department?
create or replace view last_production_manager_promotion as
select d.dept_no, max(dm.from_date) as promotion_date
from dept_manager as dm
join departments as d
    on dm.dept_no = d.dept_no
where d.dept_name = 'Production'
group by d.dept_no;

select e.emp_no, e.first_name, e.last_name
from last_production_manager_promotion as p
join dept_emp as de
    on p.dept_no = de.dept_no
join employees as e
    on de.emp_no = e.emp_no
where e.hire_date > p.promotion_date;

-- q3: Find the average salary of each department, from highest to lowest.
create or replace view department_average_salaries as
select d.dept_name, avg(s.salary) as average_salary
from departments as d
join dept_emp as de
    on d.dept_no = de.dept_no
join salaries as s
    on de.emp_no = s.emp_no
    and s.from_date < de.to_date and s.to_date > de.from_date
group by d.dept_no, d.dept_name;

select dept_name, average_salary
from department_average_salaries
order by average_salary desc;

-- q4: Find the average salary for each type of Engineer, from highest to lowest.
create or replace view engineer_salaries as
select distinct t.title, s.emp_no, s.from_date, s.salary
from titles as t
join salaries as s
    on t.emp_no = s.emp_no
    and s.from_date < t.to_date and s.to_date > t.from_date
where t.title like '%Engineer%';

select title, avg(salary) as average_salary
from engineer_salaries
group by title
order by average_salary desc;
