-- TSQL Migration: Create Users Table
-- Description: Initialize users table with core user information
-- Version: 1.0

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[users]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[users] (
        [id] BIGINT PRIMARY KEY IDENTITY(1,1),
        [username] NVARCHAR(255) NOT NULL UNIQUE,
        [email] NVARCHAR(255) NOT NULL UNIQUE,
        [password] NVARCHAR(255) NOT NULL,
        [created_at] BIGINT NOT NULL,
        [updated_at] BIGINT NULL,
        CONSTRAINT [chk_username_not_empty] CHECK (LEN([username]) > 0),
        CONSTRAINT [chk_email_not_empty] CHECK (LEN([email]) > 0)
    );
END;
GO

-- Create indexes for query performance
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_users_username')
    CREATE INDEX [idx_users_username] ON [dbo].[users]([username]);
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_users_email')
    CREATE INDEX [idx_users_email] ON [dbo].[users]([email]);
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_users_created_at')
    CREATE INDEX [idx_users_created_at] ON [dbo].[users]([created_at]);
GO
