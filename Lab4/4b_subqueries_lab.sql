-- q1: Who have the same name as the managers of the “Finance” department?
select e.emp_no, e.first_name, e.last_name
from employees as e
where exists (
    select 1
    from dept_manager as dm
    join departments as d
        on dm.dept_no = d.dept_no
    join employees as m
        on dm.emp_no = m.emp_no
    where d.dept_name = 'Finance'
        and m.first_name = e.first_name and m.last_name = e.last_name
        and m.emp_no <> e.emp_no
);

-- q2: Who in the “Production” department were hired after the
-- promotion of the last manager in that department?
select e.emp_no, e.first_name, e.last_name
from employees as e
where e.emp_no in (
    select de.emp_no
    from dept_emp as de
    join departments as d
        on de.dept_no = d.dept_no
    where d.dept_name = 'Production'
)
and e.hire_date > (
    select max(dm.from_date)
    from dept_manager as dm
    join departments as d
        on dm.dept_no = d.dept_no
    where d.dept_name = 'Production'
);

-- q3: Find the average salary of each department, from highest to lowest.
select d.dept_name, ds.average_salary
from departments as d
join (
    select de.dept_no, avg(s.salary) as average_salary
    from dept_emp as de
    join salaries as s
        on de.emp_no = s.emp_no
        and s.from_date < de.to_date and s.to_date > de.from_date
    group by de.dept_no
) as ds
    on d.dept_no = ds.dept_no
order by ds.average_salary desc;

-- q4: Find the average salary for each type of Engineer, from highest to lowest.
select es.title, avg(es.salary) as average_salary
from (
    select distinct t.title, s.emp_no, s.from_date, s.salary
    from titles as t
    join salaries as s
        on t.emp_no = s.emp_no
        and s.from_date < t.to_date and s.to_date > t.from_date
    where t.title like '%Engineer%'
) as es
group by es.title
order by average_salary desc;
