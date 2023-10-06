drop database if exists library;
Create  database library;
use library;
create table branch(
  Branch_no int PRIMARY KEY,
  Manager_Id int,
  Branch_address varchar(50),
  Contact_no varchar(20)
);
insert into branch (Branch_no, Manager_Id, Branch_address, Contact_no)
values
      (1, 11, 'kL14', 9000000001),
	  (2, 12, 'kL13', 9000000002),
      (3, 13, 'kL12', 9000000003),
      (4, 14, 'kL11', 9000000004),
      (5, 15, 'kL10', 9000000005);


create table  Employee(
 Emp_Id int PRIMARY KEY,
 Emp_name varchar(20),
 `Position` varchar(20),
 Salary int,
 Branch_no int
);
insert into Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
values 
  (1, 'John Smith', 'Manager', 60000, 1),
  (2, 'Jane Doe', 'Sales Associate', 40000, 4),
  (3, 'Mike Johnson', 'Technician', 45000, 2),
  (4, 'Sara White', 'Clerk', 35000, 3),
  (5, 'Robert Lee', 'Accountant', 55000, 4);


 create table Customer(
 Customer_Id varchar(20) PRIMARY KEY,
 Customer_name varchar(20),
 Customer_address varchar(20),
 Reg_date date
 );
 insert into Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
 values 
  (1, 'cr7', 'por', '2023-01-15'),
  (2, 'mbappe', 'fra', '2023-02-20'),
  (3, 'naimer', 'bra', '2023-03-10'),
  (4, 'messi', 'arg', '2023-04-05'),
  (5, 'marcelo', 'bra', '2023-05-12');
  

 create table Books(
 ISBN varchar(20) PRIMARY KEY,
 Book_title varchar(50),
 Category varchar(50),
 Rental_Price int,
 Status enum('yes', 'no'), -- [Give yes if book available and no if book not available]
 Author varchar(60),
 Publisher varchar(50)
 );
 
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES
  ('111-111', 'aaa', 'Fiction', 10, 'yes', 'un-a', 'a1'),
  ('111-112', 'bbb', 'Classic Literature', 12, 'yes', 'un-b', 'b1'),
  ('111-113', 'ccc', 'Technology', 25, 'no', 'un- c', 'c1'),
  ('111-114', 'ddd', 'Mystery', 9, 'yes', 'un-d', 'd1'),
  ('111-115', 'eee', 'Self-Help', 15, 'yes', 'un-e', 'e1');
  

 create table IssueStatus(
 Issue_Id int PRIMARY KEY,
 Issued_cust varchar(20), -- and it refer customer_id in CUSTOMER table
 Issued_book_name varchar(20),
 Issue_date date,
 Isbn_book varchar(20), -- Set as FOREIGN KEY and it should refer isbn in BOOKS table
 foreign key (Issued_cust) references Customer(Customer_Id),
 foreign key (Isbn_book) references Books(ISBN)
 );
 
 INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES
  (101, '1', 'aaa', '2023-06-05', '111-111'),
  (102, '2', 'bbb', '2023-10-05', '111-112'),
  (103, '3', 'ccc', '2023-10-05', '111-113'),
  (104, '4', 'ddd', '2023-10-05', '111-114'),
  (105, '5', 'eee', '2023-10-05', '111-115');
  
  
 create table ReturnStatus(
 Return_Id int PRIMARY KEY,
 Return_cust varchar(50),
 Return_book_name varchar(50),
 Return_date date,
 Isbn_book2 varchar(20),
 foreign key (Isbn_book2) references Books(ISBN));-- Set as FOREIGN KEY and it should refer isbn in BOOKS table

 INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES
  (3, 'mbappe', 'ccc', '2023-10-05', '111-113'),
  (4, 'naimer', 'ddd', '2023-10-05', '111-114'),
  (5, 'cr7', 'aaa', '2023-10-05', '111-111');
  

 -- Retrieve the book title, category, and rental price of all available books.
 select Book_title, Category, Rental_Price from books
 where status = 'yes';
 
 --  List the employee names and their respective salaries in descending order of salary.
select Emp_name, Salary from employee
order by Salary desc;
 
 -- etrieve the book titles and the corresponding customers who have issued those books.

select b.book_title, i.issued_cust from  IssueStatus as i
join books as b on i.Isbn_book = b.isbn; 

--  Display the total count of books in each category
select Category, count(*) as totcount
from books 
group by Category;

-- etrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.

select Emp_name, Position
from Employee
where Salary > 50000;

--  List the customer names who registered before 2022-01-01 and have not issued any books yet.

select c.Customer_name
from customer as c
left join issuestatus as i on c.customer_id = i.Issued_cust
where c.Reg_date < '2022-01-01' and i.Issued_cust is null;

-- Display the branch numbers and the total count of employees in each branch.

select Branch_no, count(*) as totempcount
from Employee
group by Branch_no;

--  Display the names of customers who have issued books in the month of June 2023.

select c.Customer_name
from customer as c
inner join issuestatus as i on c.customer_id = i.Issued_cust
where date_format(i.Issue_date, '%Y-%m') = '2023-06';

-- Retrieve book_title from book table containing history.

select Book_title 
from books
where Category = 'Fiction';

-- Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.

select Branch_no, count(*) as count_of_employee
from employee
group by Branch_no
having count(*)>5;


 
