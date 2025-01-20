---- w3resources subquiries
--1
 SELECT * FROM salesman02
 insert into salesman02 values(5003, 'Lauson Hen','San Jose',0.12),
                              (5007,'Paul Adam','Rome',0.13)

 select distinct ord_no,purch_amt, ord_date, Customer_id, Salesman_id from Orders
 insert into orders values(70009,270.65,'2012-09-10',3001,5005),
(70007,948.5,'2012-09-10',3005,5002),
(70005,2400.6,'2012-07-27',3007,5001),
(70008,5760,'2012-09-10',3002,5001),
(70010,1983.43,'2012-10-10',3004,5006),
(70003,2480.4,'2012-10-10',3009,5003),
(70012,250.45,'2012-06-27',3008,5002),
(70011,75.29,'2012-08-17',3003, 5007),
(70013,3045.6,'2012-04-25',3002,5001);

--------------------1

 SELECT * FROM salesman02
 select* from orders

select* from orders
where salesman_id=(select salesman_Id from salesman02 
                    where name='Paul Adam')

------------------2
 SELECT * FROM salesman02
 select* from orders

select* from orders 
where Salesman_id in (select salesman_Id from salesman02 where city='london')
 
-----------3
select* from orders 
where Salesman_id in (select salesman_Id from salesman02 where Customer_id=3007)

---------4
select distinct ord_no,purch_amt, ord_date, Customer_id, Salesman_id from Orders

where purch_amt >(select avg(purch_amt) from orders 
                   where ord_date='2012-10-10')

-------5
select distinct ord_no,purch_amt, ord_date, Customer_id, Salesman_id from Orders

where salesman_id =(select Salesman_id from salesman02
                   where city='new york')



----- 6
select* from salesman02
select*from customer01

select comission from salesman02
where salesman_Id=(select salesman_Id from customer01
                   where city='paris')

-------7
select* from customer01
where customer_id=(select salesman_id-2001
from salesman02
where name='MC Lyon')


-------8
select grade,count(*)
from customer01
group by grade
 having grade>
(select avg(grade) 
from customer01
where city='new york')

----------9
select* from  salesman02
select* from orders

select * from orders
where  Salesman_id =(select Salesman_id from salesman02
                     where comission= (select max(comission)from salesman02))



------10
select* from customer01
select*from orders

select o.* , c.cust_name from orders as O
,customer01 as C 
where O.Customer_id=C.customer_id
and ord_date='2012-08-17'

-------11
select*from salesman02
select* from customer01

select salesman_Id, name from salesman02 as S
where 1<(select count(*) from customer
                    where salesman_Id=s.salesman_Id)


------12

select* from customer01
select distinct ord_no, purch_amt,ord_date, Customer_id, Salesman_id from orders

where purch_amt>(select avg(purch_amt) from orders)
                 
-----13
select 
       distinct ord_no, 
                purch_amt,
				ord_date, 
				Customer_id, 
				Salesman_id 
from orders

where purch_amt>=(select avg(purch_amt) from orders)


------14
select 
                ord_no, 
                max(purch_amt),
				ord_date, 
				Customer_id, 
				Salesman_id 
from orders
group by ord_date,
         ord_no,
		 Customer_id, 
		 Salesman_id 
having max(purch_amt)>1000


-----15   tushunmadim***********

select customer_id, cust_name, city from customer01
where exists 
            (select city from customer01
            where city='london')


-------16*****
select*from salesman02
select* from customer01
   

SELECT * FROM salesman02 WHERE salesman_id IN 
(SELECT DISTINCT salesman_id 
FROM customer01 a WHERE EXISTS (SELECT * FROM customer01 b 
WHERE b.salesman_id=a.salesman_id AND b.cust_name<>a.cust_name));


-----17
select*from salesman02
select* from customer01 

select* from salesman02
where salesman_Id in(select salesman_Id from customer01 A
where not exists (select* from customer01 b where b.salesman_id=a.salesman_id and b.cust_name<>a.cust_name)
)

