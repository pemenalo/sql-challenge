employees
--
emp_no INT PK FK >- salaries.emp_no
emp_title VARCHAR(5) FK >- titles.title_id
birth_date DATE
first_name VARCHAR(20)
last_name VARCHAR(20)
sex VARCHAR(1)
hire_date DATE

titles
--
title_id VARCHAR(5) PK
title VARCHAR(20)

dept_emp
--
emp_no INT PK FK >- employees.emp_no
dept_no VARCHAR(4) PK FK >- departments.dept_no

dept_manager
--
dept_no VARCHAR(4) PK FK >- departments.dept_no
emp_no INT PK FK >- employees.emp_no

salaries
--
emp_no INT PK
salary INT

departments
--
dept_no VARCHAR(4) PK
dept_name VARCHAR(20)