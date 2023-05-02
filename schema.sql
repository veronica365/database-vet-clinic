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

ALTER SEQUENCE animals_id_seq
OWNED BY animals.id;
