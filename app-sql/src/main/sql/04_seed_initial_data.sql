-- TSQL Migration: Seed Initial Data
-- Description: Insert sample data for development and testing
-- Version: 1.3

SET IDENTITY_INSERT [dbo].[users] ON;
GO

-- Insert sample users
INSERT INTO [dbo].[users] ([id], [username], [email], [password], [created_at]) VALUES
    (1, N'admin', N'admin@example.com', N'hashed_password_1', DATEDIFF(SECOND, '1970-01-01', GETUTCDATE()) * 1000),
    (2, N'user1', N'user1@example.com', N'hashed_password_2', DATEDIFF(SECOND, '1970-01-01', GETUTCDATE()) * 1000),
    (3, N'user2', N'user2@example.com', N'hashed_password_3', DATEDIFF(SECOND, '1970-01-01', GETUTCDATE()) * 1000),
    (4, N'testuser', N'testuser@example.com', N'hashed_password_4', DATEDIFF(SECOND, '1970-01-01', GETUTCDATE()) * 1000);
GO

SET IDENTITY_INSERT [dbo].[users] OFF;
GO

SET IDENTITY_INSERT [dbo].[posts] ON;
GO

-- Insert sample posts
INSERT INTO [dbo].[posts] ([id], [user_id], [title], [content], [status], [created_at]) VALUES
    (1, 1, N'Welcome to the Platform', N'This is the first post on this new platform.', N'PUBLISHED', DATEDIFF(SECOND, '1970-01-01', GETUTCDATE()) * 1000),
    (2, 1, N'Getting Started Guide', N'A comprehensive guide to getting started.', N'PUBLISHED', DATEDIFF(SECOND, '1970-01-01', GETUTCDATE()) * 1000),
    (3, 2, N'My First Post', N'Excited to share my thoughts here!', N'PUBLISHED', DATEDIFF(SECOND, '1970-01-01', GETUTCDATE()) * 1000),
    (4, 3, N'Draft Post', N'Work in progress...', N'DRAFT', DATEDIFF(SECOND, '1970-01-01', GETUTCDATE()) * 1000);
GO

SET IDENTITY_INSERT [dbo].[posts] OFF;
GO

SET IDENTITY_INSERT [dbo].[comments] ON;
GO

-- Insert sample comments
INSERT INTO [dbo].[comments] ([id], [post_id], [user_id], [content], [created_at]) VALUES
    (1, 1, 2, N'Great introduction!', DATEDIFF(SECOND, '1970-01-01', GETUTCDATE()) * 1000),
    (2, 1, 3, N'Looking forward to using this.', DATEDIFF(SECOND, '1970-01-01', GETUTCDATE()) * 1000),
    (3, 2, 4, N'Thanks for the guide, very helpful.', DATEDIFF(SECOND, '1970-01-01', GETUTCDATE()) * 1000),
    (4, 3, 1, N'Welcome aboard!', DATEDIFF(SECOND, '1970-01-01', GETUTCDATE()) * 1000);
GO

SET IDENTITY_INSERT [dbo].[comments] OFF;
GO
