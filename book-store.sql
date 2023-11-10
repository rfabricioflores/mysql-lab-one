DROP DATABASE IF EXISTS bookstore;

CREATE DATABASE bookstore;

USE bookstore;

-- Tabell: “author”

CREATE TABLE
    author (
        author_id INT UNSIGNED AUTO_INCREMENT NOT NULL,
        first_name VARCHAR(255),
        last_name VARCHAR(255),
        birth_date DATE,
        PRIMARY KEY(author_id)
    );

-- Tabell: "language"

CREATE TABLE
    language (
        language_id INT UNSIGNED AUTO_INCREMENT NOT NULL,
        language_name VARCHAR(50),
        PRIMARY KEY(language_id)
    );

-- Tabell: ”book”

CREATE TABLE
    book (
        isbn CHAR(13) NOT NULL,
        title VARCHAR(255),
        language_id INT UNSIGNED NOT NULL,
        price DECIMAL(10, 2),
        publication_date DATE,
        author_id INT UNSIGNED NOT NULL,
        PRIMARY KEY(isbn),
        FOREIGN KEY (author_id) REFERENCES author(author_id),
        FOREIGN KEY (language_id) REFERENCES language(language_id)
    );

-- Tabell: ”bookstore”

CREATE TABLE
    bookstore (
        bookstore_id INT UNSIGNED AUTO_INCREMENT NOT NULL,
        store_name VARCHAR(255),
        city VARCHAR(255),
        PRIMARY KEY(bookstore_id)
    );

-- Tabell: ”inventory”

CREATE TABLE
    inventory (
        store_id INT UNSIGNED NOT NULL,
        book_isbn CHAR(13) NOT NULL,
        amount INT NOT NULL,
        PRIMARY KEY (store_id, book_isbn),
        FOREIGN KEY (store_id) REFERENCES bookstore(bookstore_id),
        FOREIGN KEY (book_isbn) REFERENCES book(isbn)
    );

-- Lägg till några författare

INSERT INTO
    author (
        first_name,
        last_name,
        birth_date
    )
VALUES (
        'J.K.',
        'Rowling',
        '1965-07-31'
    ), (
        'George R.R.',
        'Martin',
        '1948-09-20'
    ), (
        'Agatha',
        'Christie',
        '1890-09-15'
    );

-- Lägg till några språk

INSERT INTO
    language (language_name)
VALUES ('English'), ('Swedish'), ('Spanish');

-- Lägg till några böcker

INSERT INTO
    book (
        isbn,
        title,
        language_id,
        price,
        publication_date,
        author_id
    )
VALUES (
        '9780747532743',
        'Harry Potter and the Philosopher\'s Stone',
        1,
        29.99,
        '1997-06-26',
        1
    ), (
        '9780553103540',
        'A Game of Thrones',
        1,
        39.99,
        '1996-08-06',
        2
    ), (
        '9780007119318',
        'Murder on the Orient Express',
        1,
        14.99,
        '1934-01-01',
        3
    ), (
        '9780307119311',
        'Fevre Dream',
        1,
        23.25,
        '1982-04-24',
        2
    );

-- Lägg till några butiker

INSERT INTO
    bookstore (store_name, city)
VALUES ('Book Haven', 'New York'), ('Casa del Libro', 'Barcelona'), ('Swedish Books', 'Stockholm');

-- Lägg till lagersaldon för böcker i butiker

INSERT INTO
    inventory (store_id, book_isbn, amount)
VALUES (1, '9780747532743', 50), (1, '9780553103540', 30), (2, '9780747532743', 20), (3, '9780007119318', 10);

-- Vy: ”total_author_book_value”

CREATE VIEW
    total_author_book_value AS
SELECT
    CONCAT(
        author.first_name,
        ' ',
        author.last_name
    ) AS name,
    TIMESTAMPDIFF(
        YEAR,
        author.birth_date,
        CURRENT_DATE
    ) AS age,
    COUNT(DISTINCT book.isbn) AS book_title_count,
    SUM(book.price * inventory.amount) AS inventory_value
FROM author
    INNER JOIN book ON author.author_id = book.author_id
    LEFT JOIN inventory ON book.isbn = inventory.book_isbn
GROUP BY author.author_id;

-- Exempel användning av total_author_book_value vyn

SELECT * FROM total_author_book_value LIMIT 1;