	-- Union of all customers, including family members which also use the account at the current bank

	SELECT FirstName, LastName FROM Customer
	UNION ALL
	SELECT FirstName, LastName FROM FamilyMembers
	ORDER BY LastName


	-- OR: Select the customers that are either managed by Daniel or by Sofia

	SELECT C.FirstName, C.LastName
	FROM Customer C, Employee E, CustomerEmployee M
	WHERE C.CustomerId = M.CustomerId AND M.EmployeeId = E.EmployeeId AND
		( E.FirstName = 'Daniel' OR E.FirstName = 'Sofia')

	 -- intersect : Select the employees who are also clients to the bank

	 Select C.FirstName, C.LastName
	 FROM Customer C
	 INTERSECT 
	 SELECT E.FirstName, E.LastName
	 FROM Employee E


	-- in: select all customers who took a loan and also have an account
	SELECT DISTINCT C.FirstName, C.LastName
	FROM Customer C, Loan L
	WHERE C.CustomerId IN (SELECT CustomerId FROM Loan)


	-- SELECT the list of customers clients to the bank except the ones that are managed by Sofia

	SELECT DISTINCT C.FirstName, C.LastName
	FROM Customer C
	EXCEPT 
	SELECT C.FirstName, C.LastName
	FROM Customer C, Employee E, CustomerEmployee M
	WHERE C.CustomerId = M.CustomerId AND M.EmployeeId = E.EmployeeId AND
		E.FirstName = 'Sofia'

 --NOT IN: Select the accounts who have yet to create their savings account

 SELECT DISTINCT A.Username
 FROM Account A, Savings S
 WHERE A.AccountId NOT IN (
 SELECT S.AccountId
 FROM Savings S)

 -- Select customers who took at least 1 loan INNER JOIN

 SELECT C.FirstName, C.LastName, L.LoanId, L.Amount
 FROM Customer C
 INNER JOIN Loan L ON C.CustomerId = L.CustomerId

 --left join: supervisor - supervised by - employee ; displays also the employees who are not supervised, sorted alphabetically

 SELECT E.FirstName, E.LastName, V.FirstName, V.LastName
 FROM Employee E
 LEFT JOIN SupervisedBy B ON E.EmployeeId = B.EmployeeId
 LEFT JOIN Supervisor V ON B.SupervisorId = V.SupervisorId
 ORDER BY 1


 --right join: customer - customeremployee - employee Also displaying the customers who have yet to be taken by an employee

 
 SELECT C.FirstName, C.LastName, E.FirstName, E.LastName
 FROM Employee E
 RIGHT JOIN CustomerEmployee M ON E.EmployeeId = M.EmployeeId
 RIGHT JOIN Customer C ON M.CustomerId = C.CustomerId
 
 -- full join: customer - employee - supervisor

 SELECT C.FirstName, C.LastName, E.FirstName, E.LastName, S.FirstName, S.LastName
 FROM Customer C
 FULL JOIN CustomerEmployee M ON C.CustomerId = M.CustomerId
 FULL JOIN Employee E ON M.EmployeeId = E.EmployeeId
 FULL JOIN SupervisedBy B ON E.EmployeeId = B.EmployeeId
 FULL JOIN Supervisor S ON B.SupervisorId = S.SupervisorId 

 -- IN: Select customers who are managed by an the employee with the family name Pop.

 SELECT C.FirstName, C.LastName
 FROM Customer C
 WHERE C.CustomerId IN
	( SELECT A.CustomerId
	FROM CustomerEmployee A
	WHERE A.EmployeeId  IN
	 ( SELECT E.EmployeeId
		FROM Employee E
		WHERE E.LastName ='Pop'
		)
		)

-- IN: SELECT ALL CLIENTS managed by the employee with the id 155

 SELECT C.FirstName, C.LastName
 FROM Customer C
 WHERE C.CustomerId IN
	( SELECT A.CustomerId
	FROM CustomerEmployee A
	WHERE A.EmployeeId = '155' )

-- Exists: find the customers which are managed by employee with id 160

 SELECT C.FirstName, C.LastName
 FROM Customer C
 WHERE EXISTS
	( SELECT *
	FROM CustomerEmployee A
	WHERE A.EmployeeId = '160' AND A.CustomerId = C.CustomerId)


