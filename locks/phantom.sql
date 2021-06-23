-- query console 1
select @@SPID
select @@TRANCOUNT
DBCC USEROPTIONS


delete from Bank
delete from BankBranch
insert into Bank(bank_id, name, country) values (1, 'name1', '2')
insert into BankBranch(bbid, bank_id, number_of_employees, value, name) values (1, 1, 1, 2, 'name1')
insert into BankBranch (bbid, bank_id, number_of_employees, value, name) values (2, 1, 2, 3, 'name2')


begin tran
waitfor delay '00:00:05'
insert into BankBranch (bbid, bank_id, number_of_employees, value, name) values (3, 1, 3, 4, 'name3')
exec sp_log_changes null, 3, 'Phantom 1: insert',null
exec sp_log_locks 'Phantom 1: after insert'
commit tran

