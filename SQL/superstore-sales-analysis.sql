-- ============================================================
-- SUPERSTORE SALES ANALYSIS
-- SQL Analysis | PostgreSQL
-- ============================================================


-- ============================================================
-- 1. DATA VALIDATION
-- ============================================================

-- Total rows
SELECT COUNT(*) AS total_rows
FROM superstore;


-- Unique orders, customers, and products
SELECT
    COUNT(DISTINCT "Order ID") AS total_orders,
    COUNT(DISTINCT "Customer ID") AS total_customers,
    COUNT(DISTINCT "Product ID") AS total_products
FROM superstore;


-- Check missing critical values
SELECT
    COUNT(*) FILTER (WHERE "Order ID" IS NULL) AS missing_order_id,
    COUNT(*) FILTER (WHERE "Order Date" IS NULL) AS missing_order_date,
    COUNT(*) FILTER (WHERE "Customer ID" IS NULL) AS missing_customer_id,
    COUNT(*) FILTER (WHERE "Product ID" IS NULL) AS missing_product_id,
    COUNT(*) FILTER (WHERE "Sales" IS NULL) AS missing_sales
FROM superstore;


-- ============================================================
-- 2. OVERALL SALES PERFORMANCE
-- ============================================================

-- Total sales
SELECT
    ROUND(SUM("Sales"), 2) AS total_sales
FROM superstore;


-- Yearly sales
SELECT
    EXTRACT(YEAR FROM "Order Date") AS year,
    ROUND(SUM("Sales"), 2) AS total_sales
FROM superstore
GROUP BY EXTRACT(YEAR FROM "Order Date")
ORDER BY year;


-- Year-over-year sales growth
WITH yearly_sales AS (
    SELECT
        EXTRACT(YEAR FROM "Order Date") AS year,
        SUM("Sales") AS total_sales
    FROM superstore
    GROUP BY EXTRACT(YEAR FROM "Order Date")
)
SELECT
    year,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(
        (total_sales - LAG(total_sales) OVER (ORDER BY year))
        / LAG(total_sales) OVER (ORDER BY year) * 100,
        2
    ) AS yoy_growth_pct
FROM yearly_sales
ORDER BY year;


-- Quarterly sales
SELECT
    EXTRACT(YEAR FROM "Order Date") AS year,
    EXTRACT(QUARTER FROM "Order Date") AS quarter,
    ROUND(SUM("Sales"), 2) AS total_sales
FROM superstore
GROUP BY
    EXTRACT(YEAR FROM "Order Date"),
    EXTRACT(QUARTER FROM "Order Date")
ORDER BY year, quarter;


-- ============================================================
-- 3. CATEGORY & SUB-CATEGORY ANALYSIS
-- ============================================================

-- Sales by category
SELECT
    "Category",
    ROUND(SUM("Sales"), 2) AS total_sales
FROM superstore
GROUP BY "Category"
ORDER BY total_sales DESC;


-- Sales by sub-category
SELECT
    "Sub-Category",
    ROUND(SUM("Sales"), 2) AS total_sales
FROM superstore
GROUP BY "Sub-Category"
ORDER BY total_sales DESC;


-- Category sales by year
SELECT
    EXTRACT(YEAR FROM "Order Date") AS year,
    "Category",
    ROUND(SUM("Sales"), 2) AS total_sales
FROM superstore
GROUP BY
    EXTRACT(YEAR FROM "Order Date"),
    "Category"
ORDER BY year, total_sales DESC;


-- Category year-over-year growth
WITH category_yearly_sales AS (
    SELECT
        EXTRACT(YEAR FROM "Order Date") AS year,
        "Category",
        SUM("Sales") AS total_sales
    FROM superstore
    GROUP BY
        EXTRACT(YEAR FROM "Order Date"),
        "Category"
)
SELECT
    year,
    "Category",
    ROUND(total_sales, 2) AS total_sales,
    ROUND(
        (
            total_sales
            - LAG(total_sales) OVER (
                PARTITION BY "Category"
                ORDER BY year
            )
        )
        / LAG(total_sales) OVER (
            PARTITION BY "Category"
            ORDER BY year
        ) * 100,
        2
    ) AS yoy_growth_pct
FROM category_yearly_sales
ORDER BY "Category", year;


-- ============================================================
-- 4. CUSTOMER ANALYSIS
-- ============================================================

-- Top customers by total sales
SELECT
    "Customer ID",
    "Customer Name",
    ROUND(SUM("Sales"), 2) AS total_sales
FROM superstore
GROUP BY
    "Customer ID",
    "Customer Name"
ORDER BY total_sales DESC
LIMIT 10;


-- Customers with the highest average order value
WITH customer_orders AS (
    SELECT
        "Customer ID",
        "Customer Name",
        "Order ID",
        SUM("Sales") AS order_sales
    FROM superstore
    GROUP BY
        "Customer ID",
        "Customer Name",
        "Order ID"
)
SELECT
    "Customer ID",
    "Customer Name",
    COUNT("Order ID") AS total_orders,
    ROUND(SUM(order_sales), 2) AS total_sales,
    ROUND(AVG(order_sales), 2) AS average_order_value
