 АРХИТЕКТУРА И ПОДГОТОВКА ДАННЫХ


-- Создание временной таблицы для импорта сырого датасета (Big Data лог)
CREATE TABLE raw_import (
    event_time TIMESTAMP,
    event_type VARCHAR(20),
    product_id BIGINT,
    category_id BIGINT,
    category_code VARCHAR(100),
    brand VARCHAR(50),
    price NUMERIC(10, 2),
    user_id BIGINT,
    user_session UUID
);

-- Создание нормализованной таблицы пользователей
CREATE TABLE users (
    user_id BIGINT PRIMARY KEY,
    first_seen TIMESTAMP
);

-- Создание таблицы заказов с разделением по типам оплаты
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(user_id),
    order_date TIMESTAMP,
    product_id BIGINT,
    category_code VARCHAR(100),
    brand VARCHAR(50),
    price NUMERIC(10, 2),
    payment_method VARCHAR(20) -- 'card' или 'bnpl'
);

-- Создание таблицы графиков платежей BNPL (Финтех-модель)
CREATE TABLE bnpl_payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    loan_part_number INT,
    due_date DATE,
    fact_payment_date DATE
);
