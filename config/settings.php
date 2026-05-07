<?php
/**
 * Application Settings
 * Nova System - Learning Management System
 */

session_start();

// Set default language and theme from session or cookie
if (!isset($_SESSION['language'])) {
    $_SESSION['language'] = isset($_COOKIE['language']) ? $_COOKIE['language'] : 'ar';
}

if (!isset($_SESSION['theme'])) {
    $_SESSION['theme'] = isset($_COOKIE['theme']) ? $_COOKIE['theme'] : 'light';
}

// Language configuration
$languages = ['ar' => 'العربية', 'en' => 'English'];

// Themes configuration
$themes = [
    'light' => ['bg' => 'light', 'text' => 'dark', 'navbar' => 'navbar-light', 'card' => 'bg-light'],
    'dark' => ['bg' => 'dark', 'text' => 'light', 'navbar' => 'navbar-dark', 'card' => 'bg-dark']
];

// Get current language
$currentLanguage = $_SESSION['language'];
$currentTheme = $_SESSION['theme'];

// Language strings
$translations = [
    'ar' => [
        // Navigation
        'home' => 'الرئيسية',
        'login' => 'تسجيل الدخول',
        'logout' => 'تسجيل الخروج',
        'profile' => 'الملف الشخصي',
        'settings' => 'الإعدادات',
        'dashboard' => 'لوحة التحكم',
        'courses' => 'المواد',
        'students' => 'الطلاب',
        'teachers' => 'الأساتذة',
        'assignments' => 'الواجبات',
        'grades' => 'الدرجات',
        'attendance' => 'الحضور',
        
        // Common
        'welcome' => 'أهلا وسهلا',
        'submit' => 'إرسال',
        'cancel' => 'إلغاء',
        'delete' => 'حذف',
        'edit' => 'تعديل',
        'view' => 'عرض',
        'add' => 'إضافة',
        'save' => 'حفظ',
        'search' => 'بحث',
        'filter' => 'تصفية',
        'export' => 'تصدير',
        'import' => 'استيراد',
        'loading' => 'جاري التحميل...',
        'no_results' => 'لا توجد نتائج',
        'error' => 'حدث خطأ ما',
        'success' => 'تمت العملية بنجاح',
        'warning' => 'تحذير',
        'info' => 'معلومات',
        
        // Messages
        'login_required' => 'يجب تسجيل الدخول أولا',
        'unauthorized' => 'غير مصرح لك بهذا الإجراء',
        'not_found' => 'لم يتم العثور على المورد المطلوب',
        'invalid_email' => 'صيغة البريد الإلكتروني غير صحيحة',
        'invalid_password' => 'كلمة المرور غير صحيحة',
        'confirm_delete' => 'هل أنت متأكد من حذف هذا العنصر؟',
        
        // Form
        'email' => 'البريد الإلكتروني',
        'password' => 'كلمة المرور',
        'confirm_password' => 'تأكيد كلمة المرور',
        'first_name' => 'الاسم الأول',
        'last_name' => 'اسم العائلة',
        'phone' => 'الهاتف',
        'title' => 'العنوان',
        'description' => 'الوصف',
        'date' => 'التاريخ',
        'time' => 'الوقت',
        'file' => 'ملف',
        'required_field' => 'حقل مطلوب'
    ],
    'en' => [
        // Navigation
        'home' => 'Home',
        'login' => 'Login',
        'logout' => 'Logout',
        'profile' => 'Profile',
        'settings' => 'Settings',
        'dashboard' => 'Dashboard',
        'courses' => 'Courses',
        'students' => 'Students',
        'teachers' => 'Teachers',
        'assignments' => 'Assignments',
        'grades' => 'Grades',
        'attendance' => 'Attendance',
        
        // Common
        'welcome' => 'Welcome',
        'submit' => 'Submit',
        'cancel' => 'Cancel',
        'delete' => 'Delete',
        'edit' => 'Edit',
        'view' => 'View',
        'add' => 'Add',
        'save' => 'Save',
        'search' => 'Search',
        'filter' => 'Filter',
        'export' => 'Export',
        'import' => 'Import',
        'loading' => 'Loading...',
        'no_results' => 'No results found',
        'error' => 'An error occurred',
        'success' => 'Operation successful',
        'warning' => 'Warning',
        'info' => 'Information',
        
        // Messages
        'login_required' => 'You must login first',
        'unauthorized' => 'You are not authorized to perform this action',
        'not_found' => 'Resource not found',
        'invalid_email' => 'Invalid email format',
        'invalid_password' => 'Invalid password',
        'confirm_delete' => 'Are you sure you want to delete this item?',
        
        // Form
        'email' => 'Email',
        'password' => 'Password',
        'confirm_password' => 'Confirm Password',
        'first_name' => 'First Name',
        'last_name' => 'Last Name',
        'phone' => 'Phone',
        'title' => 'Title',
        'description' => 'Description',
        'date' => 'Date',
        'time' => 'Time',
        'file' => 'File',
        'required_field' => 'Required field'
    ]
];

// Helper function to get translation
function __($key, $language = null) {
    global $translations, $currentLanguage;
    $lang = $language ?? $currentLanguage;
    return $translations[$lang][$key] ?? $key;
}
