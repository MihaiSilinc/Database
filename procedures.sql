
drop procedure changedMonthlyDateToChar
drop procedure originalMonthlyDate
drop procedure addTransactionDate
drop procedure originalTransaction
drop procedure changedBalanceDefault
drop procedure originalBalance
drop procedure addRemovePrimaryKeyInvestors
drop procedure removePrimaryKeyInvestors
drop procedure UniqueNameInvestors
drop procedure undoUniqueNameInvestors
drop procedure InvestorInBranch
drop procedure undoInvestorInBranch
drop procedure addTable
drop procedure originalTables

GO
-- a. modify the type of a column;
CREATE PROCEDURE changedMonthlyDateToChar
	AS 
		ALTER TABLE Payment
		ALTER COLUMN MonthlyDate VARCHAR(10)
	GO

CREATE PROCEDURE originalMonthlyDate
    AS 
		ALTER TABLE Payment
		ALTER COLUMN MonthlyDate date
	GO

--  add / remove a column;

CREATE PROCEDURE addTransactionDate
    AS
		ALTER TABLE Transactions
		ADD TransactionDate date
	GO

CREATE PROCEDURE originalTransaction
	AS
		ALTER TABLE Transactions
		DROP COLUMN TransactionDate
	GO

--  add / remove a DEFAULT constraint;

CREATE PROCEDURE changedBalanceDefault
	AS
		ALTER TABLE Account
		ADD CONSTRAINT df_Balance
		DEFAULT 0 FOR Balance
	GO

CREATE PROCEDURE originalBalance
	AS
		ALTER TABLE Account
		DROP CONSTRAINT df_Balance
	GO

-- d. add / remove a primary key;

CREATE PROCEDURE addRemovePrimaryKeyInvestors
AS
	ALTER TABLE Investors 
	ADD CONSTRAINT PK_InvestorId PRIMARY KEY(Id)
GO

CREATE PROCEDURE removePrimaryKeyInvestors
AS
	ALTER TABLE Investors
	DROP CONSTRAINT PK_InvestorId
GO

--e. add / remove a candidate key;

CREATE PROCEDURE UniqueNameInvestors
AS
	ALTER TABLE Investors 
	ADD CONSTRAINT UK_Name UNIQUE(Name)
GO

CREATE PROCEDURE undoUniqueNameInvestors
AS
	ALTER TABLE Investors
	DROP CONSTRAINT UK_Name
GO

--f. add / remove a foreign key;

CREATE PROCEDURE InvestorInBranch
AS
	ALTER TABLE Investors 
	ADD CONSTRAINT FK_BankBranchId FOREIGN KEY(BankBranchId) REFERENCES BankBranch(BankBranchId)
GO

CREATE PROCEDURE undoInvestorInBranch
AS
	ALTER TABLE Investors
	DROP CONSTRAINT FK_BankBranchId
GO

--g. create / drop a table.
CREATE PROCEDURE addTable
AS
	CREATE TABLE InvestorsAccount(
		Id INT,
		Name VARCHAR(10),
		Age INT,
		BankBranchId int
		);
GO

CREATE PROCEDURE originalTables
AS
	DROP TABLE InvestorsAccount
GO

drop table AllVersions
drop table VersionTable
-- CREATING a table in which i hold the names of all procedures
CREATE TABLE AllVersions(
Id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
NextVersion VARCHAR(30),
UndoVersion VARCHAR(30)
)
INSERT INTO AllVersions VALUES
('changedMonthlyDateToChar', 'originalMonthlyDate'),
('addTransactionDate', 'originalTransaction'),
('changedBalanceDefault', 'originalBalance'),
('addRemovePrimaryKeyInvestors', 'removePrimaryKeyInvestors'),
('UniqueNameInvestors', 'undoUniqueNameInvestors'),
('InvestorInBranch', 'undoInvestorInBranch'),
('addTable', 'originalTables')

--creating a table that holds the current version of the table.

CREATE TABLE VersionTable ( table_version INT ) 

INSERT INTO VersionTable VALUES ( 0 ) 
DROP PROCEDURE getVersion
GO
CREATE PROCEDURE getVersion(@next_version INT) 
	AS
		BEGIN
			IF @next_version < 0 OR @next_version > 7
				PRINT 'Invalid desired version.'
			ELSE
				BEGIN
					DECLARE @current_version INT
					DECLARE @procedure_name VARCHAR(50)
					SET @current_version = (	SELECT Tab.table_version FROM VersionTable Tab )
				
					WHILE @current_version < @next_version
						BEGIN
							SET @current_version = (@current_version+1)
							SELECT @procedure_name = NextVersion
							FROM AllVersions
							WHERE Id = @current_version
							PRINT @procedure_name
							EXECUTE @procedure_name
							UPDATE VersionTable SET table_version = @current_version
						END

					WHILE @current_version > @next_version
						BEGIN
							SELECT @procedure_name = UndoVersion
							FROM AllVersions
							WHERE Id = @current_version
							PRINT @procedure_name
							EXECUTE @procedure_name
							SET @current_version = (@current_version - 1)
							UPDATE VersionTable SET table_version = @current_version
						END

					
				END
		END
	GO

EXECUTE getVersion 2

SELECT *
FROM InvestorsAccount