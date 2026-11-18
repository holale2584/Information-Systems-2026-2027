-- q12: Merge Development (d005) and Research (d008) into Research and
-- Development (d010), and Marketing (d001) and Sales (d007) into
-- Marketing and Sales (d011).
start transaction;

insert into departments (dept_no, dept_name)
values ('d010', 'Research and Development'),
       ('d011', 'Marketing and Sales');

insert into dept_emp (emp_no, dept_no, from_date, to_date)
select
    de.emp_no,
    m.new_dept_no,
    min(de.from_date),
    max(de.to_date)
from dept_emp as de
join (
    select 'd005' as old_dept_no, 'd010' as new_dept_no
    union all select 'd008', 'd010'
    union all select 'd001', 'd011'
    union all select 'd007', 'd011'
) as m
    on de.dept_no = m.old_dept_no
group by de.emp_no, m.new_dept_no;

insert into dept_manager (emp_no, dept_no, from_date, to_date)
select
    dm.emp_no,
    m.new_dept_no,
    min(dm.from_date),
    max(dm.to_date)
from dept_manager as dm
join (
    select 'd005' as old_dept_no, 'd010' as new_dept_no
    union all select 'd008', 'd010'
    union all select 'd001', 'd011'
    union all select 'd007', 'd011'
) as m
    on dm.dept_no = m.old_dept_no
group by dm.emp_no, m.new_dept_no;

delete from departments
where dept_no in ('d005', 'd008', 'd001', 'd007');

commit;
