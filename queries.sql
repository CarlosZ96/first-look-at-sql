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