# PG Finder - Java MVC (Servlet + JSP) Frontend

A complete Java MVC web application for PG (Paying Guest) accommodation discovery and booking, converted from React to JSP with the exact same UI design.

## Project Structure

```
PG-Finder/
├── src/
│   └── main/
│       ├── java/                          # Java source files (servlets, models, DAOs)
│       ├── resources/                     # Configuration files
│       └── webapp/
│           ├── WEB-INF/
│           │   ├── web.xml               # Web application configuration
│           │   └── views/
│           │       ├── layouts/          # Layout templates
│           │       │   ├── main-layout.jsp
│           │       │   ├── admin-layout.jsp
│           │       │   ├── owner-layout.jsp
│           │       │   └── tenant-layout.jsp
│           │       ├── includes/         # Reusable components
│           │       │   ├── navigation.jsp
│           │       │   ├── navigation-authenticated.jsp
│           │       │   ├── footer.jsp
│           │       │   ├── header-admin.jsp
│           │       │   └── sidebar-admin.jsp
│           │       ├── components/       # UI components
│           │       │   ├── ui/
│           │       │   │   ├── badge.jsp
│           │       │   │   ├── button.jsp
│           │       │   │   └── card.jsp
│           │       │   ├── pg/
│           │       │   │   └── pg-card.jsp
│           │       │   └── shared/
│           │       ├── public/           # Public pages
│           │       │   ├── landing.jsp
│           │       │   ├── pg-listing.jsp
│           │       │   ├── pg-details.jsp
│           │       │   └── reviews.jsp
│           │       ├── auth/             # Authentication pages
│           │       │   ├── login.jsp
│           │       │   ├── register.jsp
│           │       │   ├── admin-login.jsp
│           │       │   ├── forgot-password.jsp
│           │       │   └── change-password.jsp
│           │       ├── tenant/           # Tenant pages
│           │       │   ├── bookings.jsp
│           │       │   ├── saved-pgs.jsp
│           │       │   ├── roommate-finder.jsp
│           │       │   ├── tenant-profile.jsp
│           │       │   └── tenant-settings.jsp
│           │       ├── owner/            # Owner pages
│           │       │   ├── dashboard.jsp
│           │       │   ├── listings.jsp
│           │       │   ├── add-pg.jsp
│           │       │   ├── manage-rooms.jsp
│           │       │   ├── availability.jsp
│           │       │   ├── owner-bookings.jsp
│           │       │   ├── earnings.jsp
│           │       │   └── owner-profile.jsp
│           │       ├── admin/            # Admin pages
│           │       │   ├── dashboard.jsp
│           │       │   ├── users.jsp
│           │       │   ├── listings.jsp
│           │       │   ├── approvals.jsp
│           │       │   ├── reviews.jsp
│           │       │   ├── reports.jsp
│           │       │   └── settings.jsp
│           │       └── booking/          # Booking flow
│           │           ├── booking-form.jsp
│           │           ├── booking-summary.jsp
│           │           ├── payment.jsp
│           │           └── booking-success.jsp
│           ├── css/                      # Stylesheets
│           │   ├── globals.css
│           │   └── dashboard.css
│           ├── js/                       # JavaScript files
│           │   ├── main.js
│           │   └── dashboard.js
│           └── index.jsp                 # Entry point
├── pom.xml                               # Maven configuration
└── README.md                             # This file
```

## Features

### Public Features
- Landing page with hero section and search
- PG listing with filters (location, budget, gender)
- PG details page with gallery and amenities
- Reviews and ratings system
- Roommate finder

### Tenant Features
- User authentication (login/register)
- Search and filter PG accommodations
- Save favorite PGs
- Book PG rooms
- View booking history
- Roommate matching
- Messages and notifications
- Profile management

### Owner Features
- Owner dashboard with statistics
- Add and manage PG listings
- Manage rooms and availability
- View and manage bookings
- Track earnings
- Handle inquiries
- Profile and settings

### Admin Features
- Admin dashboard with analytics
- User management
- PG listing moderation
- Owner verification
- Review moderation
- Reports and flags
- System settings

## Technology Stack

