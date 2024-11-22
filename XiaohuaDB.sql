-- 1. Skapa databas och tabeller
DROP DATABASE IF EXISTS `XiaohuaDB`;
CREATE DATABASE `XiaohuaDB`;
use XiaohuaDB;

create table authors(
author_id INT PRIMARY KEY auto_increment,
first_name VARCHAR(50),
last_name VARCHAR(50),
birth_year INT);

create table publishers (
publisher_id INT primary key auto_increment,
name Varchar(100),
location Varchar(100)
);

create table books (
book_id INT primary key auto_increment,
title VARCHAR(100),
publication_year INT,
author_id INT,
publisher_id INT,
FOREIGN KEY (author_id) REFERENCES authors(author_id) on delete set null on update cascade,
FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id) on delete set null on update cascade
);

create table genres (
genre_id INT primary key auto_increment,
genre_name VARCHAR(50)
);

create table book_genre(
book_id INT,
genre_id INT,
FOREIGN KEY (book_id) REFERENCES books(book_id),
FOREIGN KEY (genre_id) REFERENCES genres(genre_id),
PRIMARY KEY (book_id, genre_id)
);

-- 2.Infoga data
insert into authors (first_name, last_name, birth_year) values
('J.K.', 'Rowling', 1965),
('George', 'Orwell', 1903),
('J.R.R.', 'Tolkien', 1892),
('Mark', 'Twain', 1835),
('Isaac', 'Asimov', 1920),
('Arthur Conan', 'Doyle', 1859),
('Agatha', 'Christie', 1890),
('Philip K.', 'Dick', 1928),
('Stephen', 'King', 1947),
('Suzanne', 'Collins', 1962),
('George R.R.', 'Martin', 1948),
('Harlan', 'Coben', 1962);

insert into books (title,publication_year,author_id, publisher_id) values
("Harry Potter and the Philosopher's Stone", 1997, (SELECT author_id FROM authors WHERE first_name = 'J.K.' AND last_name = 'Rowling'), NULL),
("1984", 1949, (SELECT author_id FROM authors WHERE first_name = 'George' AND last_name = 'Orwell'), NULL),
("The Hobbit", 1937, (SELECT author_id FROM authors WHERE first_name = 'J.R.R.' AND last_name = 'Tolkien'), NULL),
("The Adventures of Tom Sawyer", 1876, (SELECT author_id FROM authors WHERE first_name = 'Mark' AND last_name = 'Twain'), NULL),
("Foundation", 1951, (SELECT author_id FROM authors WHERE first_name = 'Isaac' AND last_name = 'Asimov'), NULL),
("The Hound of the Baskervilles", 1902, (SELECT author_id FROM authors WHERE first_name = 'Arthur Conan' AND last_name = 'Doyle'), NULL),
("Murder on the Orient Express", 1934, (SELECT author_id FROM authors WHERE first_name = 'Agatha' AND last_name = 'Christie'), NULL),
("Do Androids Dream of Electric Sheep?", 1968, (SELECT author_id FROM authors WHERE first_name = 'Philip K.' AND last_name = 'Dick'), NULL),
("The Shining", 1977, (SELECT author_id FROM authors WHERE first_name = 'Stephen' AND last_name = 'King'), NULL),
("The Hunger Games", 2008, (SELECT author_id FROM authors WHERE first_name = 'Suzanne' AND last_name = 'Collins'), NULL),
("A Game of Thrones", 1996, (SELECT author_id FROM authors WHERE first_name = 'George R.R.' AND last_name = 'Martin'), NULL),
("The Stranger", 2015, (SELECT author_id FROM authors WHERE first_name = 'Harlan' AND last_name = 'Coben'), NULL),
("The Woods", 2007, (SELECT author_id FROM authors WHERE first_name = 'Harlan' AND last_name = 'Coben'), NULL);

insert into genres(genre_name)values
("Fantasy"),
("Adventure"),
("Detective Fiction"),
("Horror"),
("Dystopian"),
("Science Fiction"),
("Thriller");

