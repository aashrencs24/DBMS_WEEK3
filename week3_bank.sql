create database bank;
use bank;
create table branch(branch_name varchar(255) primary key, 
branch_city varchar(255), 
assets real);

insert into branch values("SBI_Chamrajpet", "Bangalore", 50000),
("SBI_ResidencyRoad","Bangalore",10000),
("SBI_ShivajiRoad","Bombay",20000),
("SBI_ParlimentRoad", "Delhi", 10000),
("SBI_Jantarmantar","Delhi",20000);

select * from branch;

create table BankAccount(acc_no int primary key, branch_name varchar(255), balance real, foreign key(branch_name) references branch(branch_name));
insert into BankAccount values(1,"SBI_Chamrajpet", 2000),
(2,"SBI_ResidencyRoad",5000),
(3,"SBI_ShivajiRoad",6000),
(4,"SBI_ParlimentRoad",9000),
(5,"SBI_Jantarmantar",8000);
insert into BankAccount values(6,"SBI_ShivajiRoad",4000),
(8,"SBI_ResidencyRoad",4000),
(9,"SBI_ParlimentRoad",3000),
(10,"SBI_ResidencyRoad",5000),
(11,"SBI_Jantarmantar",2000);

select * from BankAccount;

create table BankCustomer(customer_name varchar(255) primary key, 
customer_street varchar(255), 
city varchar(255));

insert into BankCustomer values("Avinash","Bull_Temple_Road","Bangalore"),
("Dinesh","Bannergatta_Road","Bangalore"),
("Mohan","NationalCollege_Road","Bangalore"),
("Nikil","Akbar_Road","Delhi"),
("Ravi", "Prithvirak_Road","Delhi");

select * from BankCustomer;

create table depositer(customer_name varchar(255), 
acc_no int primary key, 
foreign key(acc_no) references BankAccount(acc_no), 
foreign key(customer_name) references BankCustomer(customer_name));

insert into depositer values("Avinash",1),
("Dinesh",2),("Nikil",4),("Ravi",5),
("Avinash",8),("Nikil",9),("Dinesh",10),("Nikil",11);

select * from depositer ;

create table loan(loan_number int, 
branch_name varchar(255), 
amount real, primary key(loan_number), 
foreign key(branch_name) references branch(branch_name));

insert into loan values(1,"SBI_Chamrajpet",1000),
(2,"SBI_ResidencyRoad",2000),
(3,"SBI_ShivajiRoad",3000),
(4,"SBI_ParlimentRoad",4000),
(5,"SBI_Jantarmantar",5000);

select * from loan;

SELECT branch_name, (assets / 100000) AS "assets in lakhs"
FROM branch;


SELECT d.customer_name, ba.branch_name
FROM depositer d
JOIN BankAccount ba ON d.acc_no = ba.acc_no
GROUP BY d.customer_name, ba.branch_name
HAVING COUNT(*) >= 2;



CREATE VIEW BranchLoanSums AS
SELECT branch_name, SUM(amount) AS total_loan_amount
FROM loan
GROUP BY branch_name;

select * from BranchloanSums;

SELECT d.customer_name
FROM depositer d
JOIN BankAccount ba ON d.acc_no = ba.acc_no
JOIN branch b ON ba.branch_name = b.branch_name
WHERE b.branch_city = 'Delhi'
GROUP BY d.customer_name
HAVING COUNT(DISTINCT b.branch_name) = (
    SELECT COUNT(*)
    FROM branch
    WHERE branch_city = 'Delhi'
);


select customer_name, city 
from BankCustomer 
where city='Bangalore';

select acc_no, balance from BankAccount where balance>100000;


select branch_city, SUM(assets) from Branch group by branch_city;

select B.branch_name, SUM(A.balance) "Sum of Balances" from Branch B, BankAccount A 
group by B.branch_name;

select customer_name from Depositer    
group by customer_name 
having count(*)>1;

SELECT d.customer_name, bacc.acc_no, bc.city
FROM depositer d
JOIN BankAccount bacc ON d.acc_no = bacc.acc_no
JOIN BankCustomer bc ON d.customer_name = bc.customer_name;



select distinct customer_name 
FROM BankCustomer where customer_name NOT IN (
SELECT customer_name from depositer);

select distinct d.customer_Name from depositer d JOIN BankAccount ba ON d.acc_No = ba.acc_no
WHERE ba.branch_name IN (
SELECT branch_name from loan where branch_name IN(select branch_name FROM branch 
where branch_city ='Bangalore')
);

Select branch_name from branch where assets>ALL(select assets from branch where branch_city='Bangalore');


delete from BankAccount Where branch_name IN (select branch_name FROM branch
where branch_city='Bombay');

select * from BankAccount;

UPDATE BankAccount
SET balance = balance * 1.05;



select * from BankAccount;
