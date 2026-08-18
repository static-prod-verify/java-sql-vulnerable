-- TSQL Migration: Create Comments Table
-- Description: Initialize comments table for post discussions
-- Version: 1.2

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[comments]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[comments] (
        [id] BIGINT PRIMARY KEY IDENTITY(1,1),
        [post_id] BIGINT NOT NULL,
        [user_id] BIGINT NOT NULL,
        [content] NVARCHAR(MAX) NOT NULL,
        [created_at] BIGINT NOT NULL,
        [updated_at] BIGINT NULL,
        CONSTRAINT [fk_comments_post_id] FOREIGN KEY ([post_id]) REFERENCES [dbo].[posts]([id]) ON DELETE CASCADE,
        CONSTRAINT [fk_comments_user_id] FOREIGN KEY ([user_id]) REFERENCES [dbo].[users]([id]) ON DELETE CASCADE,
        CONSTRAINT [chk_comment_not_empty] CHECK (LEN([content]) > 0)
    );
END;
GO

-- Create indexes for query performance
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_comments_post_id')
    CREATE INDEX [idx_comments_post_id] ON [dbo].[comments]([post_id]);
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_comments_user_id')
    CREATE INDEX [idx_comments_user_id] ON [dbo].[comments]([user_id]);
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_comments_created_at')
    CREATE INDEX [idx_comments_created_at] ON [dbo].[comments]([created_at]);
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_comments_post_user')
    CREATE INDEX [idx_comments_post_user] ON [dbo].[comments]([post_id], [user_id]);
GO
