-- Добавляем отдел, если его ещё нет
INSERT INTO departments (name)
SELECT 'Главное отделение'
WHERE NOT EXISTS (
    SELECT 1
    FROM departments
    WHERE name = 'Главное отделение'
);

-- Добавляем график работы на две недели
INSERT INTO work_schedules (
    post_office_code,
    department_code,
    day_of_week,
    start_time,
    end_time,
    break_start_time,
    break_end_time
)
SELECT
    1,
    d.department_code,
    v.day_of_week,
    v.start_time,
    v.end_time,
    v.break_start_time,
    v.break_end_time
FROM departments d
CROSS JOIN (
    VALUES
    ('Monday_1',    TIME '09:00', TIME '18:00', TIME '13:00', TIME '14:00'),
    ('Tuesday_1',   TIME '09:00', TIME '18:00', TIME '13:00', TIME '14:00'),
    ('Wednesday_1', TIME '09:00', TIME '18:00', TIME '13:00', TIME '14:00'),
    ('Thursday_1',  TIME '09:00', TIME '18:00', TIME '13:00', TIME '14:00'),
    ('Friday_1',    TIME '09:00', TIME '18:00', TIME '13:00', TIME '14:00'),
    ('Saturday_1',  TIME '10:00', TIME '15:00', NULL::TIME, NULL::TIME),
    ('Monday_2',    TIME '09:00', TIME '18:00', TIME '13:00', TIME '14:00'),
    ('Tuesday_2',   TIME '09:00', TIME '18:00', TIME '13:00', TIME '14:00'),
    ('Wednesday_2', TIME '09:00', TIME '18:00', TIME '13:00', TIME '14:00'),
    ('Thursday_2',  TIME '09:00', TIME '18:00', TIME '13:00', TIME '14:00'),
    ('Friday_2',    TIME '09:00', TIME '18:00', TIME '13:00', TIME '14:00'),
    ('Saturday_2',  TIME '10:00', TIME '15:00', NULL::TIME, NULL::TIME)
) AS v(day_of_week, start_time, end_time, break_start_time, break_end_time)
WHERE NOT EXISTS (
    SELECT 1
    FROM work_schedules ws
    WHERE ws.post_office_code = 1
      AND ws.department_code = d.department_code
      AND ws.day_of_week = v.day_of_week
);