-- query console 2
select @@TRANCOUNT
select @@SPID

begin tran
declare @oldData int
declare @newData int
update BankBranch set @oldData=value, value=1000, @newData=value where bbid=2
exec sp_log_changes @oldData, @newData, 'Deadlock 2: Update 1',null
exec sp_log_locks 'Deadlock 2: between updates'
waitfor delay '00:00:05'
update BankBranch set @oldData=value, value=1000, @newData=value where bbid=1
exec sp_log_changes @oldData, @newData, 'Deadlock 2: Update 2',null
commit tran