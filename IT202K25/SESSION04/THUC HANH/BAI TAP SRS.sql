CREATE DATABASE elearning;
USE elearning;

CREATE TABLE Student(
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(255) NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE Teacher(
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    teacher_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE Course(
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    teacher_id INT NOT NULL,
    course_description TEXT,
    course_session INT CHECK(course_session >= 1),
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

CREATE TABLE Enrollment(
    student_id INT,
    course_id INT,
    enrollment_date DATE DEFAULT (CURDATE()),
    PRIMARY KEY(student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

CREATE TABLE Score(
    student_id INT,
    course_id INT,
    mid_score DECIMAL(4,2) CHECK(mid_score BETWEEN 0 AND 10),
    final_score DECIMAL(4,2) CHECK(final_score BETWEEN 0 AND 10),
    PRIMARY KEY(student_id, course_id),
    FOREIGN KEY (student_id, course_id)
        REFERENCES Enrollment(student_id, course_id)
);

INSERT INTO Teacher (teacher_name, email) VALUES
('Nguyễn Văn A', 'a@gmail.com'),
('Trần Thị B', 'b@gmail.com'),
('Lê Văn C', 'c@gmail.com');

INSERT INTO Student (student_name, dob, email) VALUES
('Phạm Minh Huy', '2003-05-10', 'huy@gmail.com'),
('Nguyễn Hoàng An', '2002-11-20', 'an@gmail.com'),
('Trần Quốc Bảo', '2003-08-15', 'bao@gmail.com'),
('Lê Thị Mai', '2004-01-25', 'mai@gmail.com'),
('Đỗ Văn Nam', '2003-03-12', 'nam@gmail.com');

INSERT INTO Course (course_name, teacher_id, course_description, course_session) VALUES
('SQL Cơ Bản', 1, 'Học SQL từ cơ bản đến nâng cao', 20),
('Lập trình Java', 2, 'Java core + OOP', 25),
('Thiết kế Web', 3, 'HTML, CSS, JS', 15),
('Cấu trúc dữ liệu', 1, 'DSA cơ bản', 30);

INSERT INTO Enrollment (student_id, course_id, enrollment_date) VALUES
(1, 1, '2026-01-10'),
(1, 2, '2026-01-12'),
(2, 1, '2026-01-11'),
(2, 3, '2026-01-15'),
(3, 2, '2026-01-13'),
(3, 4, '2026-01-20'),
(4, 3, '2026-01-18'),
(5, 1, '2026-01-14'),
(5, 4, '2026-01-22');

INSERT INTO Score (student_id, course_id, mid_score, final_score) VALUES
(1, 1, 7.5, 8.0),
(1, 2, 6.0, 7.0),
(2, 1, 8.0, 8.5),
(2, 3, 7.0, 7.5),
(3, 2, 5.5, 6.5),
(3, 4, 6.0, 6.0),
(4, 3, 9.0, 9.5),
(5, 1, 4.5, 5.5),
(5, 4, 7.0, 8.0);

SELECT s.student_name, c.course_name, sc.mid_score, sc.final_score
FROM Score sc
JOIN Student s ON sc.student_id = s.student_id
JOIN Course c ON sc.course_id = c.course_id;
