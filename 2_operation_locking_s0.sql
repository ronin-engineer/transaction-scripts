-- A: 50
update account_balance set balance = 50
where account_number = 5;

-- 0. Transaction Problem: A --> C: 40
# 1
begin;

# 3
select * from account_balance 
where account_number = 5; -- balance = 50

# 5
update account_balance 
set balance = balance - 40
where account_number = 5;

# 7
commit ;

# 9
select * from account_balance
where account_number = 5; -- balance = -10.000

# 10
update account_balance 
set balance = 50
where account_number = 5;




-- 1. Shared Lock
# 1
begin;
# 2
select * from account_balance 
where account_number = 5 for share ;

# 3
SELECT thread_id, index_name, lock_type, lock_mode, lock_status, lock_data
FROM   performance_schema.data_locks
WHERE  object_name = 'account_balance';

# 6: Why this query can not be executed?
update account_balance 
set balance = balance + 10
where account_number = 5;

# 9
rollback ;




-- 2. Exclusive Lock
# 1
begin;
# 2
select * from account_balance 
where account_number = 5 for update ;

# 4
SELECT thread_id, index_name, lock_type, lock_mode, lock_status, lock_data
FROM   performance_schema.data_locks
WHERE  object_name = 'account_balance';

# 5
update account_balance set balance = balance + 10
where account_number = 5;

# 6
commit ;



