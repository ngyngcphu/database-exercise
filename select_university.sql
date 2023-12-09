SELECT
    title
FROM
    course
WHERE
    dept_name = 'Comp. Sci.'
    AND credits = 3;

SELECT
    DISTINCT id
FROM
    takes
WHERE
    (course_id, sec_id, semester, year) IN (
        SELECT
            course_id,
            sec_id,
            semester,
            year
        FROM
            teaches
            INNER JOIN instructor ON teaches.id = instructor.id
        WHERE
            instructor.name = 'Einstein'
    );

SELECT
    MAX(salary)
FROM
    instructor;

SELECT
    id,
    name
FROM
    instructor
WHERE
    salary = (
        SELECT
            MAX(salary)
        FROM
            instructor
    );

SELECT
    course_id,
    sec_id,
    COUNT(id)
FROM
    takes
WHERE
    semester = 'Fall'
    AND year = 2017
GROUP BY
    course_id,
    sec_id;

WITH enrollment_in_fall_2017(course_id, sec_id, enrollment) AS (
    SELECT
        course_id,
        sec_id,
        COUNT(id)
    FROM
        takes
    WHERE
        semester = 'Fall'
        AND year = 2017
    GROUP BY
        course_id,
        sec_id
)
SELECT
    CASE
        WHEN MAX(enrollment) IS NOT NULL THEN MAX(enrollment)
        ELSE 0
    END
FROM
    enrollment_in_fall_2017;

WITH enrollment_in_fall_2017(course_id, sec_id, enrollment) AS (
    SELECT
        course_id,
        sec_id,
        COUNT(id)
    FROM
        takes
    WHERE
        semester = 'Fall'
        AND year = 2017
    GROUP BY
        course_id,
        sec_id
)
SELECT
    course_id,
    sec_id
FROM
    enrollment_in_fall_2017
WHERE
    enrollment = (
        SELECT
            MAX(enrollment)
        FROM
            enrollment_in_fall_2017
    )