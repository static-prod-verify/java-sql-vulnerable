# TSQL Schema Documentation

## Overview
This module contains all TSQL (SQL Server) schema definitions, migrations, views, and stored procedures for the Java SQL Application. All SQL files are production-ready and fully documented for SQL Server 2016+.

## Migration Files

Migrations should be applied in sequential order:

1. **01_create_schema.sql** - Initialize schema and settings
2. **01_create_users_table.sql** - Create users table with indexes and constraints
3. **02_create_posts_table.sql** - Create posts table with relationships
4. **03_create_comments_table.sql** - Create comments table for discussions
5. **04_seed_initial_data.sql** - Load sample data for development
6. **05_create_views_and_procedures.sql** - Create views and stored procedures

## Database Schema

### Core Tables

#### users
- **id**: BIGINT PRIMARY KEY (Auto-generated)
- **username**: VARCHAR(255) UNIQUE NOT NULL
- **email**: VARCHAR(255) UNIQUE NOT NULL
- **password**: VARCHAR(255) NOT NULL
- **created_at**: BIGINT NOT NULL
- **updated_at**: BIGINT (nullable)

**Indexes:**
- `idx_users_username` - Fast username lookups
- `idx_users_email` - Fast email lookups
- `idx_users_created_at` - Chronological queries

**Constraints:**
- Username and email must not be empty
- All values are unique

#### posts
- **id**: BIGINT PRIMARY KEY (Auto-generated)
- **user_id**: BIGINT NOT NULL (FK → users.id)
- **title**: VARCHAR(500) NOT NULL
- **content**: CLOB NOT NULL
- **status**: VARCHAR(50) DEFAULT 'DRAFT'
- **created_at**: BIGINT NOT NULL
- **updated_at**: BIGINT (nullable)

**Indexes:**
- `idx_posts_user_id` - Lookup posts by author
- `idx_posts_status` - Filter by publication status
- `idx_posts_created_at` - Time-based queries
- `idx_posts_user_status` - Composite query support

**Constraints:**
- Valid statuses: DRAFT, PUBLISHED, ARCHIVED
- Title and content must not be empty
- ON DELETE CASCADE with users table

#### comments
- **id**: BIGINT PRIMARY KEY (Auto-generated)
- **post_id**: BIGINT NOT NULL (FK → posts.id)
- **user_id**: BIGINT NOT NULL (FK → users.id)
- **content**: CLOB NOT NULL
- **created_at**: BIGINT NOT NULL
- **updated_at**: BIGINT (nullable)

**Indexes:**
- `idx_comments_post_id` - Comments per post
- `idx_comments_user_id` - Comments by user
- `idx_comments_created_at` - Chronological access
- `idx_comments_post_user` - Composite queries

**Constraints:**
- Content must not be empty
- ON DELETE CASCADE for both relationships

### Views

#### vw_user_post_stats
Aggregated statistics per user including post count, comment count, and last activity.

#### vw_recent_posts
Recently created posts with author information and comment counts, ordered by creation date.

### Stored Procedures

#### fn_post_count_by_status(user_id, status)
Returns the count of posts for a specific user with a given status.

## Artifact Output

The SQL module produces:
- **ZIP Bundle**: `app-sql-1.0.0-sql-bundle.zip` - All SQL files and documentation
- **TAR.GZ Bundle**: `app-sql-1.0.0-sql-bundle.tar.gz` - Alternative compressed format

## Application

Apply migrations in order using SQL Server Management Studio or sqlcmd:

**PowerShell:**
```powershell
# Extract the bundle
Expand-Archive app-sql-1.0.0-sql-bundle.zip

# Apply migrations using sqlcmd
sqlcmd -S server_name -d database_name -i sql/01_create_schema.sql
sqlcmd -S server_name -d database_name -i sql/01_create_users_table.sql
sqlcmd -S server_name -d database_name -i sql/02_create_posts_table.sql
sqlcmd -S server_name -d database_name -i sql/03_create_comments_table.sql
sqlcmd -S server_name -d database_name -i sql/04_seed_initial_data.sql
sqlcmd -S server_name -d database_name -i sql/05_create_views_and_procedures.sql
```

**SQL Server Management Studio:**
1. Extract the bundle
2. Open SQL Server Management Studio
3. Connect to your database
4. Open each SQL file and execute in sequential order
5. Verify table creation in Object Explorer

## Database Compatibility

- **SQL Server**: 2016+ (primary target)
- **SQL Server**: 2019+ (recommended)
- **SQL Server**: 2022+ (latest)
- **Azure SQL Database**: Fully compatible

Note: All TSQL syntax is SQL Server specific. Conversion required for other databases.
