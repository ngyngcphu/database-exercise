INSERT INTO
    course (course_id, title, dept_name, credits)
VALUES
    ('CS-001', 'Weekly Seminar', 'Comp. Sci.', 1);

INSERT INTO
    section (course_id, sec_id, semester, year)
VALUES
    ('CS-001', '1', 'Fall', 2017);

INSERT INTO
    takes (id, course_id, sec_id, semester, year)
SELECT
    id,
    'CS-001',
    '1',
    'Fall',
    2017
FROM
    student
WHERE
    dept_name = 'Comp. Sci.';

DELETE FROM
    takes
WHERE
    id = '12345'
    AND (course_id, sec_id, semester, year) = ('CS-001', '1', 'Fall', 2017);

DELETE FROM
    course
WHERE
    course_id = 'CS-001';

DELETE FROM
    takes
WHERE
    course_id IN (
        SELECT
            course_id
        FROM
            course
        WHERE
            LOWER(title) LIKE '%advanced'
    );