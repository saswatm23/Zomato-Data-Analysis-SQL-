CREATE TABLE goldusers_signup(userid integer,gold_signup_date date); 

INSERT INTO goldusers_signup(userid,gold_signup_date) 
 VALUES (1,'2017-09-22'),
(3,'2017-04-21');

--****************************************************************

CREATE TABLE users(userid integer,signup_date date); 

INSERT INTO users(userid,signup_date) 
 VALUES (1,'2014-09-02'),
(2,'2015-01-15'),
(3,'2014-04-11');

--***************************************************

CREATE TABLE sales(userid integer,created_date date,product_id integer); 

INSERT INTO sales(userid,created_date,product_id) 
 VALUES (1,'2017-04-19',2),
(3,'2019-12-18',1),
(2,'2020-07-20',3),
(1,'2019-10-23',2),
(1,'2018-03-19',3),
(3,'2016-12-20',2),
(1,'2016-11-09',1),
(1,'2016-05-20',3),
(2,'2017-09-24',1),
(1,'2017-03-11',2),
(1,'2016-03-11',1),
(3,'2016-11-10',1),
(3,'2017-12-07',2),
(3,'2016-12-15',2),
(2,'2017-11-08',2),
(2,'2018-09-10',3);

--***************************************************************

CREATE TABLE product(product_id integer,product_name text,price integer); 

INSERT INTO product(product_id,product_name,price) 
 VALUES
(1,'p1',980),
(2,'p2',870),
(3,'p3',330);


select * from sales;
select * from product;
select * from goldusers_signup;
select * from users;

(Q1)What is the total amount each customer spent on Zomato?

select s.userid,sum(p.price)as Total_Amount from sales s
join product p
on s.product_id=p.product_id
group by s.userid

(Q2)How many days has each customer visited Zomato?

Select userid,count(distinct created_date) as disinct_days
from sales
group by userid

(Q3)What was the first product bought by each of the customer?

select userid,created_date,product_id from
(select *,rank() over(partition by userid order by created_date) as Rank from sales)
where rank=1

(Q4)What is the most purchased item in the menu and how many times was it purchased by the customer?

select userid,count(product_id) as cnt  from sales 
where product_id=
(select product_id from sales
group by product_id
order by count(product_id) DESC
LIMIT 1)
group by userid


(Q5)Which item was the most popular among the customers?

select * from
(select *,rank() over(partition by userid order by cnt desc) as rnk from 
(select userid,product_id,count(product_id) as cnt from sales
group by userid,product_id))
where rnk=1
