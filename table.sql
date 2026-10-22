-- 1. Создаём родительскую таблицу отделов
CREATE TABLE departments (
    department_code SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    serves_individuals BOOLEAN DEFAULT TRUE,
    serves_legal_entities BOOLEAN DEFAULT TRUE,
    department_functions TEXT
);

-- 2. Создаём дочернюю таблицу графика работы
CREATE TABLE work_schedules (
    post_office_code INTEGER NOT NULL,
    department_code INTEGER NOT NULL,
    day_of_week VARCHAR(20) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    break_start_time TIME,
    break_end_time TIME,

    -- Составной первичный ключ
    PRIMARY KEY (
        post_office_code,
        department_code,
        day_of_week
    ),

    -- Внешний ключ на таблицу departments
    CONSTRAINT fk_department
        FOREIGN KEY (department_code)
        REFERENCES departments(department_code)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    -- Проверка правильности времени
    CONSTRAINT chk_work_time
        CHECK (end_time > start_time)
);

INSERT INTO work_schedules
    (post_office_code, department_code, day_of_week, start_time, end_time)
VALUES
    (1, 1, 'Monday', '09:00', '18:00');

INSERT INTO departments (name)
VALUES ('Бухгалтерия')
RETURNING department_code;
08:58


INSERT INTO work_schedules