--EXISTS: find the customers who took a loan of more than 1000

 SELECT C.FirstName, C.LastName
 FROM Customer C
 WHERE EXISTS
	( SELECT *
	FROM Loan A
	WHERE A.Amount > 1000 AND A.CustomerId = C.CustomerId)

-- sUBQUERY in FORM: find employees who have had a supervisor for at least 2 years

SELECT E.FirstName, E.LastName
 FROM Employee E INNER JOIN
		( SELECT *
		FROM SupervisedBy S
		WHERE S.YearsActive >= 2
		) A
ON E.EmployeeId = A.EmployeeId
ORDER BY 1


-- subquery in form: display all accounts usernames and current balance having a savings account with a balance of at least 2000

SELECT A.Username, A.Balance
 FROM Account A INNER JOIN
		( SELECT *
		FROM Savings S
		WHERE S.Balance >= 2000
		) R
ON A.AccountId = R.AccountId
ORDER BY 1

--GROUP BY: numbers of customers by gender and show the average age

SELECT COUNT(CustomerId), Gender, AVG(Age) As AverageAge
From Customer
GROUP BY GENDER;

--  GROUP BY: List the number of customers from each country, but only include countries with at least 2 customers

SELECT COUNT(CustomerId), Country, MIN(Age) As YoungestCustomer, MAX(Age) As OldestCustomer
From Customer
GROUP BY Country
HAVING COUNT(CustomerId) >= 2;

-- GROUP BY: group accounts by username if the account has at least 2 family members registered to it.

SELECT A.AccountId, SUM(A.Balance) AS TotalBalance
FROM Account A
GROUP BY A.AccountId
HAVING 2 <= ( SELECT COUNT(*)
				FROM FamilyMembers F
				WHERE F.AccountId = A.AccountId)


-- group by: Dsiplay employees who manage at least 2 customers

SELECT E.EmployeeId, SUM(E.Salary) AS Salary
FROM Employee E
GROUP BY E.EmployeeId
HAVING 2 <= ( SELECT COUNT(*)
				FROM CustomerEmployee F
				WHERE F.EmployeeId = E.EmployeeId)




-- ANY : rewritten with IN

 SELECT C.FirstName, C.LastName
 FROM Customer C
 WHERE C.CustomerId = ANY
	( SELECT A.CustomerId
	FROM CustomerEmployee A
	WHERE A.EmployeeId = '155' )

 SELECT C.FirstName, C.LastName
 FROM Customer C
 WHERE C.CustomerId IN
	( SELECT A.CustomerId
	FROM CustomerEmployee A
	WHERE A.EmployeeId = '155' )

-- ALL rewritten with not in:

SELECT DISTINCT A.Username
 FROM Account A, Savings S
 WHERE A.AccountId <> ALL(
 SELECT S.AccountId
 FROM Savings S)

SELECT DISTINCT A.Username
 FROM Account A, Savings S
 WHERE A.AccountId NOT IN (
 SELECT S.AccountId
 FROM Savings S)

 --ANY: Find employees who have a greater salary than Hash Dan and check how much a 3% raise would mean

 SELECT E.FirstName, E.LastName, E.Salary*3/100 AS PossibleRaise
 FROM Employee E
 WHERE E.Salary > ANY
		( SELECT E2.Salary
		FROM Employee E2
		WHERE E2.FirstName = 'Hash' AND E2.LastName = 'Dan'
		)

-- ANY REwritten with aggregator

 SELECT E.FirstName, E.LastName, E.Salary
 FROM Employee E
 WHERE E.Salary > ANY
		( SELECT MAX(E2.Salary)
		FROM Employee E2
		GROUP BY E2.FirstName, E2.LastName
		HAVING E2.FirstName = 'Hash' AND E2.LastName = 'Dan'
		)

--ALL : Select all supervisors which earn at most how much Gicu earns and show how much a 10% raise would mean

SELECT S.FirstName, S.LastName, S.Salary/10 As PossibleRaise
FROM Supervisor S
WHERE S.Salary < ALL
		(SELECT S2.Salary
		FROM Supervisor S2
		WHERE S2.FirstName = 'Gicu'
		)

-- all rewritten:

SELECT S.FirstName, S.LastName, S.Salary/10 As PossibleRaise
FROM Supervisor S
WHERE S.Salary < ALL
		(SELECT MIN(S2.Salary)
		FROM Supervisor S2
		GROUP BY S2.FirstName
		HAVING S2.FirstName = 'Gicu'
		)

