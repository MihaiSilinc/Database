drop table Payment
drop table Loan
drop table Transactions
drop table FamilyMembers
drop table Savings
drop table Account
drop table CustomerEmployee
drop table SupervisedBy
drop table Supervisor
drop table Employee
drop table BankBranch
drop table Bank
drop table Customer

CREATE TABLE Customer
	(CustomerId INT PRIMARY KEY NOT NULL,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	Gender VARCHAR(50),
	Email VARCHAR(50),
	Age INT,
	Country VARCHAR(50)
	)

CREATE TABLE Account
	(CustomerId INT REFERENCES Customer(CustomerId),
	AccountId INT PRIMARY KEY,
	Username VARCHAR(50) UNIQUE, 
	Passw VARCHAR(50) NOT NULL,
	Balance int,
	DateCreated date)

CREATE TABLE Bank
	(BankId INT PRIMARY KEY,
	Name VARCHAR(50))

CREATE TABLE BankBranch
	(BankBranchId INT PRIMARY KEY,
	City VARCHAR(50),
	BankId int references Bank(BankId)
	)



CREATE TABLE Employee
	(EmployeeId INT PRIMARY KEY,
	Title VARCHAR(50),
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	BankBranchId INT REFERENCES BankBranch(BankBranchId) ON DELETE CASCADE,
	Salary INT
	)

CREATE TABLE CustomerEmployee
	(EmployeeId INT REFERENCES Employee(EmployeeId),
	CustomerId INT REFERENCES Customer(CustomerId),
	PRIMARY KEY (EmployeeId, CustomerId))

CREATE TABLE Loan
	(CustomerId INT REFERENCES Customer(CustomerId),
	LoanId INT PRIMARY KEY,
	Amount INT)

CREATE TABLE Payment
	(LoanId INT REFERENCES Loan(LoanId),
	PaymentId INT PRIMARY KEY,
	Amount INT, 
	MonthlyDate date)

CREATE TABLE FamilyMembers
	(AccountId INT REFERENCES Account(AccountId),
	MemberId INT PRIMARY KEY,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	)

CREATE TABLE Savings
	(AccountId INT REFERENCES Account(AccountId),
	SavingsId INT PRIMARY KEY,
	Balance INT,
	Interest INT,
	DateLastAccessed date)

CREATE TABLE Transactions
	(TransactionId INT PRIMARY KEY,
	EmployeeId int,
	CustomerId int,
	FOREIGN KEY (EmployeeId, CustomerId) REFERENCES CustomerEmployee(EmployeeId, CustomerId),
	ReceiverName VARCHAR(50),
	Amount INT,
	ReceiverIBAN VARCHAR(50))

CREATE TABLE Supervisor
	(SupervisorId INT PRIMARY KEY,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	Salary INT)

CREATE TABLE SupervisedBy
	(EmployeeId INT REFERENCES Employee(EmployeeId),
	SupervisorId INT REFERENCES Supervisor(SupervisorId),
	YearsActive INT)
	



INSERT INTO Customer(CustomerId, FirstName, LastName, Gender, Email, Age, Country)
VALUES ('123', 'Mihai', 'Silinc', 'Male', 'mihaisilinc@yahoo.com', 31, 'Romania'), 
('169', 'Gicu', 'Petrescu', 'Male', 'petreasca@gmail.com', 24, 'Romania'), 
('112', 'Marinela', 'Pepela', 'Female', 'feleaga@yahoo.com', 33, 'Romania'), 
('119', 'Alexandru', 'Nemere', 'Male', 'level10faceit@yahoo.com', 29, 'Denmark'), 
('130', 'Marin', 'Dede', 'Male', 'gigicu@yahoo.com', 22, 'Italy'), 
('120', 'Ela', 'Pepe', 'Female', 'Dede2000@yahoo.com', 18, 'Italy'),
('131', 'New', 'Guy', 'Male', 'newguy@gmail.com', 19, 'Germany'),
('999', 'Sofia', 'Pop', 'Female', 'sofiapop@gmail.com', 35, 'Germany')
INSERT INTO Customer(CustomerId, FirstName, LastName, Gender, Email, Age, Country)
VALUES ('49', 'Yaya', 'Toure', 'Male', 'mihaisilinc@yahoo.com', 51, 'Romania'), 
('20', 'Ana', 'Ionica', 'Female', 'ionica@gmail.com', 66, 'Germany')
/*
	Query that violates integrity constraints:
Customer cannot have null values:
INSERT INTO Customer(CustomerId, FirstName, LastName, Gender, Email)
VALUES (NULL, 'Gica', 'Tica', 'gicatica@yahoo.com')

Customer cannot have duplicate id:
INSERT INTO Customer(CustomerId, FirstName, LastName, Gender, Email)
VALUES (131, 'Gica', 'Tica', 'gicatica@yahoo.com')

*/

