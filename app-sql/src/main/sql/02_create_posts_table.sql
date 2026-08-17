-- Migration: Create Posts Table
-- Description: Initialize posts table with user relationship
-- Version: 1.1

CREATE TABLE IF NOT EXISTS posts (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT NOT NULL,
    title VARCHAR(500) NOT NULL,
    content CLOB NOT NULL,
    status VARCHAR(50) DEFAULT 'DRAFT',
    created_at BIGINT NOT NULL,
    updated_at BIGINT,
    CONSTRAINT fk_posts_user_id FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT chk_title_not_empty CHECK (LENGTH(title) > 0),
    CONSTRAINT chk_content_not_empty CHECK (LENGTH(content) > 0),
    CONSTRAINT chk_valid_status CHECK (status IN ('DRAFT', 'PUBLISHED', 'ARCHIVED'))
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_posts_user_id ON posts(user_id);
CREATE INDEX IF NOT EXISTS idx_posts_status ON posts(status);
CREATE INDEX IF NOT EXISTS idx_posts_created_at ON posts(created_at);
CREATE INDEX IF NOT EXISTS idx_posts_user_status ON posts(user_id, status);
