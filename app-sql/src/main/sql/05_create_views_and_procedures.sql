-- TSQL Migration: Create Views and Stored Procedures
-- Description: Define application views and procedures for common queries
-- Version: 1.4

-- Drop existing views if they exist
IF OBJECT_ID('[dbo].[vw_recent_posts]', 'V') IS NOT NULL
    DROP VIEW [dbo].[vw_recent_posts];
GO

IF OBJECT_ID('[dbo].[vw_user_post_stats]', 'V') IS NOT NULL
    DROP VIEW [dbo].[vw_user_post_stats];
GO

-- View: User Post Statistics
CREATE VIEW [dbo].[vw_user_post_stats] AS
SELECT
    [u].[id] AS [user_id],
    [u].[username],
    [u].[email],
    COUNT(DISTINCT [p].[id]) AS [total_posts],
    COUNT(DISTINCT [c].[id]) AS [total_comments],
    MAX([p].[created_at]) AS [last_post_date]
FROM [dbo].[users] [u]
LEFT JOIN [dbo].[posts] [p] ON [u].[id] = [p].[user_id]
LEFT JOIN [dbo].[comments] [c] ON [u].[id] = [c].[user_id]
GROUP BY [u].[id], [u].[username], [u].[email];
GO

-- View: Recent Posts with Author Info
CREATE VIEW [dbo].[vw_recent_posts] AS
SELECT
    [p].[id],
    [p].[title],
    [p].[status],
    [p].[created_at],
    [u].[id] AS [user_id],
    [u].[username],
    COUNT(DISTINCT [c].[id]) AS [comment_count]
FROM [dbo].[posts] [p]
INNER JOIN [dbo].[users] [u] ON [p].[user_id] = [u].[id]
LEFT JOIN [dbo].[comments] [c] ON [p].[id] = [c].[post_id]
GROUP BY [p].[id], [p].[title], [p].[status], [p].[created_at], [u].[id], [u].[username];
GO

-- Drop existing procedure if it exists
IF OBJECT_ID('[dbo].[sp_get_post_count_by_status]', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_get_post_count_by_status];
GO

-- Stored Procedure: Get Post Count by Status
CREATE PROCEDURE [dbo].[sp_get_post_count_by_status]
    @p_user_id BIGINT,
    @p_status NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT COUNT(*) AS [post_count]
    FROM [dbo].[posts]
    WHERE [user_id] = @p_user_id AND [status] = @p_status;
END;
GO
