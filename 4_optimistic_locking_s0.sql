-- Dataset
drop table account_balance_0;
create table account_balance_0
(
    account_number int            not null primary key,
    balance        decimal(18, 3) not null,
    version        bigint         not null
);

INSERT INTO payment.account_balance_0 (account_number, balance, version) VALUES (2, 150.000, 1);
INSERT INTO payment.account_balance_0 (account_number, balance, version) VALUES (5, 50.000, 1);

-- Optimistic Locking Implementation
-- 2 --> 5: 80
# 1
begin;

# 3
select * from account_balance_0 
where account_number = 2;   -- balance: 150.000, version: 1

# 5
update account_balance_0
set balance = balance - 80, version = 2
where account_number = 2 and version = 1;

# 7
SELECT thread_id, index_name, lock_type, lock_mode, lock_status, lock_data
FROM   performance_schema.data_locks
WHERE  object_name = 'account_balance_0';

# 8
commit ;



