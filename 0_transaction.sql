drop table account_balance;

-- Dataset
create table account_balance
(
    account_number int            not null primary key,
    balance        decimal(18, 3) not null
);

INSERT INTO payment.account_balance (account_number, balance) VALUES (2, 150.000);
INSERT INTO payment.account_balance (account_number, balance) VALUES (5, 50.000);


-- Failed Transaction
start transaction ;

select *
from account_balance
where account_number = 2;   -- 150

update account_balance
set balance = balance - 10
where account_number = 2;

select *
from account_balance
where account_number = 2; -- 140

-- Disconnect
rollback;

-- Check
select *
from account_balance;


-- Successful Transaction
-- start transaction ;
begin;

select *
from account_balance
where account_number = 2;

update account_balance
set balance = balance - 10
where account_number = 2;

update account_balance
set balance = balance + 10
where account_number = 5;

commit ;

-- Check
select *
from account_balance;