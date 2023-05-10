/* Database schema to keep the structure of entire database. */
DROP SEQUENCE IF EXISTS animals_id_seq CASCADE;
CREATE SEQUENCE animals_id_seq;
DROP TABLE IF EXISTS animals;
CREATE TABLE animals (
    id integer NOT NULL DEFAULT nextval('animals_id_seq'),
    name varchar(100),
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal(5,2)
);
ALTER SEQUENCE animals_id_seq OWNED BY animals.id;
ALTER TABLE animals DROP COLUMN IF EXISTS species;
ALTER TABLE animals ADD COLUMN species VARCHAR(255);


DROP SEQUENCE IF EXISTS owners_id_seq CASCADE;
CREATE SEQUENCE owners_id_seq;
DROP TABLE IF EXISTS owners;
CREATE TABLE owners (
    id integer NOT NULL DEFAULT nextval('owners_id_seq') PRIMARY KEY,
    fullname varchar(255),
    age integer
);
ALTER SEQUENCE owners_id_seq OWNED BY owners.id;


DROP SEQUENCE IF EXISTS species_id_seq CASCADE;
CREATE SEQUENCE species_id_seq;
DROP TABLE IF EXISTS species;
CREATE TABLE species (
    id integer NOT NULL DEFAULT nextval('species_id_seq') PRIMARY KEY,
    name varchar(255)
);
ALTER SEQUENCE species_id_seq OWNED BY species.id;

ALTER TABLE animals ADD CONSTRAINT animals_pk PRIMARY KEY (id);
ALTER TABLE animals DROP COLUMN IF EXISTS species;
ALTER TABLE animals DROP COLUMN IF EXISTS species_id;
ALTER TABLE animals ADD COLUMN species_id INTEGER REFERENCES species(id);
ALTER TABLE animals DROP COLUMN IF EXISTS owner_id;
ALTER TABLE animals ADD COLUMN owner_id INTEGER REFERENCES owners(id);


DROP SEQUENCE IF EXISTS vets_id_seq CASCADE;
CREATE SEQUENCE vets_id_seq;
DROP TABLE IF EXISTS vets;
CREATE TABLE vets (
    id integer NOT NULL DEFAULT nextval('vets_id_seq') PRIMARY KEY,
    name VARCHAR(255),
    age integer,
    date_of_graduation date
);
ALTER SEQUENCE vets_id_seq OWNED BY vets.id;

DROP SEQUENCE IF EXISTS specializations_id_seq CASCADE;
CREATE SEQUENCE specializations_id_seq;
DROP TABLE IF EXISTS specializations;
CREATE TABLE specializations (
    id integer NOT NULL DEFAULT nextval('specializations_id_seq') PRIMARY KEY,
    vet_id integer REFERENCES vets(id),
    species_id integer REFERENCES species(id)
);
ALTER SEQUENCE specializations_id_seq OWNED BY specializations.id;

DROP SEQUENCE IF EXISTS visits_id_seq CASCADE;
CREATE SEQUENCE visits_id_seq;
DROP TABLE IF EXISTS visits;
CREATE TABLE visits (
    id integer NOT NULL DEFAULT nextval('visits_id_seq') PRIMARY KEY,
    animal_id integer REFERENCES animals(id),
    vet_id integer REFERENCES vets(id),
    date_of_visit date
);
ALTER SEQUENCE visits_id_seq OWNED BY visits.id;


-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX animal_id_desc ON visits(animal_id DESC);

DROP INDEX IF EXISTS date_of_visit;
CREATE INDEX date_of_visit ON visits(date_of_visit ASC);

DROP INDEX IF EXISTS animal_id;
CREATE INDEX animal_id ON visits(animal_id ASC);

DROP INDEX IF EXISTS email;
CREATE INDEX email ON owners(email ASC);
