-- 1. Read Uncommitted

# 1
set transaction isolation level read uncommitted;
# 2
begin;

# 6: Dirty Read
select * from account_balance 
where account_number = 2;   -- 150.000

# 8: (Dont execute) transfer 150 from account 2
update account_balance
set balance = balance - 150 -- = -10 < 0 --> invalid
where account_number = 2;

# 9
select * from account_balance
where account_number = 2; -- -10

# 10
rollback ;




-- 2. Read Committed (default in Postgres)
# 1
set transaction isolation level read committed;
# 2
begin;

# 7
select * from account_balance 
where account_number = 2; -- read commited value: 140.000

---- Do something with balance = 140.000

# 9: Reading new committed value --> Problem: Non-repeatable Read
select * from account_balance 
where account_number = 2; -- 130.000

---- There might be bug, data inconsistency here 
---- because we handled with balance = 140 before

# 10
commit ;




-- 3. Repeatable Read (default in MySQL)
# 1
set transaction isolation level repeatable read ;
# 2
begin;

# 4
select * from account_balance 
where account_number = 2; -- 130.000

---- Do something with balance = 130.000

# 8
select * from account_balance 
where account_number = 2; -- 130.000

-- Do something in the right way with balance = 130.000

# 9
commit ;



-- Every query is wrapped by a transaction by default, even a SELECT query.
-- For example:
-- set transaction isolation level repeatable read ;
-- begin;
select * from account_balance where account_number = 2;
-- commit;



-- 3.1. Read Phantom
# 1
set transaction isolation level repeatable read ;
# 2
begin;

# 4
select * from account_balance 
where account_number between 2 and 5; -- 2, 5

# 8: Repeatable Read
select * from account_balance 
where account_number between 2 and 5; -- 2, 5

# 9: Do something wrong
update account_balance set balance = balance + 10
where account_number between 2 and 5;

# 10: Phantom Read
select * from account_balance 
where account_number between 2 and 5;   -- 2, 3, 5

# 11
rollback ;




-- 4. Serialize
# 1
set transaction isolation level serializable ;
# 2
begin;

# 4
select * from account_balance 
where account_number between 2 and 5;   -- 2, 3, 5

# 6
update account_balance set balance = balance + 10
where account_number between 2 and 5;

# 7
select * from account_balance 
where account_number between 2 and 5; -- 2, 3, 5 are updated only

# 8
commit ;




