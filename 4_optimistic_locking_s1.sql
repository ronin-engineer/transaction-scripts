-- Optimistic Locking Implementation
-- 2 --> 5: 80
# 2
begin;

# 4
select * from account_balance_0 
where account_number = 2;   -- balance: 150.000, version: 1


# 6: Whats gonna happen here?
update account_balance_0
set balance = balance - 80, version = 2
where account_number = 2 and version = 1;

# 9: Fails here