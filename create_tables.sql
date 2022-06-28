

use [db2_maindb]
go

CREATE TABLE main_manager(
	main_manager_username  VARCHAR(20) PRIMARY KEY,
	password			   VARCHAR(20),
	email				   VARCHAR(150)
);

CREATE TABLE province(
	province_id				INT PRIMARY KEY,
	province_name           VARCHAR(50),
);

CREATE TABLE city(
	city_id				INT PRIMARY KEY,
	province_id			INT,
	city_name			VARCHAR(50),
	FOREIGN KEY (province_id) REFERENCES province(province_id)
);


CREATE TABLE branch_manager(
	manager_username	VARCHAR(20) PRIMARY KEY,
	city_id				INT,
	salary              BIGINT,
	password			VARCHAR(20),
	manager_name		VARCHAR(50),
	email				VARCHAR(150),
	birth_day			DATE,
	address				VARCHAR(350),
	score				INT,
	FOREIGN KEY (city_id) REFERENCES city(city_id),
);


CREATE TABLE branch(
	branch_id			INT PRIMARY KEY,
	city_id				INT,
	manager_username	VARCHAR(20),
	address				VARCHAR(350),
	score				INT,
	FOREIGN KEY (city_id) REFERENCES city(city_id) ,
	FOREIGN KEY (manager_username) REFERENCES branch_manager(manager_username)  
);

CREATE TABLE employee(
	employee_username	VARCHAR(20) PRIMARY KEY,
	city_id				INT,
	salary              BIGINT,
	password			VARCHAR(20),
	employee_name		VARCHAR(50),
	email				VARCHAR(150),
	birth_day			DATE,
	branch_id			INT,
	address				VARCHAR(350),
	score				INT,
	FOREIGN KEY (city_id) REFERENCES city(city_id),
	FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

CREATE TABLE customer(
	customer_username	VARCHAR(20) PRIMARY KEY,
	city_id				INT,
	password			VARCHAR(20),
	customer_name		VARCHAR(50),
	email				VARCHAR(150),
	birth_day			DATE,
	address				VARCHAR(350),
	postal_code			BIGINT,
	FOREIGN KEY (city_id) REFERENCES city(city_id) 
);

CREATE TABLE good_category(
	good_category_id		INT PRIMARY KEY,
	good_category_name		VARCHAR(50),
	description				VARCHAR(150) NULL,
);

CREATE TABLE good_subcategory(
	good_subcategory_id		INT PRIMARY KEY,
	good_subcategory_name		VARCHAR(50),
	good_category_id		INT,
	description				VARCHAR(150) NULL,
	FOREIGN KEY (good_category_id) REFERENCES good_category(good_category_id),
);

CREATE TABLE continent(
	continent_id				INT PRIMARY KEY,
	continent_name				varchar(50),
);

CREATE TABLE country(
	country_id					INT PRIMARY KEY,
	country_name				varchar(50),
	continent_id					INT,
	FOREIGN KEY (continent_id) REFERENCES continent(continent_id),
);

CREATE TABLE company(
	company_id					INT PRIMARY KEY,
	company_name				varchar(50),
	company_description		VARCHAR(150) NULL,
	country_id					INT,
	FOREIGN KEY (country_id) REFERENCES country(country_id),
);

CREATE TABLE good(
	good_id					INT PRIMARY KEY,
	good_subcategory_id		INT,
	good_name				varchar(50),
	good_description		VARCHAR(150) NULL,
	company_id				INT,
	model					INT,
	guarantee				INT NULL,
	FOREIGN KEY (good_subcategory_id) REFERENCES good_subcategory(good_subcategory_id),
	FOREIGN KEY (company_id) REFERENCES company(company_id),
);

CREATE TABLE color(
	color_id			INT PRIMARY KEY,
	color_name		    VARCHAR(150),
);

CREATE TABLE size(
	size_id			INT PRIMARY KEY,
	size_name		VARCHAR(150),
);

CREATE TABLE gender(
	gender_id			INT PRIMARY KEY,
	gender_name		    VARCHAR(150),
);


CREATE TABLE variants(
	variants_id			INT PRIMARY KEY,
	good_id				INT,
	variants_price		FLOAT,
	variants_discount	INT,
	variants_description VARCHAR(150) NULL,
	color_id            INT NULL,
	size_id             INT NULL,
	gender_id           INT NULL,
	FOREIGN KEY (good_id) REFERENCES good(good_id),
	FOREIGN KEY (size_id) REFERENCES size(size_id),
	FOREIGN KEY (color_id) REFERENCES color(color_id),
	FOREIGN KEY (gender_id) REFERENCES gender(gender_id),
);

CREATE TABLE variant_in_branch(
	branch_id			    INT NOT NULL,
	variants_id				INT NOT NULL,
	variants_count			INT,
	PRIMARY KEY (branch_id,variants_id),
	FOREIGN KEY (variants_id) REFERENCES variants(variants_id),
	FOREIGN KEY (branch_id) REFERENCES branch(branch_id),
);

CREATE TABLE bank(
	bank_name           VARCHAR(30) PRIMARY KEY,
	
);

CREATE TABLE bank_card(
	bank_card_number    VARCHAR(16) PRIMARY KEY,
	customer_username	VARCHAR(20),
	bank_name			VARCHAR(30),
	expiration  		DATE,
	FOREIGN KEY (customer_username) REFERENCES customer(customer_username),
	FOREIGN KEY (bank_name) REFERENCES bank(bank_name),
);

CREATE TABLE shopping_list(
	shopping_list_id    INT PRIMARY KEY,
	date				DATE,
	time                TIME,
	bank_card_number    VARCHAR(16),
	FOREIGN KEY (bank_card_number) REFERENCES bank_card(bank_card_number),
);


CREATE TABLE buying(
	buying_id           INT PRIMARY KEY,
	variants_id         INT NULL,
    branch_id			INT,
	buying_price        FLOAT,
	buying_discount     INT,
	shopping_list_id    INT,
	FOREIGN KEY (variants_id) REFERENCES variants(variants_id),
	FOREIGN KEY (branch_id) REFERENCES branch(branch_id),
	FOREIGN KEY (shopping_list_id) REFERENCES shopping_list(shopping_list_id),
	
);







