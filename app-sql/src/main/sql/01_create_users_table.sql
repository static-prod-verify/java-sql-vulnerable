-- Migration: Create Users Table
-- Description: Initialize users table with core user information
-- Version: 1.0

CREATE TABLE IF NOT EXISTS users (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at BIGINT NOT NULL,
    updated_at BIGINT,
    CONSTRAINT chk_username_not_empty CHECK (LENGTH(username) > 0),
    CONSTRAINT chk_email_not_empty CHECK (LENGTH(email) > 0)
);

-- Create indexes for query performance
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_created_at ON users(created_at);
