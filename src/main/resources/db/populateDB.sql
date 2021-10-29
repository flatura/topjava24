DELETE FROM meals;
DELETE FROM user_roles;
DELETE FROM users;

ALTER SEQUENCE global_seq RESTART WITH 100000;

INSERT INTO users (name, email, password)
VALUES ('User', 'user@yandex.ru', 'password'),
       ('Admin', 'admin@gmail.com', 'admin');

INSERT INTO user_roles (role, user_id)
VALUES ('USER', 100000),
       ('ADMIN', 100001);

INSERT INTO meals (date_time, description, calories, user_id)
VALUES ('2020-01-30 10:00:00', 'Завтрак админа', 500, 100001),
       ('2020-01-30 13:00:00', 'Обед админа', 1000, 100001),
       ('2020-01-30 17:00:00', 'Ужин админа', 500, 100001),
       ('2020-01-31 10:00:00', 'Завтрак админа 2', 500, 100001),
       ('2020-01-31 13:00:00', 'Обед админа 2', 1000, 100001),
       ('2020-01-31 17:00:00', 'Ужин админа 2', 500, 100001),
       ('2020-01-31 11:00:00', 'Перекус пользаказ', 100, 100000),
       ('2020-01-30 10:00:00', 'Завтрак пользаказ', 1000, 100000),
       ('2020-01-30 13:00:00', 'ОБед пользаказ', 500, 100000),
       ('2020-01-30 17:00:00', 'Ужин пользаказ', 410, 100000),
       ('2020-01-31 10:00:00', 'Перекус пользаказ 2', 100, 100000),
       ('2020-01-31 13:00:00', 'Завтрак пользаказ 2', 1000, 100000),
       ('2020-01-31 14:00:00', 'ОБед пользаказ 2', 500, 100000),
       ('2020-01-31 17:00:00', 'Ужин пользаказ 2', 410, 100000);