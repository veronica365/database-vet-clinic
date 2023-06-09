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


INSERT INTO vets (name, age, date_of_graduation)
VALUES
('William Tatcher', 45, '04-23-2000'),
('Maisy Smith', 26, '01-17-2019'),
('Stephanie Mendez', 64, '05-04-1981'),
('Jack Harkness', 38, '06-08-2008');

INSERT INTO specializations (vet_id, species_id)
VALUES
(1, 1),
(3, 1),
(3, 2),
(4, 2);

INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES
(1, 1, '05-24-2020'),
(1, 3, '07-22-2020'),
(2, 4, '02-02-2021'),
(3, 2, '01-05-2020'),
(3, 2, '03-08-2020'),
(3, 2, '05-14-2020'),
(4, 3, '05-04-2021'),
(5, 4, '02-24-2021'),
(6, 2, '12-21-2019'),
(6, 1, '08-10-2020'),
(6, 2, '04-07-2021'),
(7, 3, '09-29-2019'),
(8, 4, '10-03-2020'),
(8, 4, '11-04-2020'),
(9, 2, '01-24-2019'),
(9, 2, '05-15-2019'),
(9, 2, '02-27-2020'),
(9, 2, '08-03-2020'),
(10, 3, '05-24-2020'),
(10, 1, '01-11-2021');


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;
-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;
-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;
-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;
-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (fullname, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (fullname, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (fullname, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (fullname, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (fullname, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
