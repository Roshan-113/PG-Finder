# 🏠 PG-Finder

### Location-Based PG & Roommate Discovery Platform

PGConnect is a **location-based web application** that helps **students and working professionals** find suitable **PG accommodations and compatible roommates** near colleges or workplaces.

The platform also allows **PG owners to list properties** and enables users to leave **honest reviews and ratings**.

---

## 📌 Problem Statement

Finding a reliable PG or roommate is often difficult due to:

- ❌ Fake listings and biased reviews
- ❌ Difficulty in replacing or switching roommates
- ❌ No direct communication with PG owners
- ❌ Lack of trusted PG platforms

**PGConnect solves these problems** by providing a **transparent and user-friendly platform**.

---

## 🎯 Project Objectives

- 📍 Help users find PGs near colleges or workplaces
- 👥 Match users with compatible roommates
- 🔁 Enable easy roommate replacement or switching
- ⭐ Provide verified and honest PG reviews
- 🏢 Connect PG owners directly with tenants

---

## 👥 System Users

1. 🎓 Students / Tenants
2. 👤 Existing Room Owners / Tenants
3. 🏢 PG Owners / Hostel Managers

---

## ✨ Core Features

### 🏠 PG Search & Discovery
- 🔍 Search PGs by city or location
- 💰 Filter by price, amenities, gender & sharing type
- �️ View PG photos and details
- 📞 Contact PG owners directly

---

### 👥 Roommate Finder
- 🏠 Post room availability
- 🤝 Find compatible roommates
- 📍 Match roommates based on location & lifestyle
- 💬 Private user-to-user communication

---

### � Roommate / Room Change
- 🔄 Request roommate replacement
- 📍 Discover nearby compatible roommates
- ⚡ Easy switching options

---

### ⭐ Reviews & Ratings
- ⭐ Verified tenant reviews
- 🧹 Cleanliness rating
- 🍽️ Food quality rating
- 🛡️ Safety rating
- 🏢 Owner behavior rating

---

### 🏢 PG Owner Panel
- ➕ Add new PG listings
- 🛏️ Manage room availability
- 💲 Update pricing & amenities
- 📩 Receive tenant inquiries

---

## 🏗️ Technology Stack

### 🎨 Frontend
- JSP (JavaServer Pages)
- HTML5
- CSS3
- JavaScript

### ⚙️ Backend
- Java (Servlets)
- Apache Tomcat

### 🗄️ Database
- MySQL

### 🧰 Tools & Services
- Maven (Build Tool)
- Git & GitHub
- Google OAuth 2.0
- Razorpay Payment Gateway
- JavaMail (SMTP) for Email OTP
- REST API Architecture

---

## 📁 Project Structure

```
PG-Finder/
├── src/
│   ├── main/
│   │   ├── java/com/pgfinder/
│   │   │   ├── config/          # DB, Email, OAuth, Razorpay configs
│   │   │   ├── dao/             # Data Access Objects (DB queries)
│   │   │   ├── filter/          # Auth filters (Admin, Owner, Tenant)
│   │   │   ├── model/           # Java model/entity classes
│   │   │   ├── service/         # Business logic services
│   │   │   └── servlet/
│   │   │       ├── admin/       # Admin panel servlets
│   │   │       ├── owner/       # Owner dashboard servlets
│   │   │       └── tenant/      # Tenant portal servlets
│   │   └── webapp/
│   │       ├── css/             # Stylesheets (admin, auth, owner, tenant)
│   │       ├── js/              # JavaScript validation files
│   │       ├── uploads/         # Uploaded PG photos
│   │       └── WEB-INF/
│   │           ├── views/
│   │           │   ├── admin/   # Admin panel JSP pages
│   │           │   ├── auth/    # Login, Register, Forgot Password
│   │           │   ├── booking/ # Booking flow pages
│   │           │   ├── common/  # Shared navbar, footer
│   │           │   ├── layouts/ # Layout templates
│   │           │   ├── owner/   # Owner dashboard pages
│   │           │   ├── public/  # Public-facing pages
│   │           │   └── tenant/  # Tenant portal pages
│   │           └── web.xml
│   └── test/                    # JUnit test suite
├── pgfinder_db.sql              # MySQL database schema
├── pom.xml                      # Maven dependencies
└── README.md
```

---

## 🗂️ Database Structure

Main tables used in the system:

- `users` — Tenant, Owner, Admin accounts
- `pg_listings` — PG property details
- `rooms` — Room types and availability
- `bookings` — Tenant booking records
- `reviews` — PG ratings and reviews
- `messages` — Owner-tenant communication
- `saved_pgs` — Tenant saved/wishlist PGs
- `cities` — Supported city list

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
git clone https://github.com/Roshan-113/PG-Finder.git
cd PG-Finder
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

**4. Configure Google OAuth**

Edit `src/main/java/com/pgfinder/config/GoogleOAuthConfig.java`:
```java
public static final String CLIENT_ID = "your_google_client_id";
public static final String CLIENT_SECRET = "your_google_client_secret";
```

**5. Build the project**
```bash
mvn clean package
```

**6. Deploy to Tomcat**

Copy `target/pg-finder.war` to your Tomcat `webapps/` directory and start Tomcat.

**7. Access the app**
```
http://localhost:8080/pg-finder/
```

---

## 🔄 Application Workflow

1️⃣ User registers and selects role (Tenant / Owner)
2️⃣ Searches for PG or roommates
3️⃣ Applies filters to find suitable options
4️⃣ Contacts PG owner or roommate
5️⃣ Books PG and makes payment via Razorpay
6️⃣ Leaves review after stay

---

## 🚧 Project Status

⚙️ Currently **under development**

**Completed:**
- ✔ Java Backend (Servlets, DAOs, Services)
- ✔ JSP Frontend UI
- ✔ MySQL Database Schema
- ✔ Google OAuth 2.0 Authentication
- ✔ Razorpay Payment Integration
- ✔ Email OTP (Forgot Password)
- ✔ Admin, Owner & Tenant Dashboards
- ✔ GitHub Collaboration Setup

**Upcoming:**
- 🔹 Live Deployment
- 🔹 Map Integration
- 🔹 Real-time Notifications

---

## 🎨 UI / UX Design

Figma Design Link:
[PG-Find UI Design](https://www.figma.com/design/XLTEpjw46kqqznkK0hyoJJ/PG-Find?node-id=0-1&t=zlUtG0NsOlibD043-1)

---

## 👨‍💻 Project Team

| Enrollment No | Name |
|---------------|------|
| 23SOECE11077 | Roshan Sikotariya |
| 23SOECE11062 | Navaz Odiya |
| 23SOECE11078 | Harsh Solanki |

**Institution:** RK University
**Course:** Full Stack Development

---

## 📜 License

This project is developed **for educational purposes** at **RK University**.

---

## ⭐ Contributions

Contributions are welcome!
- Open an Issue
- Submit a Pull Request
- Give this project a **Star ⭐**
