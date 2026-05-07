-- ====================================
-- Nova System - Database Schema
-- Learning Management System
-- ====================================

CREATE DATABASE IF NOT EXISTS nova_system;
USE nova_system;

-- ====================================
-- Users Table (Admin, Doctor, Student)
-- ====================================
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    role ENUM('admin', 'doctor', 'student') NOT NULL,
    phone VARCHAR(20),
    profile_image VARCHAR(255) DEFAULT NULL,
    bio TEXT,
    status ENUM('active', 'inactive', 'suspended') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX (email),
    INDEX (role),
    INDEX (status)
);

-- ====================================
-- Departments/Subjects Table
-- ====================================
CREATE TABLE departments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name_ar VARCHAR(255) NOT NULL,
    name_en VARCHAR(255) NOT NULL,
    description_ar TEXT,
    description_en TEXT,
    code VARCHAR(50) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX (code)
);

-- ====================================
-- Courses/Subjects Table
-- ====================================
CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name_ar VARCHAR(255) NOT NULL,
    name_en VARCHAR(255) NOT NULL,
    description_ar TEXT,
    description_en TEXT,
    code VARCHAR(50) UNIQUE NOT NULL,
    doctor_id INT NOT NULL,
    department_id INT NOT NULL,
    credit_hours INT DEFAULT 3,
    semester INT,
    year INT,
    capacity INT DEFAULT 50,
    status ENUM('active', 'inactive', 'archived') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (doctor_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE CASCADE,
    INDEX (doctor_id),
    INDEX (department_id),
    INDEX (code),
    INDEX (status)
);

-- ====================================
-- Course Sections (Lectures, Sections)
-- ====================================
CREATE TABLE course_sections (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT NOT NULL,
    title_ar VARCHAR(255) NOT NULL,
    title_en VARCHAR(255) NOT NULL,
    description_ar TEXT,
    description_en TEXT,
    section_number INT,
    type ENUM('lecture', 'session', 'tutorial') DEFAULT 'lecture',
    duration INT COMMENT 'in minutes',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    INDEX (course_id),
    INDEX (type)
);

-- ====================================
-- Course Materials/Lectures
-- ====================================
CREATE TABLE course_materials (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT NOT NULL,
    section_id INT,
    title_ar VARCHAR(255) NOT NULL,
    title_en VARCHAR(255) NOT NULL,
    description_ar TEXT,
    description_en TEXT,
    file_path VARCHAR(255) NOT NULL,
    file_type ENUM('pdf', 'video', 'image', 'document', 'other') NOT NULL,
    file_size INT COMMENT 'in bytes',
    uploaded_by INT NOT NULL,
    material_type ENUM('lecture', 'session', 'reference', 'assignment') DEFAULT 'lecture',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    FOREIGN KEY (section_id) REFERENCES course_sections(id) ON DELETE SET NULL,
    FOREIGN KEY (uploaded_by) REFERENCES users(id) ON DELETE CASCADE,
    INDEX (course_id),
    INDEX (uploaded_by),
    INDEX (material_type)
);

