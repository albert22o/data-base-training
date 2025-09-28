-- Вывести имена книг, которые еще не вернули
select title from books,book_loans where books.book_id = book_loans.book_id and return_date is null;
-- Вывести количество книг в каждом жанре
select genres.name,count(book_id ) from books,genres where genres.genre_id = books.genre_id group by genres.name;
-- Выведите полную информацию об имеющихся книгах (Имя, автор, жанр, год публикации)
