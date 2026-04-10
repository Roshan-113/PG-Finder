# PG-Finder 🏠

A full-stack web application to help students and working professionals find PG (Paying Guest) accommodations and compatible roommates — making PG living transparent, safe, and hassle-free.

---

## 📌 About the Project

**PGConnect / PG-Finder** is a location-based platform where:
- Tenants can search and filter PG listings by city, price, gender, and amenities
- Owners can list, manage, and track their PG properties
- Users can find compatible roommates and post roommate requirements
- Admins can manage users, listings, approvals, and platform settings

---

## 🚀 Features

### For Tenants
- Search PGs by city, price range, gender preference, and amenities
- View detailed PG listings with photos, reviews, and contact info
- Book PGs and make payments via Razorpay
- Save favorite PGs and manage bookings
- Find and connect with compatible roommates
- Write reviews for PGs

### For Owners
- Register and manage PG listings
- Upload photos and manage room availability
- View and respond to tenant inquiries
- Track bookings and earnings
- Manage documents and notifications

### For Admins
- Dashboard with platform analytics
- Approve/reject PG listings
- Manage users, cities, and reports
- View and moderate reviews
- Configure system settings

### Authentication
- Email/password registration and login
- Google OAuth 2.0 login
- Forgot password with email OTP
- Role-based access control (Tenant / Owner / Admin)

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| Backend | Java (Servlets, JSP) |
| Frontend | JSP, HTML5, CSS3, JavaScript |
| Database | MySQL |
| Build Tool | Maven |
| Payment | Razorpay API |
| Auth | Google OAuth 2.0 |
| Email | JavaMail (SMTP) |
| Server | Apache Tomcat |

---

## 📁 Project Structure

```
PG-Finder/
├── src/
│   └── main/
│       ├── java/com/pgfinder/
│       │   ├── config/          # DB, Email, OAuth, Razorpay configs
│       │   ├── dao/             # Data Access Objects (DB queries)
│       │   ├── filter/          # Auth filters (Admin, Owner, Tenant)
│       │   ├── model/           # Java model/entity classes
│       │   ├── service/         # Business logic services
│       │   └── servlet/
│       │       ├── admin/       # Admin panel servlets
│       │       ├── owner/       # Owner dashboard servlets
│       │       └── tenant/      # Tenant portal servlets
│       └── webapp/
│           ├── css/             # Stylesheets
│           ├── js/              # JavaScript files
│           ├── uploads/         # Uploaded PG photos
│           └── WEB-INF/
│               ├── views/
│               │   ├── admin/   # Admin JSP pages
│               │   ├── auth/    # Login, Register, Forgot Password
│               │   ├── booking/ # Booking flow pages
│               │   ├── common/  # Shared navbar, footer
│               │   ├── layouts/ # Layout templates
│               │   ├── owner/   # Owner dashboard pages
│               │   ├── public/  # Public-facing pages
│               │   └── tenant/  # Tenant portal pages
│               └── web.xml
├── pgfinder_db.sql              # MySQL database schema
├── pom.xml                      # Maven dependencies
└── README.md
```

---

## ⚙️ Setup & Installation

### Prerequisites
- Java 11+
- Apache Tomcat 9+
- MySQL 8+
- Maven 3.6+

### Steps

**1. Clone the repository**
```bash
git clone https://github.com/Roshan-113/PG-Finder2.git
cd PG-Finder2
```

**2. Set up the database**
```sql
CREATE DATABASE pgfinder_db;
USE pgfinder_db;
SOURCE pgfinder_db.sql;
```

**3. Configure database credentials**

Edit `src/main/java/com/pgfinder/config/DatabaseConfig.java`:
```java
private static final String URL = "jdbc:mysql://localhost:3306/pgfinder_db";
private static final String USER = "your_mysql_username";
private static final String PASSWORD = "your_mysql_password";
```

**4. Configure email (SMTP)**

Edit `src/main/java/com/pgfinder/config/EmailConfig.java` with your SMTP credentials.

**5. Configure Google OAuth**

Edit `src/main/java/com/pgfinder/config/GoogleOAuthConfig.java` with your Google Client ID and Secret.

**6. Build the project**
```bash
mvn clean package
```

**7. Deploy to Tomcat**

Copy `target/pg-finder.war` to your Tomcat `webapps/` directory and start Tomcat.

**8. Access the app**
```
http://localhost:8080/pg-finder/
```

---

## 👥 Contributors

| Contributor | GitHub |
|-------------|--------|
| Roshan | [@Roshan-113](https://github.com/Roshan-113) |
| Navaz | [@navaz05](https://github.com/navaz05) |
| Harsh | [@harshh-code](https://github.com/harshh-code) |

---

## 📄 License

This project is for educational purposes.
