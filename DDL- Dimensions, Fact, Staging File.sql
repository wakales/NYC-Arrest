-- nyc arrests
-- 2022-04-10
-- bhagyashree nair

-- ------------------------------- STG ------------------------------------------------------------------------

-- stg_NYPD_Arrest_Data__Year_to_Date__tsv 
CREATE TABLE stg_NYPD_Arrest_Data__Year_to_Date__tsv (
	stg_NYPD_Arrest_Data_sk int NOT NULL AUTO_INCREMENT,
	arrest_key varchar(50) NOT NULL,
	arrest_date datetime(3) DEFAULT (now(3)) NOT NULL,
	pd_cd int NOT NULL,
	pd_desc varchar(80) NULL,
	ky_cd int NULL,
	ofns_desc varchar(1024) NULL,
	law_code varchar(50) NULL,
	law_cat_cd varchar(2) NULL,
	arrest_boro varchar(2) NULL,
	arrest_precinct int NULL,
	jurisdiction_code int NULL,
	age_group varchar(10) NULL,
	perp_sex varchar(2) NULL,
	perp_race varchar(80) NULL,
	x_coord_cd varchar(80) NULL,
	y_coord_cd varchar(80) NULL,
	latitude varchar(80) NULL,
	longitude varchar(80) NULL,
	DI_JobID varchar(20) NULL,
	DI_CreateDate datetime(3) DEFAULT (now(3)) NOT NULL,
	PRIMARY KEY (stg_NYPD_Arrest_Data_sk)
);

-- ------------------------------- Dimensions ------------------------------------------------------------------------

CREATE TABLE dim_PD (
	PD_SK int NOT NULL AUTO_INCREMENT,
	PD_CD varchar(5) NULL,
	PD_Desc varchar(80) NULL,
	DI_JobID varchar(20) NULL,
	DI_CreateDate datetime(3) DEFAULT (now(3)) NOT NULL,
	PRIMARY KEY (PD_SK)
);

CREATE TABLE dim_KY (
	KY_SK int NOT NULL AUTO_INCREMENT,
	KY_CD varchar(5) NULL,
	OFNS_Desc varchar(500) NULL,
	DI_JobID varchar(20) NULL,
	DI_CreateDate datetime(3) DEFAULT (now(3)) NOT NULL,
	PRIMARY KEY (KY_SK)
);

CREATE TABLE dim_LawCode (
	LAW_CODE_SK int NOT NULL AUTO_INCREMENT,
	LAW_CODE_Name varchar(100) NULL,
	DI_JobID varchar(20) NULL,
	DI_CreateDate datetime(3) DEFAULT (now(3)) NOT NULL,
	PRIMARY KEY (LAW_CODE_SK)
);

CREATE TABLE dim_LawCategory (
	LAW_CAT_SK int NOT NULL AUTO_INCREMENT,
	LAW_CAT_CD varchar(3) NULL,
	DI_JobID varchar(20) NULL,
	DI_CreateDate datetime(3) DEFAULT (now(3)) NOT NULL,
	PRIMARY KEY (LAW_CAT_SK)
);

CREATE TABLE dim_ArrestBorough (
	ARREST_BORO_SK int NOT NULL AUTO_INCREMENT,
	ARREST_BORO varchar(3) NULL,
	DI_JobID varchar(20) NULL,
	DI_CreateDate datetime(3) DEFAULT (now(3)) NOT NULL,
	PRIMARY KEY (ARREST_BORO_SK)
);

CREATE TABLE dim_ArrestPrecinct (
	ARREST_PRECINCT_SK int NOT NULL AUTO_INCREMENT,
	ARREST_PRECINCT int NULL,
	DI_JobID varchar(20) NULL,
	DI_CreateDate datetime(3) DEFAULT (now(3)) NOT NULL,
	PRIMARY KEY (ARREST_PRECINCT_SK)
);

CREATE TABLE dim_Jurisdiction (
	JURISDICTION_SK int NOT NULL AUTO_INCREMENT,
	JURISDICTION_CODE int NULL,
	DI_JobID varchar(20) NULL,
	DI_CreateDate datetime(3) DEFAULT (now(3)) NOT NULL,
	PRIMARY KEY (JURISDICTION_SK)
);

CREATE TABLE dim_AgeGroup (
	AGE_GROUP_SK int NOT NULL AUTO_INCREMENT,
	AGE_GROUP varchar(10) NULL,
	DI_JobID varchar(20) NULL,
	DI_CreateDate datetime(3) DEFAULT (now(3)) NOT NULL,
	PRIMARY KEY (AGE_GROUP_SK)
);

CREATE TABLE dim_PerpSex (
	PERP_SEX_SK int NOT NULL AUTO_INCREMENT,
	PERP_SEX varchar(2) NULL,
	DI_JobID varchar(20) NULL,
	DI_CreateDate datetime(3) DEFAULT (now(3)) NOT NULL,
	PRIMARY KEY (PERP_SEX_SK)
);

CREATE TABLE dim_PerpRace (
	PERP_RACE_SK int NOT NULL AUTO_INCREMENT,
	PERP_RACE varchar(80) NULL,
	DI_JobID varchar(20) NULL,
	DI_CreateDate datetime(3) DEFAULT (now(3)) NOT NULL,
	PRIMARY KEY (PERP_RACE_SK)
);

CREATE TABLE dim_Location (
	LOCATION_SK int NOT NULL AUTO_INCREMENT,
	x_coord_cd varchar(80) NULL,
	y_coord_cd varchar(80) NULL,
	latitude varchar(80) NULL,
	longitude varchar(80) NULL,
	New Georeferenced Column_ varchar(200) NULL,
	DI_JobID varchar(20) NULL,
	DI_CreateDate datetime(3) DEFAULT (now(3)) NOT NULL,
	PRIMARY KEY (LOCATION_SK)
);

-- ------------------------------- Fact ------------------------------------------------------------------------

CREATE TABLE fct_NYCArrests (
	PD_SK int NOT NULL,
	KY_SK int NOT NULL default -99,
	LAW_CODE_SK int NOT NULL default -99,
	LAW_CAT_SK int NOT NULL default -99,
	ARREST_BORO_SK int NOT NULL default -99,
	ARREST_PRECINCT_SK int NOT NULL default -99,
	JURISDICTION_SK int NOT NULL default -99,
	AGE_GROUP_SK int NOT NULL default -99,
	PERP_SEX_SK int NOT NULL default -99,
	PERP_RACE_SK int NOT NULL default -99,
	LOCATION_SK int NOT NULL default -99,
	arrest_key varchar(50) NOT NULL,
	arrest_date datetime(3) DEFAULT (now(3)) NULL,
	DI_JobID varchar(20) NULL,
	DI_CreateDate datetime(3) DEFAULT (now(3)) NOT NULL,
	PRIMARY KEY (PD_SK,KY_SK,LAW_CODE_SK, LAW_CAT_SK, ARREST_BORO_SK, ARREST_PRECINCT_SK, JURISDICTION_SK, AGE_GROUP_SK, PERP_SEX_SK, PERP_RACE_SK, LOCATION_SK)
);
