-- query console 1
select @@SPID
select @@TRANCOUNT
DBCC USEROPTIONS

delete from Bank
delete from BankBranch
insert into Bank(bank_id, name, country) values (1, 'name1', '2')

alter database lab3 set allow_snapshot_isolation on
-- set transaction isolation level read uncommitted --solution
set transaction isolation level snapshot

begin tran
declare @oldData varchar(100)
declare @newData varchar(100)
update Bank set @oldData=name, name='name2', @newData=name where bank_id=1
waitfor delay '00:00:05'
exec sp_log_changes @oldData, @newData, 'Update Conflict 1: update',null
exec sp_log_locks 'Update Conflict 1: after update'
select * from Bank
commit tran

