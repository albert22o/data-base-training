-- 1. Создаем базу данных
CREATE DATABASE library_db;

-- 2. Создаем таблицу 'genres' (сначала независимые сущности)
CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT
);

-- 3. Создаем таблицу 'authors'
CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birth_year INTEGER CHECK (birth_year > 0 AND birth_year < EXTRACT(YEAR FROM CURRENT_DATE)),
    country VARCHAR(50)
);

-- 4. Создаем таблицу 'readers'
CREATE TABLE readers (
    reader_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    registration_date DATE NOT NULL DEFAULT CURRENT_DATE CHECK (registration_date <= CURRENT_DATE),
    phone VARCHAR(20)
);

-- 5. Создаем таблицу 'books' (зависит от authors и genres)
CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author_id INTEGER NOT NULL REFERENCES authors(author_id) ON DELETE CASCADE,
    genre_id INTEGER NOT NULL REFERENCES genres(genre_id) ON DELETE RESTRICT,
    publication_year INTEGER CHECK (publication_year > 0 AND publication_year <= EXTRACT(YEAR FROM CURRENT_DATE)),
    isbn VARCHAR(20) UNIQUE,
    in_stock BOOLEAN NOT NULL DEFAULT TRUE
);

-- 6. Создаем таблицу 'book_loans' (связывает readers и books)
CREATE TABLE book_loans (
    loan_id SERIAL PRIMARY KEY,
    book_id INTEGER NOT NULL REFERENCES books(book_id) ON DELETE CASCADE,
    reader_id INTEGER NOT NULL REFERENCES readers(reader_id) ON DELETE CASCADE,
    loan_date DATE NOT NULL DEFAULT CURRENT_DATE,
    due_date DATE NOT NULL CHECK (due_date >= loan_date),
    return_date DATE CHECK (return_date >= loan_date OR return_date IS NULL)
);