------18
select*from salesman02
select*from orders

select* from salesman02 A
where  exists 
( select* from customer01 b
  where a.salesman_Id=b.salesman_id and 
    1< (select count(*) from orders o 
	where o.Customer_id=b.customer_id))

------19
select*from salesman02
select*from  customer01
select distinct ord_no,ord_date,purch_amt,Customer_id, Salesman_id 
into orderss
from orders
drop table orders
select* from orderss

select*from salesman02 as S
where exists(
             select*from customer01 as C  
			 where c.city=s. city)
             
-------20
select*from salesman02
select*from  customer01

select*from salesman02
where city in(select city from customer01)

-------21
select*from salesman02 S
where exists(select * from customer01 as C
              where s.name<c.cust_name)


---------22
select*from customer01
where grade>any(select Grade from customer 
                 where city<'new york')

--------23
select* from orderss
where purch_amt>any (select purch_amt from orderss
                  where ord_date='2012-09-10')

-----------24

select*from orderss 
where purch_amt <any(select max(purch_amt) from orderss o, customer01 c
                        where o.Customer_id=c.customer_id
						and c.city='london')

------25

select*from orderss 
where purch_amt <(select max(purch_amt) from orderss o, customer01 c
                        where o.Customer_id=c.customer_id
						and c.city='london')

------26
select*from customer01
where grade> all (select grade from customer01
             where city='New York ')

-----27
select*from salesman02
select*from customer01
select*from orderss

SELECT salesman02.name, salesman02.city, subquery1.total_amt FROM 
salesman02, (SELECT salesman_id, SUM(orderss.purch_amt) AS total_amt 
FROM orderss GROUP BY salesman_id) subquery1 WHERE subquery1.salesman_id = salesman02.salesman_id AND
salesman02.city IN (SELECT DISTINCT city FROM customer01);

----------28
select*from customer01 
where grade<> any (select grade from customer01
                    where city='london')


--------29

select*from customer01 
where grade<> any (select grade from customer01
                    where city='paris')
---------30
select*from customer01 
where not grade= any (select grade from customer01
                    where city='dallas')

--------------31
select*from company_mast
select*from Item_Mast

select c.COM_NAME as companies,avg(pro_price) as avg_price from company_mast C,Item_Mast I
where c.COM_ID=i.pro_com
group  by c.COM_NAME

-----32
select c.COM_NAME as companies,avg(pro_price) as avg_price 
from company_mast C,Item_Mast I
where c.COM_ID=i.pro_com 
group  by c.COM_NAME
having avg(pro_price)>=350

--------33
select c.COM_NAME as company,
       i.pro_name as product_name,
	   i.pro_price as Price
	  from Item_Mast I,company_mast C
where c.COM_ID=i.pro_com 
and i.pro_price=(select max(i.pro_price) from Item_Mast i
                    where   c.COM_ID=i.pro_com     )


-----34
select*from emp_details
where emp_lname in(  'Gabriel', 'dosio')


------35
select*from emp_details
where emp_dept in(89,63)
-----36

select*from emp_department
select*from emp_details

select emp_fname , emp_lname from emp_details 
where emp_dept in (select DPT_CODE from emp_department
                 where DPT_ALLOTMENT>50000)

--------------37
select*from emp_department
where DPT_ALLOTMENT >(select avg(dpt_allotment) 
                      from emp_department)

---------38
select*from emp_department
select*from emp_details

select dpt_name from emp_department A
where dpt_code in(
select emp_dept from emp_details
group by emp_dept
having count(*)>2)

-----39
select emp_fname,emp_lname from emp_details
where emp_dept in (select dpt_code from emp_department
            where DPT_ALLOTMENT=(select min(dpt_allotment) 
			                      from emp_department
								  where dpt_allotment>(select min(dpt_allotment) 
			                      from emp_department ))  )       

















