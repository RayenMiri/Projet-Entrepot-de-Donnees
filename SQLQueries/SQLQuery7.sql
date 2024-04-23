CREATE TABLE MoviesDimension(
	Movie_ID INT primary key,
	title NVARCHAR(255),
    movie_info NVARCHAR(255),
    distributor NVARCHAR(255),
    release_date date,
	genre nvarchar(255),
	movie_runtime nvarchar(255),
    license NVARCHAR(255)
);
drop table MoviesDimension

CREATE TABLE MoviesDimReleaseDate (
    Release_Date_ID int IDENTITY(1,1) PRIMARY KEY,
    Release_Date int
);
drop table MoviesDimReleaseDate

CREATE TABLE MoviesDimDistributor (
    Distributor_ID int IDENTITY(1,1) PRIMARY KEY,
    Distributor NVARCHAR(255)
);

CREATE TABLE MoviesDimGenre (
    Genre_ID int IDENTITY(1,1) PRIMARY KEY,
    Genre NVARCHAR(255)
);

CREATE TABLE MoviesDimLicense (
    License_ID int IDENTITY(1,1) PRIMARY KEY,
    License NVARCHAR(255)
);

SELECT *
FROM MoviesDB

SELECT *
FROM MoviesDimension

SELECT distinct YEAR(release_date) as Release_Date  FROM MoviesDimension

SELECT distinct distributor FROM MoviesDimension

SELECT genre FROM MoviesDimGenre

delete from MoviesDimGenre

SELECT License FROM MoviesDimension

CREATE TABLE MoviesSalesFacts(
	Sales_Index int identity(1,1) primary key,
	Movie_ID int,
	Distributor_ID int references MoviesDimDistributor(Distributor_ID) on delete cascade on update cascade,
	Release_Date_ID int references MoviesDimReleaseDate(Release_Date_ID) on delete cascade on update cascade,
	Genre_ID int references MoviesDimGenre(Genre_ID) on delete cascade on update cascade,
	License_ID int references MoviesDimLicense(License_ID) on delete cascade on update cascade,
	Domestic_Sales FLOAT ,
	International_Sales FLOAT,
	World_Sales FLOAT,
)

insert into MoviesSalesFacts 
SELECT Movie_ID,Distributor_ID,Release_Date_ID,MG.Genre_ID,License_ID,Domestic_Sales,International_Sales,World_Sales
FROM MoviesDB as M , MoviesDimDistributor as MD , MoviesDimReleaseDate as MRD , MoviesDimGenre as MG , MoviesDimLicense as ML
WHERE M.Distributor = MD.Distributor 
AND YEAR(M.Release_Date) = MRD.Release_Date
AND M.Genre LIKE '%'+MG.Genre+'%'
AND M.License = ML.License

select * from MoviesDimension

insert into MoviesDimGenre SELECT distinct Genre FROM MoviesDimGenre

SELECT * from MoviesDimGenre
SELECT * from MoviesDB 
SELECT * from MoviesDimLicense

insert into MoviesDimLicense SELECT distinct License from MoviesDB

select sum(world_sales) as sum_ws, Release_Date_ID as RD from MoviesSalesFacts group by (Release_Date_ID) order by sum_ws desc 
select * from MoviesDimReleaseDate
delete from MoviesSalesFacts


SELECT distinct publisher FROM VGDB order by publisher

select * from MoviesDimGenre WHERE Genre = 'Crime'