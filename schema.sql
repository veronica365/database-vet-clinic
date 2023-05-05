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
