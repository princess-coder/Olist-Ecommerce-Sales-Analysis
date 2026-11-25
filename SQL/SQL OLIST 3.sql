USE olist_ecommerce;
GO

-- Q2: Top 10 Categories by Revenue
SELECT TOP 10
  Category_English,
  COUNT(*) AS Items_Sold,
  SUM(price) AS Product_Revenue,
  AVG(price) AS Avg_Price,
  AVG(review_score) AS Avg_Review
FROM vw_Sales_Clean
GROUP BY Category_English
ORDER BY Product_Revenue DESC;
