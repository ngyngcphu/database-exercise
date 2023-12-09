(
    SELECT
        SUM(c.credits * g.points)
    FROM
        takes AS t
        INNER JOIN course AS c ON t.course_id = c.course_id
        INNER JOIN grade_points AS g ON t.grade = g.grade
    WHERE
        t.id = '12345'
)
UNION
(
    SELECT
        0
    FROM
        student
    WHERE
        id = '12345'
        AND NOT EXISTS (
            SELECT
                *
            FROM
                takes
            WHERE
                id = '12345'
        )
);

(
    SELECT
        SUM(c.credits * g.points) / SUM(c.credits) AS GPA
    FROM
        takes AS t
        INNER JOIN course AS c ON t.course_id = c.course_id
        INNER JOIN grade_points AS g ON t.grade = g.grade
    WHERE
        t.id = '12345'
)
UNION
(
    SELECT
        NULL AS GPA
    FROM
        student
    WHERE
        id = '12345'
        AND NOT EXISTS (
            SELECT
                *
            FROM
                takes
            WHERE
                id = '12345'
        )
);

(
    SELECT
        t.id,
        SUM(c.credits * g.points) / SUM(c.credits) AS GPA
    FROM
        takes AS t
        INNER JOIN course AS c ON t.course_id = c.course_id
        INNER JOIN grade_points AS g ON t.grade = g.grade
    GROUP BY
        t.id
)
UNION
(
    SELECT
        id,
        NULL AS GPA
    FROM
        student
    WHERE
        NOT EXISTS (
            SELECT
                *
            FROM
                takes
            WHERE
                takes.id = student.id
        )
);