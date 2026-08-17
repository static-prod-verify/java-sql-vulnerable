-- Migration: Create Views and Stored Procedures
-- Description: Define application views and procedures for common queries
-- Version: 1.4

-- View: User Post Statistics
CREATE OR REPLACE VIEW vw_user_post_stats AS
SELECT
    u.id as user_id,
    u.username,
    u.email,
    COUNT(DISTINCT p.id) as total_posts,
    COUNT(DISTINCT c.id) as total_comments,
    MAX(p.created_at) as last_post_date
FROM users u
LEFT JOIN posts p ON u.id = p.user_id
LEFT JOIN comments c ON u.id = c.user_id
GROUP BY u.id, u.username, u.email;

-- View: Recent Posts with Author Info
CREATE OR REPLACE VIEW vw_recent_posts AS
SELECT
    p.id,
    p.title,
    p.status,
    p.created_at,
    u.id as user_id,
    u.username,
    COUNT(DISTINCT c.id) as comment_count
FROM posts p
INNER JOIN users u ON p.user_id = u.id
LEFT JOIN comments c ON p.id = c.post_id
GROUP BY p.id, p.title, p.status, p.created_at, u.id, u.username
ORDER BY p.created_at DESC;

-- Function: Get Post Count by Status
CREATE OR REPLACE FUNCTION fn_post_count_by_status(p_user_id BIGINT, p_status VARCHAR)
RETURNS INTEGER
LANGUAGE SQL
DETERMINISTIC
READS SQL DATA
AS $$
    SELECT COUNT(*) FROM posts
    WHERE user_id = p_user_id AND status = p_status;
$$;
