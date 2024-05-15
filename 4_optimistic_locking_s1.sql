-- Optimistic Locking Implementation
# 2
begin;
# 4
select * from account_balance_0;
# 6: Whats gonna happen here?
update account_balance_0
set balance = balance - 10, version = 4
where account_number = 2 and version = 3;
# 9: Fails here