DROP DATABASE IF EXISTS bookstore;

CREATE DATABASE bookstore;

USE bookstore;

CREATE TABLE
    author (
        id INT AUTO_INCREMENT PRIMARY KEY,
        first_name VARCHAR(255),
        last_name VARCHAR(255),
        birth_date DATE
    );

CREATE TABLE
    language (
        id INT AUTO_INCREMENT PRIMARY KEY,
        language_name VARCHAR(50)
    );

CREATE TABLE
    book (
        isbn CHAR(13) PRIMARY KEY,
        title VARCHAR(255),
        language_id INT UNSIGNED NOT NULL,
        price DECIMAL(10, 2),
        publication_date DATE,
        author_id INT UNSIGNED NOT NULL,
        FOREIGN KEY (author_id) REFERENCES author(id),
        FOREIGN KEY (language_id) REFERENCES language(id)
    );

CREATE TABLE
    bookstore (
        id INT AUTO_INCREMENT PRIMARY KEY,
        store_name VARCHAR(255),
        city VARCHAR(255)
    );

CREATE TABLE
    inventory (
        store_id INT,
        isbn CHAR(13),
        amount INT,
        PRIMARY KEY (store_id, isbn),
        FOREIGN KEY (store_id) REFERENCES bookstore(id),
        FOREIGN KEY (isbn) REFERENCES book(isbn)
    );