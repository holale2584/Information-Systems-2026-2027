-- q1: What is the average salary of each employee?
select emp_no, avg(salary) as average_salary
from salaries
group by emp_no;

-- q2: How much was each employee paid in total?
select emp_no, sum(salary) as total_salary
from salaries
group by emp_no;

-- q3: Minimum, maximum and total salaries of each department?
select
    d.dept_name,
    min(s.salary) as minimum_salary,
    max(s.salary) as maximum_salary,
    sum(s.salary) as total_salary
from departments as d
join dept_emp as de
    on d.dept_no = de.dept_no
join salaries as s
    on de.emp_no = s.emp_no
    and s.from_date < de.to_date and s.to_date > de.from_date
group by d.dept_no, d.dept_name;

-- q4: Which departments have paid more than 20 billion dollars for
-- their employees?
select d.dept_name, sum(s.salary) as total_salary
from departments as d
join dept_emp as de
    on d.dept_no = de.dept_no
join salaries as s
    on de.emp_no = s.emp_no
    and s.from_date < de.to_date and s.to_date > de.from_date
group by d.dept_no, d.dept_name
having sum(s.salary) > 20000000000;

-- q5: Total salaries of male employees in each department?
select d.dept_name, sum(s.salary) as total_salary
from departments as d
join dept_emp as de
    on d.dept_no = de.dept_no
join employees as e
    on de.emp_no = e.emp_no
join salaries as s
    on de.emp_no = s.emp_no
    and s.from_date < de.to_date and s.to_date > de.from_date
where e.gender = 'M'
group by d.dept_no, d.dept_name;

-- q6: Total salaries of department managers for each department,
-- from highest to lowest?
select d.dept_name, sum(s.salary) as total_salary
from departments as d
join dept_manager as dm
    on d.dept_no = dm.dept_no
join salaries as s
    on dm.emp_no = s.emp_no
    and s.from_date < dm.to_date and s.to_date > dm.from_date
group by d.dept_no, d.dept_name
order by total_salary desc;
