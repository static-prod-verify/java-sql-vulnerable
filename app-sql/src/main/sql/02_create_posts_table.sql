-- TSQL Migration: Create Posts Table
-- Description: Initialize posts table with user relationship
-- Version: 1.1

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[posts]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[posts] (
        [id] BIGINT PRIMARY KEY IDENTITY(1,1),
        [user_id] BIGINT NOT NULL,
        [title] NVARCHAR(500) NOT NULL,
        [content] NVARCHAR(MAX) NOT NULL,
        [status] NVARCHAR(50) DEFAULT 'DRAFT',
        [created_at] BIGINT NOT NULL,
        [updated_at] BIGINT NULL,
        CONSTRAINT [fk_posts_user_id] FOREIGN KEY ([user_id]) REFERENCES [dbo].[users]([id]) ON DELETE CASCADE,
        CONSTRAINT [chk_title_not_empty] CHECK (LEN([title]) > 0),
        CONSTRAINT [chk_content_not_empty] CHECK (LEN([content]) > 0),
        CONSTRAINT [chk_valid_status] CHECK ([status] IN ('DRAFT', 'PUBLISHED', 'ARCHIVED'))
    );
END;
GO

-- Create indexes for better query performance
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_posts_user_id')
    CREATE INDEX [idx_posts_user_id] ON [dbo].[posts]([user_id]);
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_posts_status')
    CREATE INDEX [idx_posts_status] ON [dbo].[posts]([status]);
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_posts_created_at')
    CREATE INDEX [idx_posts_created_at] ON [dbo].[posts]([created_at]);
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_posts_user_status')
    CREATE INDEX [idx_posts_user_status] ON [dbo].[posts]([user_id], [status]);
GO