-- Link Books and Genres
INSERT INTO book_genre (book_id, genre_id) VALUES
((SELECT book_id FROM books WHERE title = "Harry Potter and the Philosopher's Stone"), (SELECT genre_id FROM genres WHERE genre_name = 'Fantasy')),
((SELECT book_id FROM books WHERE title = "1984"), (SELECT genre_id FROM genres WHERE genre_name = 'Detective Fiction')),
((SELECT book_id FROM books WHERE title = "The Hobbit"), (SELECT genre_id FROM genres WHERE genre_name = 'Fantasy')),
((SELECT book_id FROM books WHERE title = "The Adventures of Tom Sawyer"), (SELECT genre_id FROM genres WHERE genre_name = 'Adventure')),
((SELECT book_id FROM books WHERE title = "Foundation"), (SELECT genre_id FROM genres WHERE genre_name = 'Science Fiction')),
((SELECT book_id FROM books WHERE title = "The Hound of the Baskervilles"), (SELECT genre_id FROM genres WHERE genre_name = 'Detective Fiction')),
((SELECT book_id FROM books WHERE title = "Murder on the Orient Express"), (SELECT genre_id FROM genres WHERE genre_name = 'Detective Fiction')),
((SELECT book_id FROM books WHERE title = "Do Androids Dream of Electric Sheep?"), (SELECT genre_id FROM genres WHERE genre_name = 'Science Fiction')),
((SELECT book_id FROM books WHERE title = "The Shining"), (SELECT genre_id FROM genres WHERE genre_name = 'Horror')),
((SELECT book_id FROM books WHERE title = "The Shining"), (SELECT genre_id FROM genres WHERE genre_name = 'Fantasy')),
((SELECT book_id FROM books WHERE title = "The Hunger Games"), (SELECT genre_id FROM genres WHERE genre_name = 'Adventure')),
((SELECT book_id FROM books WHERE title = "The Hunger Games"), (SELECT genre_id FROM genres WHERE genre_name = 'Dystopian')),
((SELECT book_id FROM books WHERE title = "A Game of Thrones"), (SELECT genre_id FROM genres WHERE genre_name = 'Fantasy')),
((SELECT book_id FROM books WHERE title = "The Stranger"), (SELECT genre_id FROM genres WHERE genre_name = 'Detective Fiction')),
((SELECT book_id FROM books WHERE title = "The Stranger"), (SELECT genre_id FROM genres WHERE genre_name = 'Thriller')),
((SELECT book_id FROM books WHERE title = "The Woods"), (SELECT genre_id FROM genres WHERE genre_name = 'Thriller'));

insert into publishers (name, location) values
("Penguin Books", "New York"),
("HarperCollins", "London" ),
("Vintage Books", "San Francisco");

-- 3. Formulera SQL-frågor:

-- Hämta alla böcker som publicerats före år 1950.
-- Hämtar alla kolumner från tabellen 'books' där böckerna publicerades före 1950
select * from books
where publication_year < 1950;

-- Hämta alla genrer som innehåller ordet "Classic".
select * from genres
where genre_name like '%Classic%';

-- Hämta alla böcker av en specifik författare, t.ex. "George Orwell".
select books.title, books.publication_year 
from books
inner join authors on books.author_id = authors.author_id 
where authors.first_name = 'George' and authors.last_name ='orwell';

-- Hämta alla böcker som publicerats av ett specifikt förlag och ordna dem efter publiceringsår.
select books.title , books.publication_year 
from books 
inner join publishers p on books.publisher_id = p.publisher_id
where p.name ='Penguin Books'
order by books.publication_year ;

-- Hämta alla böcker tillsammans med deras författare och publiceringsår.
-- Hämtar boktitlar, författarnas för- och efternamn samt publiceringsår genom att slå ihop tabellerna 'books' och 'authors' baserat på deras gemensamma 'author_id',
-- för att kombinera information om böcker med tillhörande författardetaljer
select books.title, authors.first_name ,authors.last_name, books.publication_year 
from books 
inner join authors on books.author_id =authors.author_id;

