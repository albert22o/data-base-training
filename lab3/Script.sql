--1. Вывести количество продавцов из городов, начинающихся на буквы I-N.
select count(city) from sal where city~'^[I-N]';
--2. Вывести наименьший и наибольший вес из таблицы продуктов.
select max(weight),min(weight) from prod;
--3. Вывести для каждого продукта наименьший номер продавца, у которого этот продукт продавался.
select prod.name,min(ord.snum) from ord,prod where ord.pnum = prod.pnum group by prod.name;
--4. Вывести число уникальных продавцов, которые продавали товары покупателям с номерами 2005 и 2004. 
select count(DISTINCT snum) from ord where cnum = 2005 or cnum = 2004;
--5. Вывести для каждого покупателя его номер и общее количество проданных продуктов, если это количество не меньше, чем 15.
select cnum,count(pnum) from ord group by cnum having count(pnum) >= 15;
--6. Вывести количество заказов для всех уникальных пар продавец-продукт, между которыми осуществлялись заказы.
select snum,pnum,count(*) from ord group by snum,pnum;
--7. Вывести все даты, в которые в заказах участвовали ровно 3 покупателя и 1 продукт.
select ord_date,count(cnum),count(pnum) from ord group by ord_date having count(cnum) = 3 and count(pnum) = 1;
