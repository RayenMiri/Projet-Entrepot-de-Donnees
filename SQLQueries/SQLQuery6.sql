CREATE TABLE VGDB (
	VG_ID int identity(1,1),
    VG_RANK int,
    VG_Name NVARCHAR(255),
    VG_latform NVARCHAR(255),
    VG_Publishing_Year INT,
    genre NVARCHAR(255),
    publisher NVARCHAR(255),
    na_sales FLOAT,
    eu_sales FLOAT,
    jp_sales FLOAT,
    other_sales FLOAT,
    global_sales FLOAT
);

CREATE TABLE VideoGamesDimension (
    VG_ID int,
    VG_RANK int,
    VG_Name NVARCHAR(255),
    VG_latform NVARCHAR(255),
    VG_Publishing_Year INT,
    genre NVARCHAR(255),
    publisher NVARCHAR(255),
);

CREATE TABLE VGsDimPlatform (
    Platform_ID int identity(1,1) PRIMARY KEY,
    VG_Platform NVARCHAR(255)
);

CREATE TABLE VGsDimGenre (
    Genre_ID int identity(1,1) PRIMARY KEY,
    Genre NVARCHAR(255)
);

CREATE TABLE VGsDimPublisher (
    Publisher_ID int identity(1,1) PRIMARY KEY,
    Publisher NVARCHAR(255)
);

CREATE TABLE VGsDimPublishing_Year(
	Publishing_Year_ID int identity(1,1) primary KEY,
	Publishing_Year int
);

CREATE TABLE VGsSalesFacts(
	Sales_Index int identity(1,1) primary key ,
	VG_ID int ,
    VG_RANK int,
    Platform_ID int,
    Publishing_Year_ID int,
    Genre_ID int,
    Publisher_ID int,
    NA_Sale FLOAT,
    EU_Sales FLOAT,
    JP_Sales FLOAT,
    Other_Sales FLOAT,
    Global_Sales FLOAT,
	FOREIGN KEY ( Platform_ID ) REFERENCES VGsDimPlatform(Platform_ID) on delete cascade on update cascade,
	FOREIGN KEY (  Publisher_ID ) REFERENCES VGsDimPublisher( Publisher_ID) on delete cascade on update cascade,
	FOREIGN KEY ( Genre_ID ) REFERENCES VGsDimGenre(Genre_ID) on delete cascade on update cascade,
	FOREIGN KEY ( Publishing_Year_ID ) REFERENCES VGsDimPublishing_Year(Publishing_Year_ID) on delete cascade on update cascade

)

DROP TABLE VGsSalesFacts
SELECT * FROM VGDB

SELECT * FROM VideoGamesDimension order by VG_Name

SELECT distinct VG_latform FROM VideoGamesDimension

SELECT distinct Genre FROM VideoGamesDimension

SELECT distinct Publisher FROM VideoGamesDimension order by Publisher

SELECT * FROM VGsSalesFacts

insert into VGsSalesFacts SELECT VG_ID,VG_RANK,Platform_ID,V.VG_Publishing_Year,Genre_ID,Pub.Publisher_ID,V.na_sales,EU_Sales,JP_Sales,Other_Sales,Global_Sales
FROM VGDB as V , VGsDimGenre as G , VGsDimPlatform as P , VGsDimPublisher as Pub 
WHERE Pub.Publisher = V.publisher
AND P.VG_Platform = V.VG_latform
AND G.Genre = V.genre
order by global_sales desc


SELECT VG_ID,VG_RANK,Platform_ID,VY.Publishing_Year_ID,Genre_ID,Pub.Publisher_ID,V.na_sales,EU_Sales,JP_Sales,Other_Sales,global_sales
FROM VGDB as V , VGsDimGenre as G , VGsDimPlatform as P , VGsDimPublisher as Pub , VGsDimPublishing_Year AS VY
WHERE Pub.Publisher = V.publisher
AND P.VG_Platform = V.VG_latform
AND G.Genre = V.genre
AND VY.Publishing_Year = V.VG_Publishing_Year


SELECT Publishing_Year_ID
FROM VGDB as V , VGsDimPublishing_Year as VY
WHERE V.VG_Publishing_Year = VY.Publishing_Year

delete from VGsDimPublishing_Year

SELECT * FROM VGsSalesFacts order by Global_Sales desc

SELECT * FROM VGsDimGenre

SELECT * FROM VGDB

insert into VGsDimPublishing_Year  SELECT distinct  VG_Publishing_Year FROM VideoGamesDimension order by VG_Publishing_Year

SELECT * FROM VGsDimPublishing_Year
