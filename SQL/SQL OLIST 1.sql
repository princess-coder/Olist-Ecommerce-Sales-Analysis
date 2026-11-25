USE olist_ecommerce;
GO

-- Q4: Review Score Breakdown
SELECT
  review_score AS Stars,
  COUNT(*) AS Total_Reviews,
  CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM vw_Sales_Clean WHERE review_score IS NOT NULL) AS DECIMAL(5,2)) AS Percent_of_Reviews,
  AVG(price) AS Avg_Price,
  AVG(freight_value) AS Avg_Freight
FROM vw_Sales_Clean
WHERE review_score IS NOT NULL
GROUP BY review_score
ORDER BY review_score DESC;
