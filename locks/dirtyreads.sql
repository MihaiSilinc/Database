  
-- query console 1
select @@SPID
select @@TRANCOUNT
DBCC USEROPTIONS

select * from Bank
select * from BankBranch
delete from Bank
delete from BankBranch
insert into Bank(bank_id, name, country) values (1, 'name1', '2')
insert into BankBranch(bbid, bank_id, number_of_employees, value, name) values (1, 1, 1, 2, 'name1')
insert into BankBranch (bbid, bank_id, number_of_employees, value, name) values (2, 1, 2, 3, 'name2')

set transaction isolation level read uncommitted
-- set transaction isolation level read committed --solution

begin tran
select * from BankBranch
exec sp_log_locks 'Dirty reads 2: after select'
waitfor delay '00:00:05'
select * from BankBranch
waitfor delay '00:00:05'
select * from BankBranch
commit tran
