
-- CREATE DATABASE ecf_database;
-- \c ecf_database;
-- use ecf_database;

CREATE TABLE technology (
id_tech serial PRIMARY KEY,
code VARCHAR(10) NOT NULL,
name_fr VARCHAR(50) NOT NULL,
name_en VARCHAR(50) NOT NULL
);


CREATE TABLE developper (
id_dev serial PRIMARY KEY,
first_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255) NOT NULL,
registration_num VARCHAR(10) NOT NULL,
birth_date DATE DEFAULT CURRENT_DATE NOT NULL,
entry_date DATE DEFAULT CURRENT_DATE NOT NULL,
id_tech INT NOT NULL,
CONSTRAINT fk_technology
	FOREIGN KEY(id_tech)
		REFERENCES technology(id_tech)
			ON DELETE SET NULL
);

CREATE TABLE developper_technology(
id_dev int REFERENCES developper(id_dev) ON DELETE CASCADE,
id_tech int REFERENCES technology(id_tech) ON DELETE CASCADE,
CONSTRAINT dev_tech_pk PRIMARY KEY (id_dev, id_tech)
);

