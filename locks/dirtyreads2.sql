-- query console 2
select @@SPID
select @@TRANCOUNT
DBCC USEROPTIONS

begin tran
declare @oldData int
declare @newData int
update BankBranch set @oldData=value, value=1000, @newData=value where bbid=1
exec sp_log_changes @oldData, @newData, 'Dirty reads 1: update', null
exec sp_log_locks 'Dirty reads 1: after update'
waitfor delay '00:00:05'
update BankBranch set @oldData=value, value=1500, @newData=value where bbid=1
exec sp_log_changes @oldData, @newData, 'Dirty reads 1: update', null
exec sp_log_locks 'Dirty reads 1: after update'
waitfor delay '00:00:05'
commit tran