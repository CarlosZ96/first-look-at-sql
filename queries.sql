/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';

SELECT name
FROM animals
WHERE
    date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name
FROM animals
WHERE
    neutered = true
    and escape_attempts < 3;

SELECT date_of_birth
FROM animals
WHERE
    name LIKE 'Agumon'
    or name LIKE 'Pikachu';

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * from animals WHERE neutered = TRUE;

SELECT * from animals WHERE name NOT like 'Gabumon';

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;

UPDATE animals SET weight_kg = 22 WHERE NAME LIKE 'Ditto';

ROLLBACK;

COMMIT;

BEGIN;

SAVEPOINT speciesbefore;

UPDATE animals SET species = 'unspecified';

ROLLBACK TO speciesbefore;

COMMIT;

BEGIN;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

UPDATE animals SET species = 'pokemon' WHERE species IS NULL ;

COMMIT;

BEGIN;

SAVEPOINT beforecaos;

DELETE FROM animals;

ROLLBACK TO beforecaos;

COMMIT;

BEGIN;

SAVEPOINT beforecaos;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

ROLLBACK TO beforecaos;

COMMIT;

/*
 How many animals are there?
 */

SELECT COUNT(*) FROM animals;

/*
 How many animals have never tried to escape?
 */

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

/*
 What is the average weight of animals?
 */

SELECT SUM(weight_kg) / COUNT(*) AS weight_kg_average FROM animals;

/*
 Who escapes the most, neutered or not neutered animals?
 */

SELECT COUNT(escape_attempts) FROM animals WHERE neutered = TRUE;

SELECT COUNT(escape_attempts) FROM animals WHERE neutered = FALSE;

/*
 What is the minimum and maximum weight of each type of animal?
 */

SELECT weight_kg FROM animals ORDER BY weight_kg ASC LIMIT 1;

SELECT weight_kg FROM animals ORDER BY weight_kg DESC LIMIT 1;

/*
 What is the average number of escape attempts per animal type of those born between 1990 and 2000?
 */

SELECT
    SUM(escape_attempts) / COUNT(*) AS escape_attempts_average
FROM animals
WHERE
    species = 'digimon'
    AND date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';

SELECT
    SUM(escape_attempts) / COUNT(*) AS escape_attempts_average
FROM animals
WHERE
    species = 'pokemon'
    AND date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';

BEGIN;

SELECT * FROM animals;

UPDATE animals SET species = 'unspecified';

SELECT * FROM animals;

ROLLBACK 

SELECT * FROM animals;

COMMIT;

BEGIN;

UPDATE animals SET species = 'unspecified';

SELECT * FROM animals;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

SELECT * FROM animals;

UPDATE animals SET species = 'pokemon' WHERE species IS NULL ;

SELECT * FROM animals;

COMMIT;

BEGIN;

SELECT * FROM animals;

DELETE FROM animals;

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

COMMIT;

/*-------------------------------------------------------------------------------------------------------*/

BEGIN;

SELECT * FROM animals;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SELECT * FROM animals;

SAVEPOINT before;

UPDATE animals SET weight_kg = weight_kg * (-1);

SELECT * FROM animals;

ROLLBACK TO before;

SELECT * FROM animals;

UPDATE animals SET weight_kg = weight_kg * (-1) WHERE weight_kg < 0;

SELECT * FROM animals;

COMMIT;

/*What is the average weight of animals?*/

SELECT * FROM animals;

SELECT SUM(weight_kg) / COUNT(*) AS weight_kg_average FROM animals;

/*
 What is the minimum and maximum weight of each type of animal?
 */

SELECT * FROM animals;

SELECT
    species,
    MAX(weight_kg) AS max_weight,
    MIN(weight_kg) AS min_weight
FROM animals
GROUP BY species;

/*
 What is the average number of escape attempts per animal type of those born between 1990 and 2000?
 */

SELECT
    SUM(escape_attempts) / COUNT(*) AS escape_attempts_average
FROM animals
WHERE
    species = 'digimon'
    AND date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';

SELECT
    SUM(escape_attempts) / COUNT(species = 'pokemon') AS escape_attempts_average
FROM animals
WHERE
    species = 'pokemon'
    AND date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';

/*---------------------------------------------------------------------------------------------------------
 
 
 What animals belong to Melody Pond?
 */

SELECT name, owner_id
FROM animals
    INNER JOIN owners ON owners.id = owner_id
WHERE
    owners.full_name LIKE 'Melody Pond';

/*List of all animals that are pokemon (their type is Pokemon).*/

SELECT name
FROM animals
    INNER JOIN species ON species.id = species_id
WHERE
    species.full_name LIKE 'Pokemon';

/*
 List all owners and their animals, remember to include those that don't own any animal.
 */

SELECT
    animals.name AS animal_name,
    owners.full_name AS owner_name
FROM animals
    LEFT JOIN owners ON animals.owner_id = owners.id;

