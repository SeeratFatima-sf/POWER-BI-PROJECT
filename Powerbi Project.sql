CREATE DATABASE EducationManagement2;
USE EducationManagement2;

CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) UNIQUE NOT NULL
);


CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    dob DATE,
    gender ENUM('Male', 'Female', 'Other'),
    address TEXT,
    department_id INT,
    enrollment_year YEAR,
    status ENUM('Active', 'Graduated', 'Dropped'),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);


CREATE TABLE Instructors (
    instructor_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    hire_date DATE,
    department_id INT,
    salary DECIMAL(10,2),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);




CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    course_code VARCHAR(10) UNIQUE NOT NULL,
    credit_hours INT CHECK (credit_hours > 0),
    department_id INT,
    instructor_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id)
);

CREATE TABLE Subjects (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_name VARCHAR(100) NOT NULL,
    course_id INT,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);


CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    semester ENUM('Spring', 'Fall'),
    year YEAR,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);


CREATE TABLE Grades (
    grade_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    grade ENUM('A+', 'A', 'B+', 'B', 'C+', 'C', 'D', 'F'),
    gpa DECIMAL(3,2),
    remarks TEXT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);



CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    date DATE,
    status ENUM('Present', 'Absent', 'Late'),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);


CREATE TABLE ClassroomAssignments (
    assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT,
    room_no VARCHAR(10),
    schedule VARCHAR(50),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);


CREATE TABLE Fees (
    fee_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    amount DECIMAL(10,2),
    due_date DATE,
    status ENUM('Paid', 'Pending', 'Overdue'),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);


CREATE TABLE PerformanceReports (
    report_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    semester ENUM('Spring', 'Fall'),
    year YEAR,
    overall_gpa DECIMAL(3,2),
    total_credits INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);


CREATE TABLE LookupTable (
    lookup_id INT PRIMARY KEY AUTO_INCREMENT,
    category VARCHAR(50),
    lookup_value VARCHAR(50),  -- Changed from `name` for clarity
    value VARCHAR(100)
);


INSERT INTO Students (student_id, full_name, dob, gender, email, phone, address, enrollment_year) VALUES
(1, 'Ali Khan', '2003-05-12', 'Male', 'ali.khan@email.com', '03001234567', 'Lahore', 2022),
(2, 'Ayesha Ahmed', '2004-07-25', 'Female', 'ayesha.ahmed@email.com', '03019876543', 'Karachi', 2021),
(3, 'Bilal Raza', '2002-09-10', 'Male', 'bilal.raza@email.com', '03021234567', 'Islamabad', 2023),
(4, 'Zainab Noor', '2001-02-15', 'Female', 'zainab.noor@email.com', '03031234567', 'Faisalabad', 2020),
(5, 'Hassan Mehmood', '2000-11-05', 'Male', 'hassan.m@email.com', '03041234567', 'Rawalpindi', 2019),
(6, 'Fatima Sajid', '2003-08-22', 'Female', 'fatima.sajid@email.com', '03051234567', 'Multan', 2022),
(7, 'Usman Tariq', '2002-03-30', 'Male', 'usman.tariq@email.com', '03061234567', 'Peshawar', 2023),
(8, 'Maha Riaz', '2004-06-18', 'Female', 'maha.riaz@email.com', '03071234567', 'Sialkot', 2021),
(9, 'Tariq Jameel', '2001-01-10', 'Male', 'tariq.j@email.com', '03081234567', 'Bahawalpur', 2020),
(10, 'Sana Mir', '2000-09-27', 'Female', 'sana.mir@email.com', '03091234567', 'Quetta', 2019);

INSERT INTO Instructors (instructor_id, full_name, email, phone, department_id) VALUES
(101, 'Dr. Hina Shah', 'hina.shah@university.com', '03211234567', 1),
(102, 'Mr. Ahmed Iqbal', 'ahmed.iqbal@university.com', '03451234567', 2),
(103, 'Ms. Rabia Khan', 'rabia.khan@university.com', '03121234567', 3),
(104, 'Dr. Waqas Ahmed', 'waqas.ahmed@university.com', '03331234567', 4),
(105, 'Mr. Saad Farooq', 'saad.farooq@university.com', '03241234567', 5);



