
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


-- INSERTION Technos --

insert into technology(code, name_fr, name_en) 
	values (
		CONCAT('CD_', (select count(*) from technology) + 1),
		'JAVA_FR', 
		'JAVA_EN');
	
insert into technology(code, name_fr, name_en) 
	values (
		CONCAT('CD_', (select count(*) from technology) + 1), 
		'SQL_FR', 
		'SQL_EN');
	
insert into technology(code, name_fr, name_en) 
	values (
		CONCAT('CD_', (select count(*) from technology) + 1), 
		'JAVASCRIPT_FR', 
		'JAVASCRIPT_EN');
	
insert into technology(code, name_fr, name_en) 
	values (
		CONCAT('CD_', (select count(*) from technology) + 1), 
		'PYTHON_FR', 
		'PYTHON_EN');


-- INSERTION Developper --

insert into developper(first_name, last_name, registration_num, birth_date, entry_date, id_tech) 
values('Akbar', 'KHAN', CONCAT('N°_', (select count(*) from developper) + 1),'1996-06-30','2019-09-02', (select id_tech from technology tech where tech.id_tech = 1));

insert into developper(first_name, last_name, registration_num, birth_date, entry_date, id_tech) 
values('Jhon', 'DOE', CONCAT('N°_', (select count(*) from developper) + 1),'1990-06-30','2020-09-02', (select id_tech from technology tech where tech.id_tech = 2));

insert into developper(first_name, last_name, registration_num, birth_date, entry_date, id_tech) 
values('Laura', 'DOE', CONCAT('N°_', (select count(*) from developper) + 1),'1985-06-30','2010-02-02', (select id_tech from technology tech where tech.id_tech = 3));


-- INSERTION technos_developper

insert into developper_technology(id_dev, id_tech) 
values (1, 2);
insert into developper_technology(id_dev, id_tech) 
values (1, 3);
insert into developper_technology(id_dev, id_tech) 
values (1, 4);

insert into developper_technology(id_dev, id_tech) 
values (2, 1);
insert into developper_technology(id_dev, id_tech) 
values (2, 4);

-- REcupérer la liste des devs qui apprennent que la tech de prédilection
select dev.registration_num, dev.first_name, dev.last_name, tech.name_fr
from developper dev
inner join developper_technology dt on dt.id_dev != dev.id_dev
inner join technology tech on tech.id_tech = dev.id_tech;

-- Récupérer les dev qui apprennent au moins une tech
select dev.registration_num as ipn, dev.first_name as prenom, dev.last_name as nom
from developper dev
inner join developper_technology dt on dt.id_dev = dev.id_dev;