/*
 How many animals are there per species?
 */

SELECT
    COUNT(CASE WHEN species.full_name = 'Pokemon' THEN animals.id END) AS Pokemon_Count,
    COUNT(CASE WHEN species.full_name = 'Digimon' THEN animals.id END) AS Digimon_Count
FROM animals
INNER JOIN species ON animals.species_id = species.id
WHERE species.full_name IN ('Pokemon', 'Digimon');

/*
List all Digimon owned by Jennifer Orwell.
*/
SELECT name, owner_id
FROM animals
    INNER JOIN owners ON owners.id = owner_id
WHERE
    owners.full_name LIKE 'Jennifer Orwell';

/*
List all animals owned by Dean Winchester that haven't tried to escape.
*/
SELECT COUNT(animals.name) AS Animal_Count
FROM animals
INNER JOIN owners ON owners.id = animals.owner_id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;
/*
Who owns the most animals?
*/
SELECT owners.full_name
FROM owners
LEFT JOIN (
    SELECT owner_id, COUNT(*) AS Animal_Count
    FROM animals
    GROUP BY owner_id
) AS AnimalCounts ON owners.id = AnimalCounts.owner_id
ORDER BY AnimalCounts.Animal_Count DESC
LIMIT 1;
/*
Who was the last animal seen by William Tatcher?
*/
SELECT animals.name AS animal_name
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC
LIMIT 1;
/*
How many different animals did Stephanie Mendez see?
*/
SELECT vets.name AS vet_name, COUNT(visits.animal_id) AS total_animals_seing
FROM visits
INNER JOIN animals
ON animals.id = visits.animal_id
INNER JOIN vets
ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez'
GROUP BY vets.name;

/*
List all vets and their specialties, including vets with no specialties.
*/
SELECT vets.name AS vet_name, species.full_name AS speciality
FROM vets 
LEFT JOIN specializations 
ON vets.id = specializations.vet_id
LEFT JOIN species 
ON species.id = specializations.specie_id;
/*
List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
*/
SELECT animals.name AS animal_name, vets.name AS vet_name, date_of_visit
FROM vets
INNER JOIN visits
ON vets.id = visits.vet_id
INNER JOIN animals
ON visits.animal_id = animals.id
WHERE vets.name = 'Stephanie Mendez' AND date_of_visit >= '2020-04-01' AND date_of_visit <= '2020-08-30'
GROUP BY vets.name, animals.name, date_of_visit;

/* What animal has the most visits to vets?*/
SELECT animals.name AS animal_name, COUNT(visits.animal_id) AS total_visits
FROM animals
INNER JOIN visits
ON animals.id = visits.animal_id 
GROUP BY animals.name
ORDER BY total_visits DESC
LIMIT 1;
/*
Who was Maisy Smith's first visit?
*/
SELECT animals.name AS animal_name, vets.name AS vet_name, MIN(date_of_visit) AS first_visit
FROM animals
INNER JOIN visits
ON animals.id = visits.animal_id
INNER JOIN vets
ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
GROUP BY animals.name, vets.name
ORDER BY first_visit ASC
LIMIT 1;
/*
Details for most recent visit: animal information, vet information, and date of visit.
*/
SELECT animals.name AS animal_name, date_of_birth, ESCAPE_ATTEMPTS, neutered, weight_kg, species.full_name AS especie, owners.full_name AS owner_name, vets.name AS vet_name, vets.age AS vet_age, date_of_graduation, MAX(date_of_visit) AS most_recent_visit
FROM animals
INNER JOIN visits
ON animals.id = visits.animal_id
INNER JOIN vets
ON vets.id = visits.vet_id
INNER JOIN owners
ON owners.id = animals.owner_id
INNER JOIN species
ON species.id = animals.species_id
GROUP BY animals.name, vets.name, date_of_birth, ESCAPE_ATTEMPTS, neutered, weight_kg, especie, owner_name, vet_age, date_of_graduation 
ORDER BY most_recent_visit DESC
LIMIT 1;

/*
How many visits were with a vet that did not specialize in that animal's species?
*/
SELECT COUNT(*) AS total_visits
FROM visits
INNER JOIN animals
ON animals.id = visits.animal_id
INNER JOIN vets
ON vets.id = visits.vet_id
LEFT JOIN specializations
ON specializations.vet_id = vets.id AND animals.species_id = specializations.specie_id
WHERE specializations.vet_id IS NULL;

/*
What specialty should Maisy Smith consider getting? Look for the species she gets the most.
*/
SELECT vets.name AS vet_name, species.full_name AS specie, COUNT(visits.animal_id) AS total_visits_get
FROM visits
INNER JOIN animals
ON animals.id = visits.animal_id
INNER JOIN species
ON species.id = animals.species_id
LEFT JOIN vets
ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.full_name, vets.name
ORDER BY total_visits_get DESC
LIMIT 1;