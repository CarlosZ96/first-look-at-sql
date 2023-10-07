/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  date_of_birth DATE NOT NULL,
  escape_attempts INT,
  neutered BOOLEAN,
  weight_kg DECIMAL
);

ALTER TABLE animals
ADD species VARCHAR(100);

ALTER TABLE animals
DROP COLUMN owner_id,
DROP COLUMN species_id;

CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  age INT
);
CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL
);

ALTER TABLE animals
ADD species_id INT,
ADD owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id),
ADD CONSTRAINT fk_owner FOREIGN KEY (owner_id) REFERENCES owners(id);