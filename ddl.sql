
--Create tabel/entities

--Regions

CREATE TABLE regions(
    id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL UNIQUE
);

--Sales_reps

CREATE TABLE sales_reps(
    id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	region_id INT NOT NULL,
	FOREIGN KEY(region_id) REFERENCES regions(id)
	);


--Accounts

CREATE TABLE accounts(
    id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL UNIQUE,
	website VARCHAR(255),
	lat DECIMAL(9,6),----latitude
	long DECIMAL(9,6),---longitude
	primary_poc VARCHAR(255),---point of contact
	sales_reps_id INT NOT NULL,
	FOREIGN KEY(sales_reps_id) REFERENCES sales_reps(id)
);


--Orders

CREATE TABLE orders(
   id SERIAL PRIMARY KEY,
   accounts_id INT NOT NULL,
   standard_qty INT DEFAULT 0 CHECK (standard_qty >= 0),
   poster_qty INT DEFAULT 0 CHECK (poster_qty >= 0),
   gloss_qty INT DEFAULT 0 CHECK (gloss_qty >= 0),
   total INT GENERATED ALWAYS AS (standard_qty + poster_qty + gloss_qty) STORED,
   standard_amt_usd NUMERIC(12,2) DEFAULT 0 CHECK (standard_amt_usd >= 0),
   gloss_amt_usd NUMERIC(12,2) DEFAULT 0 CHECK (gloss_amt_usd >= 0),
   poster_amt_usd NUMERIC(12,2) DEFAULT 0 CHECK (poster_amt_usd >= 0),
   total_amt_usd NUMERIC(14,2) GENERATED ALWAYS AS (standard_amt_usd + gloss_amt_usd + poster_amt_usd) STORED,
   FOREIGN KEY (accounts_id) REFERENCES accounts(id)
);


-- custom enums

CREATE TYPE channel_enum AS ENUM ('google','facebook','twitter');

--Web_events

CREATE TABLE web_events (
    id SERIAL PRIMARY KEY,
    account_id INT NOT NULL,
    occurred_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    channel VARCHAR(50) NOT NULL CHECK (channel IN ('Google','Facebook','Twitter')),
	FOREIGN KEY (account_id) REFERENCES accounts(id)

);