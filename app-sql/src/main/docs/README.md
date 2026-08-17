# SQL Schema Documentation

## Overview
This module contains all SQL schema definitions and migrations for the Java SQL Application.

## Database Schema

### Tables

#### users
- **id**: Primary key (BIGINT AUTO_INCREMENT)
- **username**: Unique username (VARCHAR 255)
- **email**: Unique email address (VARCHAR 255)
- **password**: Hashed password (VARCHAR 255)
- **created_at**: Timestamp (BIGINT)
- **updated_at**: Auto-updated timestamp

Indexes:
- `idx_users_username` on username
- `idx_users_email` on email

#### posts
- **id**: Primary key (BIGINT AUTO_INCREMENT)
- **user_id**: Foreign key to users table (BIGINT)
- **title**: Post title (VARCHAR 500)
- **content**: Post content (LONGTEXT)
- **status**: Post status - DRAFT, PUBLISHED, ARCHIVED (VARCHAR 50)
- **created_at**: Timestamp (BIGINT)
- **updated_at**: Auto-updated timestamp

Indexes:
- `idx_posts_user_id` on user_id
- `idx_posts_status` on status
- `idx_posts_created_at` on created_at

## Migration Files

1. **01_create_users_table.sql** - Initial users table creation
2. **02_create_posts_table.sql** - Posts table with user relationship

## Usage

Apply migrations in sequential order to establish the database schema.
