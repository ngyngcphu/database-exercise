SELECT
    DISTINCT student.id,
    student.name
FROM
    student
    INNER JOIN takes ON student.id = takes.id
    INNER JOIN course ON takes.course_id = course.course_id
WHERE
    course.dept_name = 'Comp. Sci.';

SELECT
    id,
    name
FROM
    student
WHERE
    NOT EXISTS (
        SELECT
            *
        FROM
            takes
        WHERE
            year < 2017
            AND takes.id = student.id
    );

SELECT
    dept_name,
    MAX(salary)
FROM
    instructor
GROUP BY
    dept_name;

WITH maximum_salary_within_depth(dept_name, max_salary) AS (
    SELECT
        dept_name,
        max(salary)
    FROM
        instructor
    GROUP BY
        dept_name
)
SELECT
    MIN(max_salary)
FROM
    maximum_salary_within_depth;