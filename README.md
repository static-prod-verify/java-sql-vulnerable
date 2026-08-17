# Java SQL Application

A comprehensive multi-module Java application featuring Spring Boot backend, React frontend, and SQL schema management.

## Project Structure

```
java-sql-app/
├── app-backend/          # Spring Boot REST API
├── app-frontend/         # React web application
├── app-sql/              # SQL schemas and migrations
└── pom.xml              # Parent POM for multi-module build
```

## Modules

### 1. app-backend
Spring Boot REST API providing user management endpoints.

**Key Features:**
- REST API with Spring Web
- JPA/Hibernate for data persistence
- In-memory H2 database (dev)
- User entity and CRUD operations

**Endpoints:**
- `GET /api/users` - Get all users
- `GET /api/users/{id}` - Get user by ID
- `POST /api/users` - Create new user
- `PUT /api/users/{id}` - Update user
- `DELETE /api/users/{id}` - Delete user

### 2. app-frontend
React frontend for user management interface.

**Features:**
- User list display
- Create new users
- Delete users
- Responsive design
- Real-time updates

### 3. app-sql
Database schema and migration artifacts packaged separately.

**Contents:**
- Schema definitions (users, posts tables)
- Database migrations
- Index definitions
- Documentation

## Building

### Build All Modules
```bash
mvn clean install
```

### Build Specific Module
```bash
mvn clean install -pl app-backend
```

### Skip Frontend Build (Node.js not required)
```bash
mvn clean install -DskipFrontend
```

## Artifacts

After building, two main artifacts are generated:

1. **Backend JAR** (`app-backend/target/app-backend-1.0.0.jar`)
   - Executable Spring Boot application
   - Contains REST API and embedded server

2. **SQL Bundle** (`app-sql/target/app-sql-1.0.0-sql-bundle.zip`)
   - Database schemas and migrations
   - Documentation and setup guides

## Running

### Start Backend
```bash
java -jar app-backend/target/app-backend-1.0.0.jar
```

The application will start on `http://localhost:8080`

### Access Frontend
- Web UI: `http://localhost:8080`
- API: `http://localhost:8080/api`
- H2 Console: `http://localhost:8080/h2-console`

## Database

The application uses H2 in-memory database by default. To use PostgreSQL or MySQL:

1. Add database driver to `app-backend/pom.xml`
2. Update `application.properties` with connection details
3. Rebuild

### Default H2 Credentials
- URL: `jdbc:h2:mem:testdb`
- Username: `sa`
- Password: (empty)

## Development

### Frontend Development
```bash
cd app-frontend/src/main/app
npm install
npm start
```

Frontend runs on `http://localhost:3000` with proxy to `http://localhost:8080`

### Backend Development
```bash
cd app-backend
mvn spring-boot:run
```

## Database Schema

### Users Table
- id (BIGINT PRIMARY KEY)
- username (VARCHAR 255 UNIQUE)
- email (VARCHAR 255 UNIQUE)
- password (VARCHAR 255)
- created_at (BIGINT)
- updated_at (BIGINT)

### Posts Table
- id (BIGINT PRIMARY KEY)
- user_id (BIGINT FOREIGN KEY)
- title (VARCHAR 500)
- content (LONGTEXT)
- status (VARCHAR 50)
- created_at (BIGINT)
- updated_at (BIGINT)

## Testing

```bash
# Run all tests
mvn test

# Run specific module tests
mvn test -pl app-backend
```

## Technologies

- **Backend:** Spring Boot 2.7.0, Java 11
- **Frontend:** React 18, Axios
- **Database:** H2 (H2), PostgreSQL/MySQL compatible
- **Build:** Maven 3.6+
- **Node:** v16+ (for frontend build)

## License

MIT
