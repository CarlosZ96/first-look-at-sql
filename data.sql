/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Agumon', '2020-02-03', 10.23, TRUE, 0);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Gabumon', '2018-11-15', 8, TRUE, 2);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Pikachu', '2021-01-07', 15.04, FALSE, 1);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Devimon', '2017-04-12', 11, TRUE, 5);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Charmander', '2020-02-08', -11, FALSE, 0);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Plantmon', '2021-11-15', -5.7, TRUE, 2);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Squirtle', '1993-04-02', -5.7, FALSE, 3);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Angemon', '2005-06-12', -45, TRUE, 1);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Boarmon', '2005-06-07', 20.4, TRUE, 7);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Blossom', '1998-10-13', 17, TRUE, 3);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Ditto', '2022-05-14', 17, TRUE, 4);

INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age)
VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age)
VALUES ('Bob', 45);
INSERT INTO owners (full_name, age)
VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age)
VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age)
VALUES ('Jodie Whittaker', 38);
INSERT INTO species (full_name)
VALUES ('Pokemon');
INSERT INTO species (full_name)
VALUES ('Digimon');

UPDATE animals
SET species_id = (SELECT id FROM species WHERE full_name = 'Digimon')
WHERE name LIKE '%mon';
UPDATE animals
SET species_id = (SELECT id FROM species WHERE full_name = 'Pokemon')
WHERE name NOT LIKE '%mon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name LIKE 'Agumon';
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name LIKE 'Plantmon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23');
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Maisy Smith', 26, '2019-01-17');
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Stephanie Mendez', 64, '1981-05-04');
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (, specializations.vet_id)
VALUES ();

INSERT INTO specializations (specie_id, vet_id)
SELECT species.id, vets.id FROM species, vets
WHERE species.full_name = 'Pokemon' AND vets.name = 'William Tatcher'
UNION
SELECT species.id, vets.id FROM species, vets
WHERE species.full_name = 'Digimon' AND vets.name = 'Stephanie Mendez'
UNION
SELECT species.id, vets.id FROM species, vets
WHERE species.full_name = 'Pokemon' AND vets.name = 'Stephanie Mendez'
UNION
SELECT species.id, vets.id FROM species, vets
WHERE species.full_name = 'Digimon' AND vets.name = 'Jack Harkness';

INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT animals.id, vets.id, '2020-05-24' FROM animals, vets
WHERE animals.name = 'Agumon' AND vets.name = 'William Tatcher'


INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT animals.id, vets.id, '2020-07-22' FROM animals, vets
WHERE animals.name = 'Agumon' AND vets.name = 'Stephanie Mendez'


INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT animals.id, vets.id, '2021-02-02' FROM animals, vets
WHERE animals.name = 'Gabumon' AND vets.name = 'Jack Harkness'

INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT animals.id, vets.id, '2020-01-05' FROM animals, vets
WHERE animals.name = 'Pikachu' AND vets.name = 'Maisy Smith'

INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT animals.id, vets.id, '2020-03-08' FROM animals, vets
WHERE animals.name = 'Pikachu' AND vets.name = 'Maisy Smith'


INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT animals.id, vets.id, '2020-05-14' FROM animals, vets
WHERE animals.name = 'Pikachu' AND vets.name = 'Maisy Smith'

INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT animals.id, vets.id, '2021-05-04' FROM animals, vets
WHERE animals.name = 'Devimon' AND vets.name = 'Stephanie Mendez'

INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT animals.id, vets.id, '2021-02-24' FROM animals, vets
WHERE animals.name = 'Charmander' AND vets.name = 'Jack Harkness'

INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT animals.id, vets.id, '2019-12-21' FROM animals, vets
WHERE animals.name = 'Plantmon' AND vets.name = 'Maisy Smith'

INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT animals.id, vets.id, '2020-08-10' FROM animals, vets
WHERE animals.name = 'Plantmon' AND vets.name = 'William Tatcher'

INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT animals.id, vets.id, '2021-04-07' FROM animals, vets
WHERE animals.name = 'Plantmon' AND vets.name = 'Maisy Smith'

INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT animals.id, vets.id, '2019-09-29' FROM animals, vets
WHERE animals.name = 'Squirtle' AND vets.name = 'Stephanie Mendez'

INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT animals.id, vets.id, '2020-10-03' FROM animals, vets
WHERE animals.name = 'Angemon' AND vets.name = 'Jack Harkness'

INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT animals.id, vets.id, '2020-11-04' FROM animals, vets
WHERE animals.name = 'Angemon' AND vets.name = 'Jack Harkness'

INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT animals.id, vets.id, '2019-01-24' FROM animals, vets
WHERE animals.name = 'Boarmon' AND vets.name = 'Maisy Smith'

INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT animals.id, vets.id, '2019-05-15' FROM animals, vets
WHERE animals.name = 'Boarmon' AND vets.name = 'Maisy Smith'

INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT animals.id, vets.id, '2020-02-27' FROM animals, vets
WHERE animals.name = 'Boarmon' AND vets.name = 'Maisy Smith'

INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT animals.id, vets.id, '2020-08-03' FROM animals, vets
WHERE animals.name = 'Boarmon' AND vets.name = 'Maisy Smith'

INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT animals.id, vets.id, '2020-05-24' FROM animals, vets
WHERE animals.name = 'Blossom' AND vets.name = 'Stephanie Mendez'

INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT animals.id, vets.id, '2021-01-11' FROM animals, vets
WHERE animals.name = 'Blossom' AND vets.name = 'William Tatcher';
