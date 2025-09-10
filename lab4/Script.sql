--1. Вывести покупателей, которые имеют минимальный рейтинг среди всех покупателей.
select name, rating from cust where rating = (select min(rating) from cust);;
--2. Для каждого товара вывести общее количество заказов с этим товаром, только если это количество заказов больше, чем у товара с номером 1001.
select prod.name,count(ord.pnum) from prod,ord where ord.pnum = prod.pnum group by prod.name having count(ord.pnum) > (select count(ord.pnum) from ord where ord.pnum = 1001);
--3. Выбрать покупателей, которые покупали продукты с номером 1004 у продавцов, которые когда-либо продавали продукт с номером 1002.
select cust.name from cust,ord where cust.cnum = ord.cnum and ord.pnum = 1004 and ord.snum = any(select ord.snum from ord where ord.pnum = 1002);
--4. Вывести названия всех продавцов, которые никогда не работали с покупателями из Новосибирска.
select name from sal where snum = any(select snum from ord where cnum != any(select cnum from cust where city = 'Novosibirsk'));
--5. Вывести товары, вес которых больше веса хотя бы одного товара из города Новосибирск.
select name from prod where weight > any(select weight from prod where city='Novosibirsk');
--6. Вывести товары, которые никогда не продавались продавцами из города, в котором произведен этот товар.
select prod.name from prod where prod.pnum not in (select ord.pnum from ord where ord.snum in (select sal.snum from sal where sal.city = prod.city));
--7. Вывести всю информацию о продавцах с дополнительным столбцом «округ продавца» со следующими вариантами значений: «северо-западный», если город Санкт-Петербург, «центральный», если город Москва, «сибирский», если город Новосибирск, или «другой» для остальных городов.
select *,case when city = 'Saint Petersburg' then 'северо-западный' when city = 'Moscow' then 'центральный' when city = 'Novosibirsk' then 'сибирский' else 'другой' end as округ_продавца from sal;
--8. Вывести из таблицы заказов уникальные номера продуктов и показатель популярности каждого из них на основе количества заказов: «популярный» — 4+ заказа, «умеренный» — 2-3 заказа, «непопулярный» — 1 заказ.
select pnum, case when count(pnum) >= 4 then 'популярный' when count(pnum) = 1 then 'непопулярный' else 'умеренный' end as популярность from ord group by pnum;