if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunTables_Tables]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunTables] DROP CONSTRAINT FK_TestRunTables_Tables

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestTables_Tables]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestTables] DROP CONSTRAINT FK_TestTables_Tables

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunTables_TestRuns]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunTables] DROP CONSTRAINT FK_TestRunTables_TestRuns

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunViews_TestRuns]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunViews] DROP CONSTRAINT FK_TestRunViews_TestRuns

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestTables_Tests]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestTables] DROP CONSTRAINT FK_TestTables_Tests

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestViews_Tests]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestViews] DROP CONSTRAINT FK_TestViews_Tests

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunViews_Views]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunViews] DROP CONSTRAINT FK_TestRunViews_Views

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestViews_Views]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestViews] DROP CONSTRAINT FK_TestViews_Views

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[Tables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [Tables]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestRunTables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestRunTables]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestRunViews]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestRunViews]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestRuns]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestRuns]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestTables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestTables]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestViews]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestViews]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[Tests]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [Tests]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[Views]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [Views]

GO



CREATE TABLE [Tables] (

	[TableID] [int] IDENTITY (1, 1) NOT NULL ,

	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestRunTables] (

	[TestRunID] [int] NOT NULL ,

	[TableID] [int] NOT NULL ,

	[StartAt] [datetime] NOT NULL ,

	[EndAt] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestRunViews] (

	[TestRunID] [int] NOT NULL ,

	[ViewID] [int] NOT NULL ,

	[StartAt] [datetime] NOT NULL ,

	[EndAt] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestRuns] (

	[TestRunID] [int] IDENTITY (1, 1) NOT NULL ,

	[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,

	[StartAt] [datetime] NULL ,

	[EndAt] [datetime] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestTables] (

	[TestID] [int] NOT NULL ,

	[TableID] [int] NOT NULL ,

	[NoOfRows] [int] NOT NULL ,

	[Position] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestViews] (

	[TestID] [int] NOT NULL ,

	[ViewID] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [Tests] (

	[TestID] [int] IDENTITY (1, 1) NOT NULL ,

	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [Views] (

	[ViewID] [int] IDENTITY (1, 1) NOT NULL ,

	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 

) ON [PRIMARY]

GO



ALTER TABLE [Tables] WITH NOCHECK ADD 

	CONSTRAINT [PK_Tables] PRIMARY KEY  CLUSTERED 

	(

		[TableID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRunTables] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestRunTables] PRIMARY KEY  CLUSTERED 

	(

		[TestRunID],

		[TableID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRunViews] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestRunViews] PRIMARY KEY  CLUSTERED 

	(

		[TestRunID],

		[ViewID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRuns] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestRuns] PRIMARY KEY  CLUSTERED 

	(

		[TestRunID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestTables] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestTables] PRIMARY KEY  CLUSTERED 

	(

		[TestID],

		[TableID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestViews] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestViews] PRIMARY KEY  CLUSTERED 

	(

		[TestID],

		[ViewID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [Tests] WITH NOCHECK ADD 

	CONSTRAINT [PK_Tests] PRIMARY KEY  CLUSTERED 

	(

		[TestID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [Views] WITH NOCHECK ADD 

	CONSTRAINT [PK_Views] PRIMARY KEY  CLUSTERED 

	(

		[ViewID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRunTables] ADD 

	CONSTRAINT [FK_TestRunTables_Tables] FOREIGN KEY 

	(

		[TableID]

	) REFERENCES [Tables] (

		[TableID]

	) ON DELETE CASCADE  ON UPDATE CASCADE ,

	CONSTRAINT [FK_TestRunTables_TestRuns] FOREIGN KEY 

	(

		[TestRunID]

	) REFERENCES [TestRuns] (

		[TestRunID]

	) ON DELETE CASCADE  ON UPDATE CASCADE 

GO



ALTER TABLE [TestRunViews] ADD 

	CONSTRAINT [FK_TestRunViews_TestRuns] FOREIGN KEY 

	(

		[TestRunID]

	) REFERENCES [TestRuns] (

		[TestRunID]

	) ON DELETE CASCADE  ON UPDATE CASCADE ,

	CONSTRAINT [FK_TestRunViews_Views] FOREIGN KEY 

	(

		[ViewID]

	) REFERENCES [Views] (

		[ViewID]

	) ON DELETE CASCADE  ON UPDATE CASCADE 

GO



ALTER TABLE [TestTables] ADD 

	CONSTRAINT [FK_TestTables_Tables] FOREIGN KEY 

	(

		[TableID]

	) REFERENCES [Tables] (

		[TableID]

	) ON DELETE CASCADE  ON UPDATE CASCADE ,

	CONSTRAINT [FK_TestTables_Tests] FOREIGN KEY 

	(

		[TestID]

	) REFERENCES [Tests] (

		[TestID]

	) ON DELETE CASCADE  ON UPDATE CASCADE 

GO



ALTER TABLE [TestViews] ADD 

	CONSTRAINT [FK_TestViews_Tests] FOREIGN KEY 

	(

		[TestID]

	) REFERENCES [Tests] (

		[TestID]

	),

	CONSTRAINT [FK_TestViews_Views] FOREIGN KEY 

	(

		[ViewID]

	) REFERENCES [Views] (

		[ViewID]

	)

GO


CREATE VIEW VAccount
AS
	SELECT A.AccountId, A.Balance
	FROM Account A
	WHERE A.Balance > 1500 AND A.AccountId IN
		( 
			SELECT F.AccountId
			FROM FamilyMembers F
			WHERE F.AccountId = A.AccountId
			)
GO

CREATE VIEW VCustomersFromRomania
AS 
	SELECT C.FirstName, C.LastName
	FROM Customer C
	WHERE C.Country = 'Romania'
GO

CREATE VIEW VCustomers
AS
	SELECT C.Country, COUNT(C.CustomerId) AS Counter
	FROM Customer C
	WHERE C.CustomerId IN
		( 
			SELECT A.CustomerId
			FROM Account A
			WHERE A.Balance > 1000
			)
	GROUP BY C.Country
GO

INSERT INTO Views (Name) VALUES ('VAccount'), ('VCustomersFromRomania'), ('VCustomers')
INSERT INTO TestViews (TestID, ViewID) VALUES (1, 1), (1, 2), (1, 3)
INSERT INTO Tables (Name) VALUES ('Supervisor') -- table with a single column primary key and no foreign keys
INSERT INTO Tables (Name) VALUES ('Account') -- table with a single column primary key and at least one foreign key
INSERT INTO Tables (Name) VALUES ('CustomerEmployee') -- table with a multicolumn primary key

GO
CREATE PROCEDURE insert_customers
AS
	DECLARE @current_row INT = 8
	DECLARE @NoOfRows int
	SELECT @NoOfRows = NoOfRows FROM TestTables WHERE TestID = 2
	WHILE @current_row < @NoOfRows
		BEGIN
			DECLARE @customerID VARCHAR(15) = 'cus' + convert(varchar(5), @current_row)
			INSERT INTO Customer VALUES (@customerID, 'test_value', 'test_value', 'test_value', 'test_value', 0, 'test_value')
			SET @current_row = @current_row + 1
		END
GO

CREATE PROC delete_customers
AS
	DECLARE @current_row INT = 8
	DECLARE @NoOfRows int 
	SELECT @NoOfRows = NoOfRows FROM TestTables WHERE TestID = 3 
	WHILE @current_row < @NoOfRows
		BEGIN 
			DECLARE @customerID VARCHAR(15) = 'cus' + convert(varchar(5), @current_row)
			DELETE FROM Customer WHERE CustomerId = @customerID
			SET @current_row = @current_row + 1
		END

GO


CREATE PROC insert_loan
AS
	DECLARE @current_row INT = 17
	DECLARE @NoOfRows int
	SELECT @NoOfRows = NoOfRows FROM TestTables WHERE TestID = 4
	INSERT INTO Customer VALUES ('1', 'test_value', 'test_value', 'test_value', 'test_value', 0, 'test_value')
	WHILE @current_row < @NoOfRows
		BEGIN
			DECLARE @loanID VARCHAR(15) = 'loan' + convert(varchar(5), @current_row)
			DECLARE @fk_placeholder VARCHAR(10) = '1'

			INSERT INTO Loan VALUES(@fk_placeholder, @loanID, 0)
			SET @current_row = @current_row + 1
		END
GO

CREATE PROC delete_loan
AS
	DECLARE @current_row INT = 17
	DECLARE @NoOfRows int
	SELECT @NoOfRows = NoOfRows FROM TestTables WHERE TestID = 5
	WHILE @current_row < @NoOfRows
		BEGIN 
			DECLARE @loanID VARCHAR(15) = 'loan' + convert(varchar(5), @current_row)
			DELETE FROM Loan WHERE LoanId = @loanID
			SET @current_row = @current_row + 1
		END

GO


CREATE PROC insert_CustomerEmployee
AS
	DECLARE @current_row INT = 15
	DECLARE @NoOfRows int
	SELECT @NoOfRows = NoOfRows FROM TestTables WHERE TestID = 6
	EXECUTE insert_customers
	INSERT INTO Employee VALUES ('1', '9', 'test_value', 'test_value','test_value', NULL, 0)
	WHILE @current_row < @NoOfRows
		BEGIN
			DECLARE @customerID VARCHAR(15) = 'cus' + convert(varchar(5), @current_row)
			DECLARE @employeeID VARCHAR(15) = '1'
			INSERT INTO CustomerEmployee VALUES (@customerID, @employeeID)
			SET @current_row = @current_row + 1
		END
GO

CREATE PROC delete_CustomerEmployee
AS
	EXECUTE delete_customers
GO



INSERT INTO Tests (Name) VALUES ('select_view'), 
									('insert_customers'),
									('delete_customers'),
									('insert_loan'),
									('delete_loan'),
									('insert_CustomerEmployee'),
									('delete_CustomerEmployee')


INSERT INTO TestTables (TestID, TableID, NoOfRows, Position) VALUES (2, 1, 25, 1),
																	(3, 1, 25, 2),
																	(4, 2, 100, 1),
																	(5, 2, 100, 1),
																	(6, 3, 100, 1),
																	(7, 3, 100, 1)

go


create or alter PROC TestRunView
as
  begin
    DECLARE @startTime1 DATETIME;
    DECLARE @endTime1 DATETIME;
    DECLARE @startTime2 DATETIME;
    DECLARE @endTime2 DATETIME;
    DECLARE @startTime3 DATETIME;
    DECLARE @endTime3 DATETIME;
	DECLARE @test_run_id INT;

	SET @test_run_id = CONVERT(INT, (SELECT last_value FROM sys.identity_columns WHERE name = 'TestRunID'))

    SET @startTime1 = GETDATE();
    EXEC ('select * from VAccount');
    PRINT 'select * from VAccount';
    SET @endTime1 = GETDATE();

    INSERT INTO TestRuns VALUES ('test_view1', @startTime1, @endTime1)
	SET @test_run_id = CONVERT(INT, (SELECT last_value FROM sys.identity_columns WHERE name = 'TestRunID'))
    INSERT INTO TestRunViews(TestRunID, ViewID, StartAt, EndAt) values (@test_run_id, 1, @startTime1, @endTime1);

    SET @startTime2 = GETDATE();
    EXEC ('select * from VCustomersFromRomania');
    PRINT 'select * from VCustomersFromRomania';
    SET @endTime2 = GETDATE();
    INSERT INTO TestRuns VALUES ('test_view2', @startTime2, @endTime2)
	SET @test_run_id = CONVERT(INT, (SELECT last_value FROM sys.identity_columns WHERE name = 'TestRunID'))
    INSERT INTO TestRunViews(TestRunID, ViewID, StartAt, EndAt) values (@test_run_id, 2, @startTime2, @endTime2);

    SET @startTime3 = GETDATE();
    EXEC ('select * from VAccount');
    PRINT 'select * from VAccount';
    SET @endTime3 = GETDATE();
    INSERT INTO TestRuns VALUES ('test_view3', @startTime3, @endTime3)
	SET @test_run_id = CONVERT(INT, (SELECT last_value FROM sys.identity_columns WHERE name = 'TestRunID'))
    INSERT INTO TestRunViews(TestRunID, ViewID, StartAt, EndAt) values (@test_run_id, 3, @startTime3, @endTime3);
  end
GO


CREATE OR ALTER PROC TestRunInsertRemove
  AS
    begin
      DECLARE @startTime1 DATETIME;
      DECLARE @endTime1 DATETIME;

      DECLARE @startTime2 DATETIME;
      DECLARE @endTime2 DATETIME;

      DECLARE @startTime3 DATETIME;
      DECLARE @endTime3 DATETIME;

      DECLARE @startTime4 DATETIME;
      DECLARE @endTime4 DATETIME;

	  DECLARE @startTime5 DATETIME;
      DECLARE @endTime5 DATETIME;

	  DECLARE @startTime6 DATETIME;
      DECLARE @endTime6 DATETIME;
	  DECLARE @test_run_id INT;

	  	  
      SET @startTime5 = GETDATE()
      exec insert_customers
      print ('exec insert_customers')
      SET @endTime5 = GETDATE()
      INSERT INTO TestRuns values ('test_insert_seasons', @startTime5, @endTime5)
	  SET @test_run_id = CONVERT(INT, (SELECT last_value FROM sys.identity_columns WHERE name = 'TestRunID'))
      INSERT INTO TestRunTables VALUES (@test_run_id, 3, @startTime5, @endTime5)

      SET @startTime3 = GETDATE()
      exec insert_loan
      print ('exec insert_loan')
      SET @endTime3 = GETDATE()
      INSERT INTO TestRuns values ('test_insert_teams', @startTime3, @endTime3)
	  SET @test_run_id = CONVERT(INT, (SELECT last_value FROM sys.identity_columns WHERE name = 'TestRunID'))
      INSERT INTO TestRunTables VALUES (@test_run_id, 2, @startTime3, @endTime3)


      SET @startTime1 = GETDATE()
      EXEC insert_CustomerEmployee
      PRINT ('exec insert_CustomerEmployee')
      SET @endTime1 = GETDATE()
      INSERT INTO TestRuns VALUES ('test_insert_ranking', @startTime1, @endTime1)
	  SET @test_run_id = CONVERT(INT, (SELECT last_value FROM sys.identity_columns WHERE name = 'TestRunID'))
      INSERT INTO TestRunTables VALUES (@test_run_id, 1, @startTime1, @endTime1)

      SET @startTime2 = GETDATE()
      EXEC delete_CustomerEmployee
      PRINT ('exec delete_CustomerEmployee')
      SET @endTime2 = GETDATE()
      INSERT INTO TestRuns VALUES ('test_delete_ranking', @startTime2, @endTime2)
	  SET @test_run_id = CONVERT(INT, (SELECT last_value FROM sys.identity_columns WHERE name = 'TestRunID'))
      INSERT INTO TestRunTables VALUES (@test_run_id, 1, @startTime1, @endTime1)


	  SET @startTime4 = GETDATE()
      exec delete_customers
      print ('exec delete_customers')
      SET @endTime4 = GETDATE()
      INSERT INTO TestRuns values ('test_delete_teams', @startTime4, @endTime4)
	  SET @test_run_id = CONVERT(INT, (SELECT last_value FROM sys.identity_columns WHERE name = 'TestRunID'))
      INSERT INTO TestRunTables VALUES (@test_run_id, 2, @startTime4, @endTime4)

	  SET @startTime6 = GETDATE()
      exec delete_loan
      print ('exec delete_loan')
      SET @endTime6 = GETDATE()
      INSERT INTO TestRuns values ('test_delete_seasons', @startTime6, @endTime6)
	  SET @test_run_id = CONVERT(INT, (SELECT last_value FROM sys.identity_columns WHERE name = 'TestRunID'))
      INSERT INTO TestRunTables VALUES (@test_run_id, 3, @startTime6, @endTime6)

    end
  GO