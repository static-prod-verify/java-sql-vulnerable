-- Migration: Seed Initial Data
-- Description: Insert sample data for development and testing
-- Version: 1.3

-- Insert sample users
INSERT INTO users (username, email, password, created_at) VALUES
    ('admin', 'admin@example.com', 'hashed_password_1', UNIX_TIMESTAMP() * 1000),
    ('user1', 'user1@example.com', 'hashed_password_2', UNIX_TIMESTAMP() * 1000),
    ('user2', 'user2@example.com', 'hashed_password_3', UNIX_TIMESTAMP() * 1000),
    ('testuser', 'testuser@example.com', 'hashed_password_4', UNIX_TIMESTAMP() * 1000);

-- Insert sample posts
INSERT INTO posts (user_id, title, content, status, created_at) VALUES
    (1, 'Welcome to the Platform', 'This is the first post on this new platform.', 'PUBLISHED', UNIX_TIMESTAMP() * 1000),
    (1, 'Getting Started Guide', 'A comprehensive guide to getting started.', 'PUBLISHED', UNIX_TIMESTAMP() * 1000),
    (2, 'My First Post', 'Excited to share my thoughts here!', 'PUBLISHED', UNIX_TIMESTAMP() * 1000),
    (3, 'Draft Post', 'Work in progress...', 'DRAFT', UNIX_TIMESTAMP() * 1000);

-- Insert sample comments
INSERT INTO comments (post_id, user_id, content, created_at) VALUES
    (1, 2, 'Great introduction!', UNIX_TIMESTAMP() * 1000),
    (1, 3, 'Looking forward to using this.', UNIX_TIMESTAMP() * 1000),
    (2, 4, 'Thanks for the guide, very helpful.', UNIX_TIMESTAMP() * 1000),
    (3, 1, 'Welcome aboard!', UNIX_TIMESTAMP() * 1000);
