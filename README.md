# Nova System - Learning Management System 🎓

نظام إدارة التعلم الإلكتروني للجامعات | A comprehensive LMS for universities

## ✨ Features

### 📱 Multi-language & Theme Support
- 🌐 Arabic / English
- 🌙 Dark / Light Mode
- 📱 Fully Responsive Design

### 👥 Three Main Roles
1. **Admin (الإدارة)** - System Management
2. **Doctor (الدكتور)** - Course Management
3. **Student (الطالب)** - Learning Experience

### 🔐 Security Features
- University Email Verification
- Role-Based Access Control (RBAC)
- Secure Password Hashing
- Session Management

## 📂 Project Structure

```
Nova-System/
├── config/          # Configuration files
├── includes/        # Shared includes
├── admin/          # Admin panel
├── doctor/         # Doctor dashboard
├── student/        # Student portal
├── api/            # API endpoints
├── assets/         # CSS, JS, Images
├── uploads/        # User uploads
├── db/             # Database files
├── login.php       # Login page
├── index.php       # Landing page
└── error.php       # Error handling
```

## 🚀 Getting Started

### Prerequisites
- PHP 7.4+
- MySQL 5.7+
- Apache/Nginx

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/hebaahmedd1/Nova-System.git
```

2. **Import Database**
```bash
# Import db/database.sql to your MySQL
mysql -u root -p database_name < db/database.sql
```

3. **Update Configuration**
Edit `config/database.php` with your database credentials

4. **Set Permissions**
```bash
chmod 755 uploads/
chmod 755 logs/
```

5. **Access the application**
- Main: `http://localhost/Nova-System/`
- Login: `http://localhost/Nova-System/login.php`

## 👤 Test Accounts

### Admin Account
- Email: `admin@btu.edu.eg`
- Password: `Admin@123`

### Doctor Account
- Email: `doctor@btu.edu.eg`
- Password: `Doctor@123`

### Student Account
- Email: `student@btu.edu.eg`
- Password: `Student@123`

## 📝 Features Details

### Admin Panel
- Manage users (Students, Doctors)
- Manage subjects/courses
- System settings
- View analytics

### Doctor Dashboard
- Create and manage courses
- Upload lectures and materials
- Create assignments and quizzes
- Manage attendance
- Review student submissions
- Accept/reject student requests

### Student Portal
- View enrolled courses
- Access lectures and materials
- Submit assignments
- View attendance and grades
- Download course materials
- Manage profile

## 🔒 Security

- Only university emails allowed (`*.btu.edu.eg`)
- Password encryption with SHA-256
- SQL injection prevention
- XSS protection
- CSRF tokens for forms
- Role-based access control

## 📧 Contact & Support

- Email: support@btu.edu.eg
- Telegram: @Nova-System-Support
- Website: www.btu.edu.eg

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Developer

Created with ❤️ by the BTU Development Team

---

**Made with passion for education** 🎓✨
