-- query console 1
select @@SPID
select @@TRANCOUNT
DBCC USEROPTIONS

delete from BankBranch
delete from Bank
insert into Bank(bank_id, name, country) values (1, 'name1', '2')
insert into BankBranch(bbid, bank_id, number_of_employees, value, name) values (1, 1, 1, 2, 'name1')
insert into BankBranch (bbid, bank_id, number_of_employees, value, name) values (2, 1, 2, 3, 'name2')


begin tran
declare @oldData int
declare @newData int
waitfor delay '00:00:05'
update BankBranch set @oldData=value, value=1000, @newData=value where bbid=1
exec sp_log_changes @oldData, @newData, 'Non-Repeatable Reads 1: update',null
exec sp_log_locks 'Non-Repeatable Reads 1: after update'
commit tran