INSERT INTO Courses (course_id, course_code, course_name, instructor_id, credit_hours) 
VALUES 
(201, 'DSB101', 'Data Science Basics', 101, 3),
(202, 'ML102', 'Machine Learning', 101, 4),
(203, 'CALC101', 'Calculus I', 102, 3),
(204, 'BM103', 'Business Management', 103, 3),
(205, 'PHY101', 'Physics for Engineers', 104, 3),
(206, 'ECO101', 'Microeconomics', 105, 3),
(207, 'APP101', 'Advanced Python Programming', 101, 4);


INSERT INTO Enrollments (student_id, course_id, semester) VALUES
(1, 201, 'Spring'), (1, 202, 'Spring'), (2, 202, 'Spring'),
(2, 204, 'Spring'), (3, 203, 'Fall'), (3, 201, 'Fall'),
(4, 205, 'Spring'), (4, 206, 'Fall'), (5, 207, 'Spring'),
(5, 204, 'Fall'), (6, 203, 'Spring'), (6, 205, 'Spring'),
(7, 201, 'Fall'), (7, 202, 'Fall'), (8, 206, 'Spring'),
(8, 207, 'Spring'), (9, 202, 'Spring'), (9, 204, 'Spring'),
(10, 203, 'Spring'), (10, 205, 'Spring');



INSERT INTO Grades (student_id, course_id, grade) VALUES
(1, 201, 3.8), (1, 202, 3.5), (2, 202, 3.9), (2, 204, 2.8), (3, 203, 3.2),
(3, 201, 3.7), (4, 205, 2.5), (4, 206, 3.3), (5, 207, 3.6), (5, 204, 2.9),
(6, 203, 3.1), (6, 205, 3.4), (7, 201, 3.8), (7, 202, 2.6), (8, 206, 3.0),
(8, 207, 3.5), (9, 202, 3.7), (9, 204, 2.8), (10, 203, 3.3), (10, 205, 2.9);


INSERT INTO Attendance (student_id, course_id, date, status) VALUES
(1, 201, '2024-02-01', 'Present'), (1, 201, '2024-02-02', 'Absent'),
(2, 202, '2024-02-01', 'Present'), (2, 204, '2024-02-02', 'Absent'),
(3, 203, '2024-02-01', 'Present'), (3, 201, '2024-02-02', 'Absent'),
(4, 205, '2024-02-01', 'Present'), (4, 206, '2024-02-02', 'Absent'),
(5, 207, '2024-02-01', 'Absent'), (5, 204, '2024-02-02', 'Present'),
(6, 203, '2024-02-01', 'Present'), (6, 205, '2024-02-02', 'Absent'),
(7, 201, '2024-02-01', 'Absent'), (7, 202, '2024-02-02', 'Present'),
(8, 206, '2024-02-01', 'Present'), (8, 207, '2024-02-02', 'Absent'),
(9, 202, '2024-02-01', 'Present'), (9, 204, '2024-02-02', 'Absent'),
(10, 203, '2024-02-01', 'Absent'), (10, 205, '2024-02-02', 'Present');

INSERT INTO Fees (student_id, amount, due_date, payment_status_id) 
SELECT 1, 50000, '2024-03-01', lookup_id FROM LookupTable WHERE lookup_value = 'Paid'
UNION ALL
SELECT 2, 50000, '2024-03-01', lookup_id FROM LookupTable WHERE lookup_value = 'Partial'
UNION ALL
SELECT 3, 50000, '2024-03-01', lookup_id FROM LookupTable WHERE lookup_value = 'Unpaid'
UNION ALL
SELECT 4, 50000, '2024-03-01', lookup_id FROM LookupTable WHERE lookup_value = 'Paid'
UNION ALL
SELECT 5, 50000, '2024-03-01', lookup_id FROM LookupTable WHERE lookup_value = 'Partial'
UNION ALL
SELECT 6, 50000, '2024-03-01', lookup_id FROM LookupTable WHERE lookup_value = 'Unpaid'
UNION ALL
SELECT 7, 50000, '2024-03-01', lookup_id FROM LookupTable WHERE lookup_value = 'Paid'
UNION ALL
SELECT 8, 50000, '2024-03-01', lookup_id FROM LookupTable WHERE lookup_value = 'Partial'
UNION ALL
SELECT 9, 50000, '2024-03-01', lookup_id FROM LookupTable WHERE lookup_value = 'Unpaid'
UNION ALL
SELECT 10, 50000, '2024-03-01', lookup_id FROM LookupTable WHERE lookup_value = 'Paid';



INSERT INTO Departments (department_id, name) VALUES
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'Business Administration'),
(4, 'Physics'),
(5, 'Economics');