-- ====================================
-- Student Enrollment
-- ====================================
CREATE TABLE enrollments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_status ENUM('pending', 'approved', 'rejected', 'completed') DEFAULT 'pending',
    request_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    approval_date TIMESTAMP NULL,
    approved_by INT,
    rejection_reason TEXT,
    final_grade DECIMAL(5, 2),
    INDEX (student_id),
    INDEX (course_id),
    INDEX (enrollment_status),
    UNIQUE KEY unique_enrollment (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    FOREIGN KEY (approved_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ====================================
-- Assignments
-- ====================================
CREATE TABLE assignments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT NOT NULL,
    title_ar VARCHAR(255) NOT NULL,
    title_en VARCHAR(255) NOT NULL,
    description_ar TEXT,
    description_en TEXT,
    due_date DATETIME NOT NULL,
    total_points INT DEFAULT 100,
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE,
    INDEX (course_id),
    INDEX (due_date)
);

-- ====================================
-- Assignment Submissions
-- ====================================
CREATE TABLE assignment_submissions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    assignment_id INT NOT NULL,
    student_id INT NOT NULL,
    submission_file VARCHAR(255) NOT NULL,
    submission_text TEXT,
    submission_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    grade DECIMAL(5, 2),
    feedback TEXT,
    graded_by INT,
    graded_at TIMESTAMP NULL,
    status ENUM('submitted', 'graded', 'late') DEFAULT 'submitted',
    FOREIGN KEY (assignment_id) REFERENCES assignments(id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (graded_by) REFERENCES users(id) ON DELETE SET NULL,
    INDEX (assignment_id),
    INDEX (student_id),
    INDEX (status),
    UNIQUE KEY unique_submission (assignment_id, student_id)
);

-- ====================================
-- Quizzes
-- ====================================
CREATE TABLE quizzes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT NOT NULL,
    title_ar VARCHAR(255) NOT NULL,
    title_en VARCHAR(255) NOT NULL,
    description_ar TEXT,
    description_en TEXT,
    total_questions INT,
    total_points INT DEFAULT 100,
    time_limit INT COMMENT 'in minutes',
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    shuffle_questions BOOLEAN DEFAULT FALSE,
    show_answers BOOLEAN DEFAULT TRUE,
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE,
    INDEX (course_id)
);

-- ====================================
-- Quiz Questions
-- ====================================
CREATE TABLE quiz_questions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    quiz_id INT NOT NULL,
    question_text_ar TEXT NOT NULL,
    question_text_en TEXT NOT NULL,
    question_type ENUM('multiple_choice', 'true_false', 'short_answer') DEFAULT 'multiple_choice',
    points INT DEFAULT 1,
    question_order INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE,
    INDEX (quiz_id)
);

-- ====================================
-- Quiz Answers (Options)
-- ====================================
CREATE TABLE quiz_answers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    question_id INT NOT NULL,
    answer_text_ar TEXT NOT NULL,
    answer_text_en TEXT NOT NULL,
    is_correct BOOLEAN DEFAULT FALSE,
    answer_order INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (question_id) REFERENCES quiz_questions(id) ON DELETE CASCADE,
    INDEX (question_id)
);

-- ====================================
-- Student Quiz Attempts
-- ====================================
CREATE TABLE quiz_attempts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    quiz_id INT NOT NULL,
    student_id INT NOT NULL,
    start_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    end_time TIMESTAMP NULL,
    total_score DECIMAL(5, 2),
    percentage DECIMAL(5, 2),
    status ENUM('in_progress', 'submitted', 'graded') DEFAULT 'in_progress',
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX (quiz_id),
    INDEX (student_id),
    INDEX (status)
);

-- ====================================
-- Student Quiz Responses
-- ====================================
CREATE TABLE quiz_responses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    attempt_id INT NOT NULL,
    question_id INT NOT NULL,
    selected_answer_id INT,
    text_answer TEXT,
    is_correct BOOLEAN,
    points_earned DECIMAL(5, 2),
    FOREIGN KEY (attempt_id) REFERENCES quiz_attempts(id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES quiz_questions(id) ON DELETE CASCADE,
    FOREIGN KEY (selected_answer_id) REFERENCES quiz_answers(id) ON DELETE SET NULL,
    INDEX (attempt_id)
);

-- ====================================
-- Attendance
-- ====================================
CREATE TABLE attendance (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT NOT NULL,
    student_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    status ENUM('present', 'absent', 'late', 'excused') DEFAULT 'absent',
    notes TEXT,
    marked_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (marked_by) REFERENCES users(id) ON DELETE CASCADE,
    INDEX (course_id),
    INDEX (student_id),
    INDEX (attendance_date),
    UNIQUE KEY unique_attendance (course_id, student_id, attendance_date)
);

