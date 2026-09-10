БИЗНЕС-АНАЛИТИКА И МЕТРИКИ PRODUCT/FINTECH


-- 1. Исследование влияния BNPL на средний чек (AOV) и долю выручки (Оконные функции)
SELECT 
    payment_method,
    COUNT(*) AS total_orders,
    ROUND(AVG(price), 2) AS avg_check,
    ROUND(SUM(price), 2) AS total_revenue,
    ROUND(SUM(price) / SUM(SUM(price)) OVER() * 100, 2) AS revenue_share_percent
FROM orders
GROUP BY payment_method;

-- 2. Расчет финансового риска кредитного портфеля (Метрика NPL - Non-Performing Loans)
SELECT 
    ROUND(
        SUM(CASE WHEN bnpl.fact_payment_date IS NULL THEN orders.price / 4 ELSE 0 END) 
        / SUM(orders.price / 4) * 100, 
        2
    ) AS npl_percent
FROM orders
JOIN bnpl_payments AS bnpl ON bnpl.order_id = orders.order_id;
