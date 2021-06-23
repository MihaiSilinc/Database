-- query console 1
select @@TRANCOUNT
select @@SPID


delete from Bank
delete from BankBranch
insert into Bank(bank_id, name, country) values (1, 'name1', '2')
insert into BankBranch(bbid, bank_id, number_of_employees, value, name) values (1, 1, 1, 2, 'name1')
insert into BankBranch (bbid, bank_id, number_of_employees, value, name) values (2, 1, 2, 3, 'name2')

begin tran
declare @oldData int
declare @newData int
update BankBranch set @oldData=value, value=1000, @newData=value where bbid=1
exec sp_log_changes @oldData, @newData, 'Deadlock 1: Update 1',null
exec sp_log_locks 'Deadlock 1: between updates'
waitfor delay '00:00:05'
update BankBranch set @oldData=value, value=1000, @newData=value where bbid=2
exec sp_log_changes @oldData, @newData, 'Deadlock 1: Update 2',null
commit tran