-- ====================================
-- Grades/Results
-- ====================================
CREATE TABLE grades (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT NOT NULL,
    student_id INT NOT NULL,
    grade_type ENUM('assignment', 'quiz', 'midterm', 'final', 'project') NOT NULL,
    points_earned DECIMAL(5, 2),
    total_points DECIMAL(5, 2),
    percentage DECIMAL(5, 2),
    weighted_points DECIMAL(5, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX (course_id),
    INDEX (student_id),
    INDEX (grade_type)
);

-- ====================================
-- Announcements
-- ====================================
CREATE TABLE announcements (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT,
    title_ar VARCHAR(255) NOT NULL,
    title_en VARCHAR(255) NOT NULL,
    content_ar TEXT NOT NULL,
    content_en TEXT NOT NULL,
    created_by INT NOT NULL,
    priority ENUM('low', 'medium', 'high', 'urgent') DEFAULT 'medium',
    is_pinned BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE,
    INDEX (course_id),
    INDEX (created_by)
);

-- ====================================
-- Admin Logs
-- ====================================
CREATE TABLE admin_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    admin_id INT NOT NULL,
    action VARCHAR(255) NOT NULL,
    table_name VARCHAR(100),
    record_id INT,
    description TEXT,
    old_values JSON,
    new_values JSON,
    ip_address VARCHAR(45),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (admin_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX (admin_id),
    INDEX (created_at)
);

-- ====================================
-- Settings
-- ====================================
CREATE TABLE settings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    setting_key VARCHAR(255) UNIQUE NOT NULL,
    setting_value LONGTEXT,
    setting_type ENUM('string', 'number', 'boolean', 'json') DEFAULT 'string',
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX (setting_key)
);

-- ====================================
-- Insert Default Settings
-- ====================================
INSERT INTO settings (setting_key, setting_value, setting_type, description) VALUES
('app_name', 'Nova System', 'string', 'Application Name'),
('app_version', '1.0.0', 'string', 'Application Version'),
('university_email_domain', 'btu.edu.eg', 'string', 'Allowed Email Domain'),
('language', 'ar', 'string', 'Default Language'),
('theme', 'light', 'string', 'Default Theme'),
('items_per_page', '10', 'number', 'Items per page in lists'),
('session_timeout', '3600', 'number', 'Session timeout in seconds'),
('maintenance_mode', 'false', 'boolean', 'Maintenance mode'),
('smtp_enabled', 'true', 'boolean', 'SMTP Email Enabled');

-- ====================================
-- Insert Test Users
-- ====================================
INSERT INTO users (email, password, first_name, last_name, role) VALUES
('admin@btu.edu.eg', SHA2('Admin@123', 256), 'Admin', 'System', 'admin'),
('doctor1@btu.edu.eg', SHA2('Doctor@123', 256), 'أحمد', 'محمد', 'doctor'),
('student1@btu.edu.eg', SHA2('Student@123', 256), 'هبة', 'أحمد', 'student'),
('student2@btu.edu.eg', SHA2('Student@123', 256), 'علي', 'محمود', 'student');

-- ====================================
-- Insert Test Departments
-- ====================================
INSERT INTO departments (name_ar, name_en, code) VALUES
('هندسة البرمجيات', 'Software Engineering', 'SE'),
('علوم الحاسب', 'Computer Science', 'CS'),
('نظم المعلومات', 'Information Systems', 'IS');

-- ====================================
-- Insert Test Course
-- ====================================
INSERT INTO courses (name_ar, name_en, code, doctor_id, department_id, semester, year) VALUES
('قواعد البيانات', 'Database Systems', 'CS101', 2, 2, 1, 2026),
('البرمجة بلغة PHP', 'PHP Programming', 'CS102', 2, 2, 1, 2026);

-- ====================================
-- Insert Test Enrollment
-- ====================================
INSERT INTO enrollments (student_id, course_id, enrollment_status, approval_date, approved_by) VALUES
(3, 1, 'approved', NOW(), 2),
(4, 1, 'pending', NULL, NULL);

CREATE INDEX idx_courses_status ON courses(status);
CREATE INDEX idx_enrollments_approval ON enrollments(enrollment_status, course_id);
CREATE INDEX idx_grades_course_student ON grades(course_id, student_id);
