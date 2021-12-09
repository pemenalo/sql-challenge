CREATE TABLE departments(
	dept_no VARCHAR(4) PRIMARY KEY,
	dept_name VARCHAR(20)
);

-- select * FROM departments;

CREATE TABLE titles(
	title_id VARCHAR(5) PRIMARY KEY,
	title VARCHAR(20) NOT NULL
);

-- select * FROM titles;

CREATE TABLE salaries(
	emp_no INT PRIMARY KEY,
	salary INT NOT NULL
);

-- select * FROM salaries;

CREATE TABLE employees(
	emp_no INT PRIMARY KEY,
	emp_title_id VARCHAR(5) NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	sex VARCHAR(1) NOT NULL,
	hire_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES salaries(emp_no),
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

-- select * FROM employees;

CREATE TABLE dept_emp(
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- select * FROM dept_emp;

CREATE TABLE dept_manager(
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	PRIMARY KEY (dept_no, emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

-- select * FROM dept_manager;

-- 1) List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
JOIN salaries ON employees.emp_no = salaries.emp_no;

-- 2) List first name, last name, and hire date for employees who were hired in 1986.

SELECT first_name, last_name, hire_date
FROM employees
WHERE employees.hire_date > '1986-1-1'::date
AND employees.hire_date < '1987-1-1'::date;

-- 3) List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM dept_manager
JOIN departments ON dept_manager.dept_no = departments.dept_no
JOIN employees ON dept_manager.emp_no = employees.emp_no;

-- 4) List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no;

-- 5) List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' and last_name LIKE 'B%';

-- 6) List all employees in the Sales department, including their employee number, last name, first name, and department name.

-- SELECT * FROM departments;
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_no = 'd007';

-- 7) List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

-- SELECT * FROM departments;
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_no = 'd005' or departments.dept_no = 'd007';

-- 8) In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT last_name, COUNT(last_name) AS "Frequency count"
FROM employees
GROUP BY last_name
ORDER BY "Frequency count" DESC;

-- Foolsday occures only once. Wow!

