CREATE TABLE BooksDB (
    Book_ID INT PRIMARY KEY ,
    publishing_year INT,
    book_name nvarchar(255),
    author nvarchar(255),
    language_code nvarchar(255),
    author_rating nvarchar(255),
    book_average_rating FLOAT,
    book_ratings_count FLOAT,
    genre nvarchar(255),
    gross_sales FLOAT,
    publisher_revenue FLOAT,
    sale_price FLOAT,
    sales_rank INT,
    publisher nvarchar(255),
    units_sold INT
);
drop table booksDB
CREATE TABLE BooksDimension (
    Book_ID INT PRIMARY KEY,
    Book_Name nvarchar(255),
    Author_Name nvarchar(255),
    Genre_Name nvarchar(255),
    Publishing_Year INT,
    Language_Description nvarchar(255),
    Book_Average_Rating FLOAT,
    Book_Ratings_Count FLOAT,
	Author_Rating nvarchar(255),
	publisher nvarchar(255)
);
drop table BooksDimension
CREATE TABLE BooksDimAuthors (
    Author_ID INT PRIMARY KEY identity(1,1),
    Author_Name nvarchar(255),
    Author_Rating nvarchar(255)
);

CREATE TABLE BooksDimPublishers (
    Publisher_ID INT PRIMARY KEY identity(1,1),
    Publisher_Name nvarchar(255)
);

CREATE TABLE BooksDimGenres (
    Genre_ID INT PRIMARY KEY identity(1,1),
    Genre_Name nvarchar(255)
);

CREATE TABLE BooksDimLanguages (
    Language_Code INT PRIMARY KEY identity(1,1),
    Language_Description nvarchar(255)
);

CREATE TABLE BooksDimPublishingYear(
	Publishing_Year_ID INT Primary KEY identity(1,1),
	Publishing_Year int
);

CREATE TABLE BooksSalesFacts (
    Sales_Index INT PRIMARY KEY identity(1,1),
    Book_ID INT,
    Publisher_ID INT,
	Publishing_Year_ID INT,
	Genre_ID INT,
	Language_Code INT,
	Author_ID INT,
    Gross_Sales FLOAT,
    Publisher_Revenue FLOAT,
    Sale_Price FLOAT,
    Sales_Rank INT,
    Units_Sold INT,
    FOREIGN KEY (Book_ID) REFERENCES BooksDimension(Book_ID) on delete cascade on update cascade,
    FOREIGN KEY (Publisher_ID) REFERENCES BooksDimPublishers(Publisher_ID) on delete cascade on update cascade,
	FOREIGN KEY (Publishing_Year_ID) REFERENCES BooksDimPublishingYear(Publishing_Year_ID) on delete cascade on update cascade,
	FOREIGN KEY (Genre_ID) REFERENCES BooksDimGenres(Genre_ID) on delete cascade on update cascade,
	FOREIGN KEY (Language_Code) REFERENCES BooksDimLanguages(Language_Code) on delete cascade on update cascade,
	FOREIGN KEY (Author_ID) REFERENCES BooksDimAuthors(Author_ID) on delete cascade on update cascade,
);

drop table BooksSalesFacts
SELECT Author_Name,Author_Rating 
FROM(SELECT Author_Name , Author_Rating  , count(*) as RatingCount , RANK() OVER (PARTITION BY Author_Name ORDER BY Count(*) DESC) as RANKING
	FROM BooksDimension 
	Group By Author_Name, Author_Rating) as RankedAuthorRating
WHERE RANKING =1
ORDER BY Author_Name;

SELECT distinct publisher from BooksDimension;

SELECT distinct Language_Description FROM BooksDimension;

SELECT Genre_Name FROM BooksDimension

delete FROM BooksSalesFacts

delete from BooksDimPublishers

SELECT * FROM BooksDimension order by Book_Name

SELECT distinct Author_Name FROM BooksDimAuthors

SELECT * FROM BooksDimGenres

SELECT * FROM BooksSalesFacts

SELECT * FROM BooksDB;

SELECT * FROM BooksDimPublishers
delete from BooksSalesFacts

SELECT BDim.Book_ID ,BDimP.Publisher_ID,Publishing_Year_ID ,Genre_ID , BL.Language_Description,Author_ID,BDB.Gross_Sales , BDB.Publisher_Revenue , BDB.Sale_Price , BDB.Sales_Rank , BDB.Units_Sold
FROM BooksDimension as BDim , BooksDB as BDB , BooksDimPublishers as BDimP , BooksDimPublishingYear as BDY,BooksDimGenres as BG , BooksDimLanguages as BL , BooksDimAuthors as BA
WHERE BDB.publisher = BDimP.Publisher_Name 
AND BDB.publishing_year = BDY.Publishing_Year 
AND BDim.Book_ID = BDB.Book_ID 
AND BDim.Genre_Name = BG.Genre_Name
AND BDim.Language_Description = BL.Language_Description
AND BDim.Author_Name = BA.Author_Name
order by Gross_Sales desc

select * from BooksDimension

UPDATE BooksDimension
SET Language_Description = 'en'
WHERE Language_Description LIKE 'en-%' or  Language_Description LIKE 'en%' ;

select Language_Description from BooksDimension

UPDATE BooksDimension
SET Genre_Name = 'fiction'
WHERE Genre_Name = 'genre fiction';select * from BooksDimension
select * from BooksSalesFacts order by Gross_Sales desc

SELECT BDB.Book_ID ,BDimP.Publisher_ID,Publishing_Year_ID  ,BDB.Gross_Sales , BDB.Publisher_Revenue , BDB.Sale_Price , BDB.Sales_Rank , BDB.Units_Sold
FROM BooksDimension as BDim , BooksDB as BDB , BooksDimPublishers as BDimP , BooksDimPublishingYear as BDY
WHERE BDB.publisher = BDimP.Publisher_Name 
AND BDB.publishing_year = BDY.Publishing_Year 
AND BDim.Book_ID = BDB.Book_ID order by Gross_Sales desc


SELECT * FROM BooksDimPublishingYear

SELECT Publishing_Year_ID 
FROM BooksDB as B , BooksDimPublishingYear as Y
WHERE B.publishing_year = Y.Publishing_Year

delete from BooksDimPublishingYear
INSERT INTO BooksDimPublishingYear SELECT distinct publishing_year FROM BooksDB