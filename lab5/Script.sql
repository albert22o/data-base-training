--  Выполнить задания 1-3 с использованием оператора JOIN
--    1. Вывести информацию о всех заказах. Добавить для каждого заказа его продавца, если таковой имеется, или NULL, если продавец неизвестен.
select * from ord left join sal on ord.snum = sal.snum;
--    2. Напишите запрос, который выведет номер и стоимость заказа???, название и город продукта только для заказов, в которых продукт имеет вес не менее 500.
select onum,name,city from ord left join prod on weight >= 500 and ord.pnum = prod.pnum;
--    3. Вывести список имен всех покупателей. Для покупателей, имена которых начинаются с букв A или I, присоединить количество их заказов.
select name, count(onum) from cust left join ord on name ~'^[A-I]' group by "name";
--Выполнить задание 4 с использованием CROSS JOIN
--    4. Вывести все пары номеров продавцов. Исключить комбинации продавцов с самими собой, а также дубликаты строк, выводящие пары в обратном порядке.
select s.snum,s2.snum  from sal s cross join sal s2 where s.snum < s2.snum;
--Выполнить задание 5 с использованием NATURAL JOIN
--    5. Вывести результат естественного соединение таблиц ord и cust. По каким полям соединились таблицы? 
select * from ord natural join cust;
--Выполнить задания 6-7 с использованием UNION/EXPECT/INTERSECT
--    6. Вывести список номеров товаров, которые были в заказах от продавца 3001 и/или производились не в Москве.
 select pnum from ord where snum = 3001 union select pnum from prod where city != 'Moscow';
--    7. Вывести список первых букв, с которых начинались имена продавцов, но не начинались названия продуктов.
select substring(name,1,1) from sal except select substring(name,1,1) from prod;
--Выполнить задание 8 с использованием подзапроса
--    8. Вывести имена и общий объем (сумму) заказов всех продавцов, находящихся в городах, где суммарный рейтинг покупателей этого города больше? 400.
select name,count(onum) from sal join ord on sal.city = any(select city from cust group by city having sum(rating) >= 400) group by name;