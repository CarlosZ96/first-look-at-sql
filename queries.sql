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