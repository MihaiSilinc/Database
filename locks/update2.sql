-- query console 2
select @@SPID
select @@TRANCOUNT
DBCC USEROPTIONS

-- set transaction isolation level read uncommitted --solution
set transaction isolation level snapshot

begin tran
declare @oldData varchar(100)
declare @newData varchar(100)
update Bank set @oldData=name, name='name3', @newData=name where bank_id=1
exec sp_log_changes @oldData, @newData, 'Update Conflict 2: update',null
exec sp_log_locks 'Update Conflict 2: after update'
select * from Bank
commit tran