- **Backend**: Java Servlets
- **Frontend**: JSP (JavaServer Pages)
- **Build Tool**: Maven
- **Server**: Apache Tomcat / Any Servlet Container
- **CSS**: Custom CSS with CSS Variables
- **JavaScript**: Vanilla JavaScript
- **Icons**: Font Awesome 6.4.0

## Design System

### Color Palette
- **Primary**: Light Blue (#0ea5e9, #0284c7, #0369a1)
- **Secondary**: Teal (#14b8a6, #0d9488, #0f766e)
- **Gray Scale**: #f9fafb to #111827
- **Utility**: Red, Amber, Green for status indicators

### Layout Components
1. **Main Layout**: Public pages with navigation and footer
2. **Admin Layout**: Sidebar-based dashboard for admin
3. **Owner Layout**: Authenticated navigation for owners
4. **Tenant Layout**: Authenticated navigation for tenants

### UI Components
- Badge (primary, secondary, success, warning, danger)
- Button (primary, secondary, outline, ghost)
- Card (with hover effects)
- PG Card (specialized for PG listings)
- Navigation (public and authenticated)
- Footer
- Admin Sidebar

## Setup Instructions

### Prerequisites
- Java JDK 11 or higher
- Apache Maven 3.6+
- Apache Tomcat 9.0+ or any Servlet 4.0 compatible container

### Build and Run

1. **Clone or navigate to the project directory**
   ```bash
   cd PG-Finder
   ```

2. **Build the project**
   ```bash
   mvn clean package
   ```

3. **Deploy to Tomcat**
   - Copy `target/pg-finder.war` to Tomcat's `webapps` directory
   - Start Tomcat server
   - Access the application at `http://localhost:8080/pg-finder/`

4. **Development Mode**
   ```bash
   mvn tomcat7:run
   ```

## Page Routes

### Public Routes
- `/` - Landing page
- `/find-pg` - PG listing page
- `/pg-details` - PG details page
- `/find-roommate` - Roommate finder
- `/reviews` - Reviews page

### Auth Routes
- `/login` - User login
- `/register` - User registration
- `/admin-login` - Admin login
- `/forgot-password` - Password recovery
- `/change-password` - Change password

### Tenant Routes
- `/tenant/bookings` - My bookings
- `/tenant/saved-pgs` - Saved PGs
- `/tenant/roommate-finder` - Find roommates
- `/tenant/messages` - Messages
- `/tenant/notifications` - Notifications
- `/tenant/profile` - Profile
- `/tenant/settings` - Settings

### Owner Routes
- `/owner/dashboard` - Owner dashboard
- `/owner/listings` - Manage listings
- `/owner/add-pg` - Add new PG
- `/owner/manage-rooms` - Manage rooms
- `/owner/availability` - Manage availability
- `/owner/bookings` - View bookings
- `/owner/earnings` - Earnings report
- `/owner/profile` - Profile

### Admin Routes
- `/admin/dashboard` - Admin dashboard
- `/admin/users` - User management
- `/admin/listings` - PG listings
- `/admin/approvals` - Owner verification
- `/admin/reviews` - Review moderation
- `/admin/reports` - Reports & flags
- `/admin/settings` - System settings

### Booking Flow
- `/booking` - Booking form
- `/booking-summary` - Booking summary
- `/payment` - Payment page
- `/booking-success` - Booking confirmation

## JSP Include Syntax

All reusable components use JSP include:

```jsp
<%@ include file="../includes/navigation.jsp" %>
<%@ include file="../includes/footer.jsp" %>
<%@ include file="../components/pg/pg-card.jsp" %>
```

## Session Management

User sessions are managed using:
- `sessionScope.userRole` - User role (tenant/owner/admin)
- `sessionScope.userName` - User name
- `sessionScope.userEmail` - User email

## Responsive Design

The application is fully responsive with breakpoints:
- Mobile: < 768px
- Tablet: 768px - 1024px
- Desktop: > 1024px

## Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)

## Future Enhancements

- Add backend servlet implementations
- Integrate with database (MySQL/PostgreSQL)
- Add payment gateway integration
- Implement real-time chat
- Add email notifications
- Implement advanced search with filters
- Add map integration for location
- Mobile app version

## License

Copyright © 2026 PG Finder. All rights reserved.

## Contact

For support or queries, contact: support@pgfinder.com