FROM customer_orders
GROUP BY
    "Customer ID",
    "Customer Name"
ORDER BY average_order_value DESC
LIMIT 10;


-- Customers with the highest number of orders
SELECT
    "Customer ID",
    "Customer Name",
    COUNT(DISTINCT "Order ID") AS total_orders
FROM superstore
GROUP BY
    "Customer ID",
    "Customer Name"
ORDER BY total_orders DESC
LIMIT 10;


-- ============================================================
-- 5. CUSTOMER VALUE SEGMENTATION
-- ============================================================

-- Divide customers into four sales-value quartiles
WITH customer_sales AS (
    SELECT
        "Customer ID",
        "Customer Name",
        SUM("Sales") AS total_sales
    FROM superstore
    GROUP BY
        "Customer ID",
        "Customer Name"
),
customer_segments AS (
    SELECT
        *,
        NTILE(4) OVER (ORDER BY total_sales) AS quartile
    FROM customer_sales
)
SELECT
    quartile,
    COUNT(*) AS customer_count,
    ROUND(AVG(total_sales), 2) AS average_customer_sales,
    ROUND(SUM(total_sales), 2) AS segment_sales
FROM customer_segments
GROUP BY quartile
ORDER BY quartile;


-- Customer value by category
WITH customer_sales AS (
    SELECT
        "Customer ID",
        SUM("Sales") AS total_sales
    FROM superstore
    GROUP BY "Customer ID"
),
customer_segments AS (
    SELECT
        "Customer ID",
        total_sales,
        NTILE(4) OVER (ORDER BY total_sales) AS quartile
    FROM customer_sales
)
SELECT
    cs.quartile,
    s."Category",
    ROUND(SUM(s."Sales"), 2) AS total_sales
FROM customer_segments cs
JOIN superstore s
    ON cs."Customer ID" = s."Customer ID"
GROUP BY
    cs.quartile,
    s."Category"
ORDER BY
    cs.quartile,
    total_sales DESC;


-- High-value customer technology sub-categories
WITH customer_sales AS (
    SELECT
        "Customer ID",
        SUM("Sales") AS total_sales
    FROM superstore
    GROUP BY "Customer ID"
),
customer_segments AS (
    SELECT
        "Customer ID",
        NTILE(4) OVER (ORDER BY total_sales) AS quartile
    FROM customer_sales
)
SELECT
    s."Sub-Category",
    ROUND(SUM(s."Sales"), 2) AS total_sales
FROM customer_segments cs
JOIN superstore s
    ON cs."Customer ID" = s."Customer ID"
WHERE
    cs.quartile = 4
    AND s."Category" = 'Technology'
GROUP BY s."Sub-Category"
ORDER BY total_sales DESC;


-- ============================================================
-- 6. REGIONAL ANALYSIS
-- ============================================================

-- Sales by region
SELECT
    "Region",
    ROUND(SUM("Sales"), 2) AS total_sales
FROM superstore
GROUP BY "Region"
ORDER BY total_sales DESC;


-- Sales by state
SELECT
    "State",
    ROUND(SUM("Sales"), 2) AS total_sales
FROM superstore
GROUP BY "State"
ORDER BY total_sales DESC;


-- Regional sales by year
WITH regional_yearly_sales AS (
    SELECT
        EXTRACT(YEAR FROM "Order Date") AS year,
        "Region",
        SUM("Sales") AS total_sales
    FROM superstore
    GROUP BY
        EXTRACT(YEAR FROM "Order Date"),
        "Region"
)
SELECT
    year,
    "Region",
    ROUND(total_sales, 2) AS total_sales,
    ROUND(
        (
            total_sales
            - LAG(total_sales) OVER (
                PARTITION BY "Region"
                ORDER BY year
            )
        )
        / LAG(total_sales) OVER (
            PARTITION BY "Region"
            ORDER BY year
        ) * 100,
        2
    ) AS yoy_growth_pct
FROM regional_yearly_sales
ORDER BY year, total_sales DESC;


-- ============================================================
-- 7. CENTRAL REGION DEEP DIVE
-- ============================================================

-- Central region category performance in 2018
SELECT
    "Category",
    ROUND(SUM("Sales"), 2) AS total_sales
FROM superstore
WHERE
    "Region" = 'Central'
    AND EXTRACT(YEAR FROM "Order Date") = 2018
GROUP BY "Category"
ORDER BY total_sales DESC;


