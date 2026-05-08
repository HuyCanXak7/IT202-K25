CREATE DATABASE CompanyDB;
USE CompanyDB;
CREATE TABLE Department (
dept_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
dept_name VARCHAR(100) NOT NULL,
location VARCHAR(100)
);

CREATE TABLE Employee (
emp_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
emp_name VARCHAR(100) NOT NULL,
gender INT DEFAULT 1,
birth_date DATE,
salary DECIMAL(12,2),
dept_id INT,
FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Project (
project_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
project_name VARCHAR(150) NOT NULL,
emp_id INT,
FOREIGN KEY (emp_id) REFERENCES Employee(emp_id),
start_date DATE DEFAULT (CURRENT_DATE),
end_date DATE
);

ALTER TABLE `companydb`.`employee` 
ADD COLUMN `email` VARCHAR(100) NULL AFTER `dept_id`,
ADD UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE;
;

ALTER TABLE `companydb`.`project` 
CHANGE COLUMN `project_name` `project_name` VARCHAR(200) NOT NULL ;

ALTER TABLE Project
ADD CONSTRAINT chk_end_date 
CHECK (end_date IS NULL OR (end_date)>=(start_date) ) ;

INSERT INTO `companydb`.`department` (`dept_id`, `dept_name`, `location`) VALUES ('1', 'IT', 'Ha Noi');
INSERT INTO `companydb`.`department` (`dept_id`, `dept_name`, `location`) VALUES ('2', 'HR', 'HCM');
INSERT INTO `companydb`.`department` (`dept_id`, `dept_name`, `location`) VALUES ('3', 'Marketing', 'Da Nang');

INSERT INTO `companydb`.`employee` (`emp_id`, `emp_name`, `gender`, `birth_date`, `salary`, `dept_id`, `email`) VALUES ('1', 'Nguyen Van A', '1', '1990-01-15', '1500', '1', 'a@gmail.com');
INSERT INTO `companydb`.`employee` (`emp_id`, `emp_name`, `gender`, `birth_date`, `salary`, `dept_id`, `email`) VALUES ('2', 'Tran Thi B', '0', '1995-05-20', '1200', '1', 'b@gmail.com');
INSERT INTO `companydb`.`employee` (`emp_id`, `emp_name`, `gender`, `birth_date`, `salary`, `dept_id`, `email`) VALUES ('3', 'Le Minh C', '1', '1988-10-10', '2000', '2', 'c@gmail.com');
INSERT INTO `companydb`.`employee` (`emp_id`, `emp_name`, `gender`, `birth_date`, `salary`, `dept_id`, `email`) VALUES ('4', 'Pham Thi D', '0', '1992-12-05', '1800', '3', 'd@gmail.com');


INSERT INTO `companydb`.`project` (`project_id`, `project_name`, `emp_id`, `start_date`, `end_date`) VALUES ('101', 'Website Redesign', '1', '2024-01-01', '2024-06-01');
INSERT INTO `companydb`.`project` (`project_id`, `project_name`, `emp_id`, `start_date`, `end_date`) VALUES ('102', 'Recruitment System', '3', '2024-02-01', '2024-08-01');
INSERT INTO `companydb`.`project` (`project_id`, `project_name`, `emp_id`, `start_date`) VALUES ('103', 'Marketing Campaign', '4', '2024-03-01');

