# Test Database Configuration

## Important: Using Your Existing Database

The JUnit tests are configured to use your **existing MySQL database** (`pgfinder_db`).

### Database Details
- **Database Name**: `pgfinder_db`
- **Host**: `localhost:3306`
- **Username**: `root`
- **Password**: (empty - default XAMPP)
- **Schema**: Your existing schema from `pgfinder_db.sql`

### Why This Approach?

✅ **No separate test database needed**
✅ **Tests use your real database schema**
✅ **No data duplication**
✅ **Tests verify against actual structure**

### Test Data Strategy

The tests use **mocking** to avoid modifying your actual database:
- Database connections are mocked
- No real data is inserted/updated/deleted
- Your production data remains safe

### Running Tests

Tests will:
1. Mock database connections using Mockito
2. Simulate database operations
3. Verify logic without touching real data
4. Keep your database clean and safe

### Configuration File

Test database settings are in: `src/test/resources/test.properties`

```properties
test.db.url=jdbc:mysql://localhost:3306/pgfinder_db
test.db.username=root
test.db.password=
```

### Safety Features

✅ Tests use mocks - no real database writes
✅ Your data is never modified
✅ Tests can run without database connection
✅ Production database remains untouched

### If You Want a Separate Test Database

If you prefer a separate test database:

1. Create a new database:
```sql
CREATE DATABASE pgfinder_test_db;
```

2. Import your schema:
```bash
mysql -u root pgfinder_test_db < pgfinder_db.sql
```

3. Update `test.properties`:
```properties
test.db.url=jdbc:mysql://localhost:3306/pgfinder_test_db
```

But this is **optional** - the current setup works perfectly with mocking!
