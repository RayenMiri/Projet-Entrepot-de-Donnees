CREATE TABLE DMVG(
	name varchar(32),
	genre varchar(32),
	publisher varchar(32),
	pubYear numeric(4)
);

CREATE TABLE FTVG(
	SalesRank numeric(12),
	NA_Sales decimal(8,6),
	EU_Sales decimal(8,6),
	JP_Sales decimal(8,6),	
	Other_Sales decimal(8,6),	
	Global_Sales decimal(8,6)
);

select * from FTVG;