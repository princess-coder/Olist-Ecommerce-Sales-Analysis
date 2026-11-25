USE olist_ecommerce;
GO

-- Q3: Revenue by State
SELECT TOP 10
  customer_state AS State,
  COUNT(*) AS Items_Sold,
  SUM(price) AS Product_Revenue,
  AVG(price) AS Avg_Price,
  AVG(review_score) AS Avg_Review
FROM vw_Sales_Clean
GROUP BY customer_state
ORDER BY Product_Revenue DESC;
