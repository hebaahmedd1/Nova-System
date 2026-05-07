<?php
/**
 * Application Constants
 * Nova System - Learning Management System
 */

// Application details
define('APP_NAME', 'Nova System');
define('APP_VERSION', '1.0.0');
define('APP_URL', 'http://localhost/Nova-System');
define('APP_TIMEZONE', 'Africa/Cairo');

// University Email Domain
define('UNIVERSITY_DOMAIN', 'btu.edu.eg');

// Security
define('SESSION_TIMEOUT', 3600); // 1 hour in seconds
define('PASSWORD_MIN_LENGTH', 8);
define('PASSWORD_HASH_ALGO', 'sha256');

// File Upload Settings
define('MAX_FILE_SIZE', 52428800); // 50MB in bytes
define('ALLOWED_FILE_TYPES', ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'txt', 'jpg', 'jpeg', 'png', 'gif', 'mp4', 'avi', 'mov']);
define('UPLOAD_PATH', __DIR__ . '/../uploads/');

// User Roles
define('ROLE_ADMIN', 'admin');
define('ROLE_DOCTOR', 'doctor');
define('ROLE_STUDENT', 'student');

const USER_ROLES = [
    'admin' => 'إدارة النظام',
    'doctor' => 'دكتور / أستاذ',
    'student' => 'طالب'
];

// User Status
const USER_STATUS = [
    'active' => 'نشط',
    'inactive' => 'غير نشط',
    'suspended' => 'معطل'
];

// Enrollment Status
const ENROLLMENT_STATUS = [
    'pending' => 'قيد الانتظار',
    'approved' => 'موافق عليه',
    'rejected' => 'مرفوض',
    'completed' => 'مكتمل'
];

// Attendance Status
const ATTENDANCE_STATUS = [
    'present' => 'حاضر',
    'absent' => 'غائب',
    'late' => 'متأخر',
    'excused' => 'معذور'
];

// Grade Types
const GRADE_TYPES = [
    'assignment' => 'واجب منزلي',
    'quiz' => 'اختبار قصير',
    'midterm' => 'امتحان منتصف الفصل',
    'final' => 'الامتحان النهائي',
    'project' => 'مشروع'
];

// Course Status
const COURSE_STATUS = [
    'active' => 'نشط',
    'inactive' => 'غير نشط',
    'archived' => 'مؤرشف'
];

// Material Types
const MATERIAL_TYPES = [
    'lecture' => 'محاضرة',
    'session' => 'سكشن',
    'reference' => 'مرجع',
    'assignment' => 'واجب'
];

// File Types
const FILE_TYPES = [
    'pdf' => 'PDF',
    'video' => 'فيديو',
    'image' => 'صورة',
    'document' => 'وثيقة',
    'other' => 'أخرى'
];

// Priority Levels
const PRIORITY_LEVELS = [
    'low' => 'منخفضة',
    'medium' => 'متوسطة',
    'high' => 'عالية',
    'urgent' => 'عاجل'
];

// Question Types
const QUESTION_TYPES = [
    'multiple_choice' => 'اختيار من متعدد',
    'true_false' => 'صح أم خطأ',
    'short_answer' => 'إجابة قصيرة'
];

// Quiz Status
const QUIZ_STATUS = [
    'in_progress' => 'جاري',
    'submitted' => 'مسلم',
    'graded' => 'مصحح'
];

// Pagination
define('ITEMS_PER_PAGE', 10);

// Messages
const MESSAGES = [
    'login_success' => 'تم تسجيل الدخول بنجاح',
    'login_error' => 'بيانات الدخول غير صحيحة',
    'logout_success' => 'تم تسجيل الخروج بنجاح',
    'unauthorized' => 'غير مصرح لك بهذا الإجراء',
    'not_found' => 'لم يتم العثور على الموارد المطلوبة',
    'success' => 'تم العملية بنجاح',
    'error' => 'حدث خطأ ما',
    'invalid_email' => 'البريد الإلكتروني غير صحيح',
    'email_required' => 'البريد الإلكتروني مطلوب',
    'password_required' => 'كلمة المرور مطلوبة'
];

date_default_timezone_set(APP_TIMEZONE);
