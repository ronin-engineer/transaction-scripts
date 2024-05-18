-- Show Locks
# 4
begin;

# 5
insert into account_balance (account_number, balance)
value (3, 0);

# 6
insert into account_balance (account_number, balance)
value (9, 0);

# 7
insert into account_balance (account_number, balance)
value (1, 0);

# 8
select * from account_balance;

# 9
commit ;