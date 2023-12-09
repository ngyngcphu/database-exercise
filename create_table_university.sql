CREATE TABLE classroom (
    building VARCHAR(15),
    room_number VARCHAR(7),
    capacity NUMERIC(4, 0),
    PRIMARY KEY (building, room_number)
);

CREATE TABLE department (
    dept_name VARCHAR(20),
    building VARCHAR(15),
    budget NUMERIC(12, 2) CHECK (budget > 0),
    PRIMARY KEY (dept_name)
);

CREATE TABLE course (
    course_id VARCHAR(8),
    title VARCHAR(50),
    dept_name VARCHAR(20),
    credits NUMERIC(2, 0) CHECK (credits > 0),
    PRIMARY KEY (course_id),
    FOREIGN KEY (dept_name) REFERENCES department (dept_name) ON DELETE
    SET
        NULL
);

CREATE TABLE instructor (
    id VARCHAR(5),
    name VARCHAR(20) NOT NULL,
    dept_name VARCHAR(20),
    salary NUMERIC(8, 2) CHECK (salary > 29000),
    PRIMARY KEY (id),
    FOREIGN KEY (dept_name) REFERENCES department (dept_name) ON DELETE
    SET
        NULL
);

CREATE TABLE section (
    sec_id VARCHAR(8),
    course_id VARCHAR(8),
    semester VARCHAR(6) CHECK (
        semester IN ('Fall', 'Winter', 'Spring', 'Summer')
    ),
    year NUMERIC(4, 0) CHECK (
        year > 1701
        AND year < 2100
    ),
    building VARCHAR(15),
    room_number VARCHAR(7),
    time_slot_id VARCHAR(4),
    PRIMARY KEY (sec_id, course_id, semester, year),
    FOREIGN KEY (course_id) REFERENCES course (course_id) ON DELETE CASCADE,
    FOREIGN KEY (building, room_number) REFERENCES classroom (building, room_number) ON DELETE
    SET
        NULL
);

CREATE TABLE teaches (
    id VARCHAR(5),
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6),
    year NUMERIC(4, 0),
    PRIMARY KEY (id, course_id, sec_id, semester, year),
    FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section (course_id, sec_id, semester, year) ON DELETE CASCADE,
    FOREIGN KEY (id) REFERENCES instructor (id) ON DELETE CASCADE
);

CREATE TABLE student (
    id VARCHAR(5),
    name VARCHAR(20) NOT NULL,
    dept_name VARCHAR(20),
    tot_cred NUMERIC(3, 0) CHECK (tot_cred >= 0),
    PRIMARY KEY (id),
    FOREIGN KEY (dept_name) REFERENCES department (dept_name) ON DELETE
    SET
        NULL
);

CREATE TABLE takes (
    id VARCHAR(5),
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6),
    year NUMERIC(4, 0),
    grade VARCHAR(2),
    PRIMARY KEY (id, course_id, sec_id, semester, year),
    FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section (course_id, sec_id, semester, year) ON DELETE CASCADE,
    FOREIGN KEY (id) REFERENCES student (id) ON DELETE CASCADE
);

CREATE TABLE advisor (
    s_id VARCHAR(5),
    i_id VARCHAR(5),
    PRIMARY KEY (s_id),
    FOREIGN KEY (s_id) REFERENCES student (id) ON DELETE CASCADE,
    FOREIGN KEY (i_id) REFERENCES instructor (id) ON DELETE
    SET
        NULL
);

CREATE TABLE time_slot (
    time_slot_id VARCHAR(4),
    DAY VARCHAR(1),
    start_hr NUMERIC(2) CHECK (
        start_hr >= 0
        AND start_hr < 24
    ),
    start_min NUMERIC(2) CHECK (
        start_min >= 0
        AND start_min < 60
    ),
    end_hr NUMERIC(2) CHECK (
        end_hr >= 0
        AND end_hr < 24
    ),
    end_min NUMERIC(2) CHECK (
        end_min >= 0
        AND end_min < 60
    ),
    PRIMARY KEY (time_slot_id, DAY, start_hr, start_min)
);

CREATE TABLE prereq (
    prereq_id VARCHAR(8),
    course_id VARCHAR(8),
    PRIMARY KEY (prereq_id, course_id),
    FOREIGN KEY (course_id) REFERENCES course (course_id) ON DELETE CASCADE,
    FOREIGN KEY (prereq_id) REFERENCES course (course_id) ON DELETE CASCADE
)