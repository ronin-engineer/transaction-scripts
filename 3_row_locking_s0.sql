-- Clear data
delete from account_balance 
where account_number not in (2, 5);

select * from account_balance;

-- Show Locks
# 1
begin;

# 2
update account_balance 
set balance = balance + 10
where account_number between 2 and 5;

# 3
SELECT thread_id, index_name, lock_type, lock_mode, lock_status, lock_data
FROM   performance_schema.data_locks
WHERE  object_name = 'account_balance';

# 10
rollback ;





