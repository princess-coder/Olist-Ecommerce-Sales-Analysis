USE olist_ecommerce;
GO

-- Step 1: Create the View (again)
CREATE OR ALTER VIEW vw_Sales_Clean AS
SELECT
  o.order_id,
  o.customer_id,
  CAST(o.order_purchase_timestamp AS DATE) AS Order_Date,
  YEAR(o.order_purchase_timestamp) AS Order_Year,
  MONTH(o.order_purchase_timestamp) AS Order_Month,
  i.product_id,
  i.seller_id,
  i.price,
  i.freight_value,
  (i.price + i.freight_value) AS Total_Value,
  t.product_category_name_english AS Category_English,
  c.customer_state,
  c.customer_city,
  r.review_score
FROM olist_orders_dataset o
JOIN olist_order_items_dataset i ON o.order_id = i.order_id
JOIN olist_products_dataset p ON i.product_id = p.product_id
LEFT JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
LEFT JOIN olist_order_reviews_dataset r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered';
GO

-- Step 2: Check it worked
SELECT COUNT(*) AS Clean_Sales_Rows FROM vw_Sales_Clean;
GO

-- Step 3: Q1 - Revenue by Month
SELECT
  Order_Year,
  Order_Month,
  COUNT(order_id) AS Total_Items_Sold,
  SUM(price) AS Product_Revenue,
  SUM(freight_value) AS Freight_Revenue,
  SUM(Total_Value) AS Total_Revenue,
  AVG(review_score) AS Avg_Review
FROM vw_Sales_Clean
GROUP BY Order_Year, Order_Month
ORDER BY Order_Year, Order_Month;