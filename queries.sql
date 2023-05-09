/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = TRUE;

-- Find all animals not named Gabumon.
SELECT name FROM animals WHERE name <> 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.
BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Inside a transaction:
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
-- Commit the transaction.
-- Verify that change was made and persists after commit.
BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

-- Inside a transaction delete all records in the animals table, then roll back the transaction.
-- After the rollback verify if all records in the animals table still exists.
BEGIN TRANSACTION;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Inside a transaction:
-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction
-- Verify that change was made and persists after commit.
BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT update_weight;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO update_weight;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;


-- How many animals are there?
SELECT COUNT(*) AS total_animals FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) AS total_animals FROM animals WHERE escape_attempts=0;

-- What is the average weight of animals?
SELECT ROUND(AVG(weight_kg), 2) AS average_weight FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT
  neutered,
  COUNT(escape_attempts) AS number_of_escapes
FROM animals
WHERE escape_attempts > 0
GROUP BY neutered
ORDER BY number_of_escapes DESC

-- What is the minimum and maximum weight of each type of animal?
SELECT
  species,
  MIN(weight_kg) AS minimum_weight,
  MAX(weight_kg) AS maximum_weight
FROM animals
GROUP BY species

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT
  species,
  ROUND(AVG(escape_attempts), 2) AS average_escape_attempts
FROM animals
WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 1990 AND 2000
GROUP BY species
ORDER BY average_escape_attempts DESC


-- What animals belong to Melody Pond?
SELECT animals.id,animals.name,owners.id,owners.fullname
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.fullname LIKE '%Melody Pond%';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.id,animals.name,species.id,species.name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name LIKE '%Pokemon%';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.id,owners.fullname AS owner_name,animals.id,animals.name AS animal_name
FROM owners FULL JOIN animals ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT species.id,species.name,COUNT(animals.id) AS number_of_animals 
FROM species 
LEFT JOIN animals ON animals.species_id = species.id 
GROUP BY species.id ORDER BY species.id ASC;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.id,animals.name,species.id,species.name,owners.id,owners.fullname
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE species.name LIKE '%Digimon%' AND owners.fullname LIKE '%Jennifer Orwell%';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.id,animals.name,species.id,species.name,owners.id,owners.fullname
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE owners.fullname LIKE '%Dean Winchester%' AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.id,owners.fullname,COUNT(animals.id) AS number_of_animals
FROM owners
JOIN animals ON animals.owner_id = owners.id
GROUP BY owners.id
ORDER BY number_of_animals DESC
LIMIT 1;

-- Who was the last animal visited by vet William Tatcher?
SELECT visits.id, visits.date_of_visit, animals.name, vets.name
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name LIKE '%William Tatcher%'
ORDER BY visits.id DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animals.id) AS number_of_animals
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name LIKE '%Stephanie Mendez%';

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.id, vets.name, specializations.species_id
FROM vets
LEFT JOIN specializations ON specializations.vet_id = vets.id;

--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.id, animals.name, visits.date_of_visit, vets.name
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name LIKE '%Stephanie Mendez%' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.id, animals.name, COUNT(visits.id) AS number_of_visits
FROM animals
JOIN visits ON animals.id = visits.animal_id
GROUP BY animals.id
ORDER BY number_of_visits DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.id, animals.name, visits.date_of_visit, vets.name
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name LIKE '%Maisy Smith%'
ORDER BY visits.date_of_visit ASC
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.id, animals.name AS animal_name, animals.date_of_birth, animals.escape_attempts, animals.neutered, animals.weight_kg, vets.name AS vet_name, vets.age, vets.date_of_graduation, visits.date_of_visit AS date_of_visit
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
ORDER BY visits.date_of_visit DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(visits.id) AS number_of_visits
FROM visits
JOIN vets ON vets.id = visits.vet_id
JOIN animals ON animals.id = visits.animal_id
JOIN specializations ON specializations.vet_id = vets.id
WHERE specializations.species_id != animals.species_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT COUNT(visits.id) AS number_of_visits,species.name
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
JOIN species ON animals.species_id = species.id
WHERE vets.name LIKE '%Maisy Smith%'
GROUP BY species.name
ORDER BY number_of_visits DESC
LIMIT 1;


EXPLAIN ANALYZE SELECT COUNT(*) FROM visits WHERE animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits WHERE vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners WHERE email = 'owner_18327@mail.com';

EXPLAIN ANALYZE SELECT COUNT(animal_id) FROM visits WHERE animal_id = 4;
EXPLAIN ANALYZE SELECT id, vet_id, animal_id FROM visits WHEREvet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners WHERE email = 'owner_18327@mail.com';