INSERT INTO Bank(BankId, Name)
VALUES ('911', 'DunderMifflin')

INSERT INTO BankBranch(BankBranchId, City, BankId)
VALUES (1, 'Scranton', '911'), 
(2, 'New York', '911'), 
(3, 'Bucharest', '911'), 
(4, 'Ploiesti', '911'),
(5, 'Scranton', '911'),
(6, 'Cluj-Napoca', '911')

INSERT INTO Employee(EmployeeId, Title, FirstName, LastName, BankBranchId, Salary)
VALUES ('155', 'Manager', 'Daniel', 'Maguleanu', 1, 5000), 
('156', 'Analyst', 'Guru', 'Popescu', 1, 3000),
('158', 'Accountant', 'Gigi', 'Marcel', 2, 2500),
('159', 'Analyst', 'Titi', 'Bebe', 2, 3100),
('160', 'Manager', 'Sofia', 'Pop', 2, 4900),
('161', 'Manager', 'Matei', 'Ioan', 3, 5100),
('162', 'Accountant', 'Gicu', 'GG', 4, NULL),
('101', 'Accountant', 'Hash', 'Dan', 4, 3900),
('199', 'Banker', 'Nemerebine', 'Dani', 4, 6000),
('250', 'Manager', 'Mihaita', 'Piticu', 4, 5500)

INSERT INTO Supervisor(SupervisorId, FirstName, LastName, Salary)
VALUES ('199', 'Hercule', 'Dorian', 4000),
('200', 'Hercule', 'Stancu', 3000),
('201', 'Popa', 'Dorian', 5000),
('202', 'Gicu', 'Gigel', 4000)

INSERT INTO SupervisedBy(EmployeeId, SupervisorId, YearsActive)
VALUES ('155', '199', 3),
('156', '199', 3),
('158', '200', 2),
('159', '201', 1)


INSERT INTO Loan(CustomerId, LoanId, Amount)
VALUES ('123', '10', 5000), 
('169', '48', 1550),
('123', '11', 1500)


INSERT INTO Payment(LoanId, PaymentId, Amount, MonthlyDate)
VALUES ('10', '1', '200', '2020-09-20'), 
('10', '2', '200', '2020-10-20')

INSERT INTO CustomerEmployee(EmployeeId, CustomerId)
VALUES('155', '20'),
	('155', '112'),
	('155', '119'),
	('160', '123'),
	('160', '130')

INSERT INTO Account(CustomerId, AccountId, Username, Passw, Balance, DateCreated)
VALUES ('20', 1, 'user1', 'p1', 6200, '2019-09-20'),
('119', 2, 'user2', 'p2', 2200, '2017-09-20'),
('112', 3, 'user3', 'p3', 6900, '2019-11-20'),
('123', 4, 'user4', 'p4', 1200, '2019-09-25'),
('131', 5, 'user5', 'p5', 10200, '2015-02-15'),
('130', 6, 'user6', 'p6', 5000, '2019-09-20'),
('120', 7, 'user7', 'p7', 8200, '2018-05-20'),
('169', 8, 'user8', 'p8', 200, '2020-09-20')

INSERT INTO FamilyMembers(AccountId, MemberId, FirstName, LastName)
VALUES ('1', '6999', 'Andrei', 'Mateus'),
		('1', '7000', 'Dede', 'Man'),
		('2', '7999', 'Gicu', 'Harev'),
		('3', '3299', 'Alex', 'Popos'),
		('3', '3111', 'Relu', 'Nelu')

INSERT INTO Savings(AccountId, SavingsId, Balance, Interest, DateLastAccessed)
VALUES (1, '99', 3000, 0.5, '2020-09-20'),
	 (3, '100', 15000, 0.5, '2020-10-20'),
	 (4, '101', 1000, 0.5, '2020-11-04'),
	 (6, '102', 5500, 0.5, '2020-10-20')

UPDATE Customer
SET CustomerId = 1000 + CustomerId
WHERE CustomerId <= 50 AND Gender = 'Male';

UPDATE Employee
SET Title = 'LoanOfficer'
WHERE BankBranchId = 1 AND Title = 'Analyst' OR Title = 'JuniorAccountant';

UPDATE BankBranch
SET BankId = '911'
WHERE NOT BankId = '911';

UPDATE Employee
SET Salary = Salary + Salary*10/100
WHERE Salary < 2500 OR (BankBranchId BETWEEN 1 AND 3)

UPDATE Customer
SET Email = 'Not available, must be changed'
Where Email LIKE '%@gmail.com'

--DELETE FROM BankBranch
--WHERE City IN ('Bucharest', 'Ploiesti')

DELETE FROM Employee
WHERE Salary IS NULL 

SELECT * FROM Employee
SELECT * FROM Customer
SELECT * FROM Loan