-- Hämta alla böcker som publicerades efter den första boken som kom ut efter år 2000.
select *
from books
where publication_year > (
select min(publication_year) 
from books
where publication_year>2000);

-- Uppdatera en förtfattares namn.
update authors 
set first_name = 'nytt JK', last_name ='nytt Rowling'
where author_id = 1;

-- Ta bort en bok från databasen.
delete from book_genre 
where book_id = 5;

delete from books
where book_id = 5;

-- Extra instruktioner Skapa mer avancerade SQL-frågor:

-- Hämta alla böcker som publicerats efter år 2000 tillsammans med författarens namn, förlagets namn och genrerna.
select books.title, authors.first_name, authors.last_name, publishers.name as publisher_name, genres.genre_name from books
inner join authors on books.author_id= authors.author_id
left join publishers on books.publisher_id = publishers.publisher_id 
inner join book_genre on books.book_id =book_genre.book_id
inner join genres on book_genre.genre_id =genres.genre_id 
where publication_year > 2000;

-- Visa författarnas fullständiga namn (förnamn och efternamn), titlarna på deras böcker och vilken genre böckerna tillhör.
select books.title, concat(authors.first_name,'', authors.last_name) , genres.genre_name from books
inner join authors on books.author_id= authors.author_id
left join publishers on books.publisher_id = publishers.publisher_id 
inner join book_genre on books.book_id =book_genre.book_id
inner join genres on book_genre.genre_id =genres.genre_id 

-- Antalet böcker varje författare har skrivit, sorterat i fallande ordning.
SELECT CONCAT(authors.first_name, ' ', authors.last_name) AS full_name, COUNT(books.book_id) AS book_count
FROM authors
INNER JOIN books ON authors.author_id = books.author_id
GROUP BY authors.author_id
ORDER BY book_count DESC;

-- Antalet böcker inom varje genre.
SELECT genres.genre_name, COUNT(book_genre.book_id) AS book_count
FROM genres
INNER JOIN book_genre ON genres.genre_id = book_genre.genre_id
GROUP BY genres.genre_id
ORDER BY book_count DESC;

-- Genomsnittligt antal böcker per författare som är publicerade efter år 2000.
SELECT AVG(book_count) AS avg_books_per_author
FROM (SELECT COUNT(books.book_id) AS book_count
    FROM authors
    INNER JOIN books ON authors.author_id = books.author_id
    WHERE books.publication_year > 2000
    GROUP BY authors.author_id) AS author_book_counts;

-- Skapa en stored procedure som tar ett årtal som parameter och returnerar alla böcker som publicerats efter detta år. Döp den till get_books_after_year.
DROP PROCEDURE IF EXISTS get_books_after_year;

-- Ändrar kommandotolkarens standardavgränsare (från ; till //) så att flerlinjekoden för den lagrade proceduren kan skrivas utan att oavsiktligt avsluta proceduren.
-- Tar bort proceduren om den redan existerar. Detta undviker felmeddelanden vid försök att skapa en procedur med ett namn som redan används och tillåter en ny definition av proceduren.
DELIMITER //
-- Skapar en procedur med namnet get_books_after_year som tar en inparameter pubyear av typen INT som representerar året som används för att filtrera böcker
create PROCEDURE get_books_after_year(in pubyear int)
-- Markerar början och slutet av procedurens kropp att göra det möjligt att inkludera flera SQL-kommandon som hör till proceduren.
begin
	select  * from books where publication_year > pubyear;
end //

DELIMITER ;

call get_books_after_year (2000);

-- Skapa en view som visar varje författares fullständiga namn, bokens titel och publiceringsår. Döp den till author_books.

Create view author_books as
select concat(authors.first_name,"",authors.last_name) as full_name, 
books.title , books.publication_year 
from authors 
join books on authors.author_id =books.author_id;

select * from author_books;

