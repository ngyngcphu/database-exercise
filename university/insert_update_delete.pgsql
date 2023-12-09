UPDATE
    instructor
SET
    salary = salary * 1.10
WHERE
    dept_name = 'Comp. Sci.';

DELETE FROM
    course
WHERE
    course_id NOT IN (
        SELECT
            course_id
        FROM
            section
    );

INSERT INTO
    instructor
SELECT
    id,
    name,
    dept_name,
    100000
FROM
    student
WHERE
    tot_cred > 100;

SELECT
    dept_name
FROM
    department
WHERE
    LOWER(dept_name) LIKE '%sci%'