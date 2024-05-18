-- 0. Transaction Problem: A --> B: 20
# 2
begin;

# 4
select * from account_balance 
where account_number = 5; -- balance = 50

# 6
update account_balance 
set balance = balance - 20
where account_number = 5;

# 8
commit ;




-- 1. Shared Lock
# 2
begin;
# 4
select * from account_balance 
where account_number = 5 for share ;

# 5
SELECT thread_id, index_name, lock_type, lock_mode, lock_status, lock_data
FROM   performance_schema.data_locks
WHERE  object_name = 'account_balance';

# 7: Whats gonna happen here?
update account_balance 
set balance = balance + 10
where account_number = 5;

# 8
rollback ;




-- 2. Exclusive Lock
# 2
begin;

# 3: Locked here
select * from account_balance 
where account_number = 5 for share ;

# 7
SELECT thread_id, index_name, lock_type, lock_mode, lock_status, lock_data
FROM   performance_schema.data_locks
WHERE  object_name = 'account_balance';

# 8
rollback ;




