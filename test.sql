CREATE TABLE IF NOT EXISTS cars (
    brand VARCHAR(255),
    model VARCHAR(255),
    year INT
);

INSERT INTO
    cars (brand, model, year)
VALUES
    ('Ford', 'Mustang', 1964);

INSERT INTO
    cars (brand, model, year)
VALUES
    ('Volvo', 'p1800', 1968),
    ('BMW', 'M1', 1978),
    ('Toyota', 'Celica', 1975);

SELECT
    brand,
    year
FROM
    cars;

ALTER TABLE
    cars
ADD
    color VARCHAR(255);

UPDATE
    cars
SET
    color = 'red',
    year = 1970
WHERE
    brand = 'Toyota';

ALTER TABLE
    cars
ALTER COLUMN
    year TYPE VARCHAR(4);

ALTER TABLE
    cars
ALTER COLUMN
    color TYPE VARCHAR(30);

ALTER TABLE
    cars DROP COLUMN color;

DELETE FROM
    cars
WHERE
    brand = 'Volvo';

DELETE FROM
    cars;

TRUNCATE TABLE cars;

DROP TABLE cars;

SELECT
    *
FROM
    cars;