-- Central Technology sub-category change:
-- 2017 vs 2018
SELECT
    "Sub-Category",
    ROUND(
        SUM(
            CASE
                WHEN EXTRACT(YEAR FROM "Order Date") = 2017
                THEN "Sales"
                ELSE 0
            END
        ),
        2
    ) AS sales_2017,
    ROUND(
        SUM(
            CASE
                WHEN EXTRACT(YEAR FROM "Order Date") = 2018
                THEN "Sales"
                ELSE 0
            END
        ),
        2
    ) AS sales_2018,
    ROUND(
        (
            SUM(
                CASE
                    WHEN EXTRACT(YEAR FROM "Order Date") = 2018
                    THEN "Sales"
                    ELSE 0
                END
            )
            -
            SUM(
                CASE
                    WHEN EXTRACT(YEAR FROM "Order Date") = 2017
                    THEN "Sales"
                    ELSE 0
                END
            )
        )
        /
        NULLIF(
            SUM(
                CASE
                    WHEN EXTRACT(YEAR FROM "Order Date") = 2017
                    THEN "Sales"
                    ELSE 0
                END
            ),
            0
        ) * 100,
        2
    ) AS growth_pct
FROM superstore
WHERE
    "Region" = 'Central'
    AND "Category" = 'Technology'
    AND EXTRACT(YEAR FROM "Order Date") IN (2017, 2018)
GROUP BY "Sub-Category"
ORDER BY growth_pct DESC;


-- ============================================================
-- 8. PRODUCT ANALYSIS
-- ============================================================

-- Top 10 products by sales
SELECT
    "Product ID",
    "Product Name",
    ROUND(SUM("Sales"), 2) AS total_sales
FROM superstore
GROUP BY
    "Product ID",
    "Product Name"
ORDER BY total_sales DESC
LIMIT 10;


-- Bottom 10 products by sales
SELECT
    "Product ID",
    "Product Name",
    ROUND(SUM("Sales"), 2) AS total_sales
FROM superstore
GROUP BY
    "Product ID",
    "Product Name"
ORDER BY total_sales
LIMIT 10;


-- ============================================================
-- 9. SEASONALITY
-- ============================================================

-- Sales by month across all years
SELECT
    EXTRACT(MONTH FROM "Order Date") AS month_number,
    TO_CHAR("Order Date", 'Month') AS month_name,
    ROUND(SUM("Sales"), 2) AS total_sales
FROM superstore
GROUP BY
    EXTRACT(MONTH FROM "Order Date"),
    TO_CHAR("Order Date", 'Month')
ORDER BY month_number;


-- Monthly sales and order activity
SELECT
    EXTRACT(MONTH FROM "Order Date") AS month_number,
    TO_CHAR("Order Date", 'Month') AS month_name,
    COUNT(DISTINCT "Order ID") AS total_orders,
    ROUND(SUM("Sales"), 2) AS total_sales,
    ROUND(
        SUM("Sales") / COUNT(DISTINCT "Order ID"),
        2
    ) AS average_order_value
FROM superstore
GROUP BY
    EXTRACT(MONTH FROM "Order Date"),
    TO_CHAR("Order Date", 'Month')
ORDER BY month_number;


-- ============================================================
-- 10. SHIPPING ANALYSIS
-- ============================================================

-- Calculate shipping duration at the order level
WITH order_shipping AS (
    SELECT DISTINCT
        "Order ID",
        "Ship Mode",
        "Order Date",
        "Ship Date",
        ("Ship Date"::date - "Order Date"::date) AS shipping_days
    FROM superstore
)
SELECT
    "Ship Mode",
    COUNT(*) AS total_orders,
    ROUND(AVG(shipping_days), 2) AS average_shipping_days,
    MIN(shipping_days) AS fastest_shipping_days,
    MAX(shipping_days) AS slowest_shipping_days
FROM order_shipping
GROUP BY "Ship Mode"
ORDER BY average_shipping_days;


-- Shipping performance by region
WITH order_shipping AS (
    SELECT DISTINCT
        "Order ID",
        "Region",
        ("Ship Date"::date - "Order Date"::date) AS shipping_days
    FROM superstore
)
SELECT
    "Region",
    COUNT(*) AS total_orders,
    ROUND(AVG(shipping_days), 2) AS average_shipping_days
FROM order_shipping
GROUP BY "Region"
ORDER BY average_shipping_days;


-- Shipping performance by customer value segment
WITH customer_sales AS (
    SELECT
        "Customer ID",
        SUM("Sales") AS total_sales
    FROM superstore
    GROUP BY "Customer ID"
),
customer_segments AS (
    SELECT
        "Customer ID",
        NTILE(4) OVER (ORDER BY total_sales) AS quartile
    FROM customer_sales
),
order_shipping AS (
    SELECT DISTINCT
        s."Order ID",
        s."Customer ID",
        (s."Ship Date"::date - s."Order Date"::date) AS shipping_days
    FROM superstore s
)
SELECT
    cs.quartile,
    COUNT(*) AS total_orders,
    ROUND(AVG(os.shipping_days), 2) AS average_shipping_days
FROM customer_segments cs
JOIN order_shipping os
    ON cs."Customer ID" = os."Customer ID"
GROUP BY cs.quartile
ORDER BY cs.quartile;


-- ============================================================
-- END OF ANALYSIS
-- ============================================================
