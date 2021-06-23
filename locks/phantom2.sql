-- query console 2
select @@SPID
select @@TRANCOUNT
DBCC USEROPTIONS

-- set transaction isolation level repeatable read
set transaction isolation level serializable --solution
begin tran
select * from BankBranch
exec sp_log_locks 'Phantom 2: between selects'
waitfor delay '00:00:05'
select * from BankBranch
exec sp_log_locks 'Phantom 2: after both selects'
commit tran 