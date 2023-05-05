/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
('Agumon', '02-03-2020', 0, true, 10.23),
('Gabumon', '11-15-2018', 2, true, 8),
('Pikachu', '01-07-2021', 1, false, 15.04),
('Devimon', '05-12-2020', 5, true, 11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
('Charmander', '02-08-2020', 0, false, 11),
('Plantmon', '11-15-2021', 2, true, -5.7),
('Squirtle', '04-02-1993', 3, false, -12.13),
('Angemon', '06-12-2005', 1, true, -45),
('Boarmon', '06-07-2005', 7, true, 20.4),
('Blossom', '10-13-1998', 3, true, 17),
('Ditto', '05-14-2022', 4, true, 22);

INSERT INTO owners (fullname, age)
VALUES
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond ', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES
('Pokemon'),
('Digimon');

UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE name NOT LIKE '%mon';

UPDATE animals SET owner_id = 1 WHERE id = 1;
UPDATE animals SET owner_id = 2 WHERE id IN (2,3);
UPDATE animals SET owner_id = 3 WHERE id IN (4,6);
UPDATE animals SET owner_id = 4 WHERE id IN (5,7,10);
UPDATE animals SET owner_id = 5 WHERE id IN (8,9);
