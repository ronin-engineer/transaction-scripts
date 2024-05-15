-- 1. Read Uncommitted

# 3
begin;

# 4
select * from account_balance 
where account_number = 2; -- 140

# 5
update account_balance
set balance = balance + 10
where account_number = 2;

# 7
rollback ;

select * from account_balance where account_number = 2;





-- 2. Read Committed
# 3
begin;

# 4
select * from account_balance
where account_number = 2; -- 140.000

# 5
update account_balance set balance = balance - 10
where account_number = 2;

# 6
select * from account_balance
where account_number = 2;   -- 130.000

# 8
commit ;




-- 3. Repeatable Read
# 3
begin;

# 5
update account_balance 
set balance = balance + 10
where account_number = 2;

# 6
commit ;

# 7
select * from account_balance 
where account_number = 2;   -- 140.000




-- 3.2. Read Phantom
# 3
begin;

# 5
insert into account_balance (account_number, balance)
value (3, 0);

# 6
commit ;

# 7
select * from account_balance;  -- 2, 3, 5




-- 4. Serialize
# 3
begin;

# 5
insert into account_balance (account_number, balance)
    value (4, 0);

---- Question: Why this statement is not executed yet?
---- Answer: MySQL locked records from 2 to 5
---- This statement will be executed after 8 (transaction 1 release the lock).

# 9
commit ;
#10
select * from account_balance;  -- 2, 3, 4, 5