INSERT INTO Subjects (subject_name, course_id) VALUES
('Data Structures', 201),
('Algorithms', 201),
('Database Management Systems', 201),
('Operating Systems', 201),
('Machine Learning', 202),
('Deep Learning', 202),
('Statistics for Data Science', 202),
('Linear Algebra', 203),
('Calculus', 203),
('Business Finance', 204),
('Marketing Strategies', 204),
('Quantum Physics', 205),
('Classical Mechanics', 205),
('Microeconomics', 206),
('Macroeconomics', 206);



INSERT INTO ClassroomAssignments (course_id, room_no, schedule) VALUES
(201, 'CS101', 'Mon-Wed-Fri 10:00 AM - 11:30 AM'),
(201, 'CS102', 'Tue-Thu 2:00 PM - 3:30 PM'),
(202, 'DS201', 'Mon-Wed 9:00 AM - 10:30 AM'),
(202, 'DS202', 'Fri 12:00 PM - 1:30 PM'),
(203, 'MATH301', 'Tue-Thu 11:00 AM - 12:30 PM'),
(203, 'MATH302', 'Mon-Wed 3:00 PM - 4:30 PM'),
(204, 'BUS401', 'Tue-Thu 1:00 PM - 2:30 PM'),
(205, 'PHYS501', 'Mon-Wed 8:00 AM - 9:30 AM'),
(206, 'ECO601', 'Fri 10:00 AM - 11:30 AM'),
(206, 'ECO602', 'Tue-Thu 4:00 PM - 5:30 PM');


INSERT INTO PerformanceReports (student_id, semester, year, overall_gpa, total_credits) VALUES
(1, 'Spring', 2023, 3.85, 15),
(2, 'Fall', 2023, 3.50, 14),
(3, 'Spring', 2024, 3.70, 16),
(4, 'Fall', 2023, 3.20, 12),
(5, 'Spring', 2023, 3.90, 18),
(6, 'Fall', 2022, 2.95, 13),
(7, 'Spring', 2024, 3.60, 17),
(8, 'Fall', 2023, 3.10, 12),
(9, 'Spring', 2023, 2.80, 14),
(10, 'Fall', 2022, 3.75, 15);

INSERT INTO LookupTable (category, lookup_value, value) VALUES
-- Student Statuses
('Student Status', 'Active', 'Currently enrolled'),
('Student Status', 'Graduated', 'Completed the degree'),
('Student Status', 'Dropped', 'Left without completing the program'),

-- Instructor Roles
('Instructor Role', 'Professor', 'Senior faculty member'),
('Instructor Role', 'Assistant Professor', 'Mid-level faculty'),
('Instructor Role', 'Lecturer', 'Junior faculty'),

-- Payment Status
('Payment Status', 'Paid', 'Fee has been fully paid'),
('Payment Status', 'Partial', 'Partially paid'),
('Payment Status', 'Unpaid', 'No payment made'),

-- Course Categories
('Course Category', 'Programming', 'Courses related to coding and development'),
('Course Category', 'Mathematics', 'Courses related to pure and applied math'),
('Course Category', 'Business', 'Courses related to finance and management'),
('Course Category', 'Data Science', 'Courses focused on AI, ML, and analytics');

UPDATE Students
SET status = (
    CASE
        WHEN status = 'Active' THEN (SELECT lookup_id FROM LookupTable WHERE lookup_value = 'Active')
        WHEN status = 'Graduated' THEN (SELECT lookup_id FROM LookupTable WHERE lookup_value = 'Graduated')
        WHEN status = 'Dropped' THEN (SELECT lookup_id FROM LookupTable WHERE lookup_value = 'Dropped')
    END
)
WHERE student_id IS NOT NULL; 


ALTER TABLE Students DROP COLUMN status;  
ALTER TABLE Students ADD COLUMN student_status_id INT;  
ALTER TABLE Students ADD FOREIGN KEY (student_status_id) REFERENCES LookupTable(lookup_id);

ALTER TABLE Instructors ADD COLUMN role_id INT;
ALTER TABLE Instructors ADD FOREIGN KEY (role_id) REFERENCES LookupTable(lookup_id);

ALTER TABLE Fees DROP COLUMN status;  


ALTER TABLE Fees ADD COLUMN payment_status_id INT;

ALTER TABLE Fees ADD FOREIGN KEY (payment_status_id) REFERENCES LookupTable(lookup_id);

ALTER TABLE Courses ADD COLUMN category_id INT;
ALTER TABLE Courses ADD FOREIGN KEY (category_id) REFERENCES LookupTable(lookup_id);
