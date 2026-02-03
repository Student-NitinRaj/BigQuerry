SELECT  *FROM `my-bigquarry-project.NAME.Lamborghini_sales` LIMIT 1000

SELECT *
FROM `my-bigquarry-project.NAME.Lamborghini_sales`
LIMIT 10;

SELECT
  Year,
  `Sales Volume`,
  Color
FROM `my-bigquarry-project.NAME.Lamborghini_sales`
LIMIT 10;

SELECT
  Year,
  `Sales Volume`,
  Color
FROM `my-bigquarry-project.NAME.Lamborghini_sales`
WHERE Year = 2024
LIMIT 100;

SELECT
  Year,
  SUM(`Sales Volume`) AS Total_Sales
FROM `my-bigquarry-project.NAME.Lamborghini_sales`
GROUP BY Year
ORDER BY Year;

SELECT
  Color,
  SUM(`Sales Volume`) AS Color_Sales
FROM `my-bigquarry-project.NAME.Lamborghini_sales`
GROUP BY Color
ORDER BY Color_Sales DESC;

SELECT
  Year,
  `Sales Volume`,
  CASE
    WHEN `Sales Volume` >= 1000 THEN 'High'
    WHEN `Sales Volume` >= 500 THEN 'Medium'
    ELSE 'Low'
  END AS Sales_Category
FROM `my-bigquarry-project.NAME.Lamborghini_sales`;

SELECT
  Year,
  `Sales Volume`,
  CASE
    WHEN `Sales Volume` > 0 THEN 1
    ELSE 0
  END AS Has_Sales
FROM `my-bigquarry-project.NAME.Lamborghini_sales`;

SELECT
  Year,
  Model,
  `Sales Volume`,
  ROW_NUMBER() OVER (PARTITION BY Year ORDER BY `Sales Volume` DESC) AS row_num
FROM `my-bigquarry-project.NAME.Lamborghini_sales`;

SELECT
  Year,
  Model,
  `Sales Volume`,
  RANK() OVER (PARTITION BY Year ORDER BY `Sales Volume` DESC) AS rank_num
FROM `my-bigquarry-project.NAME.Lamborghini_sales`;


CREATE OR REPLACE MODEL
`my-bigquarry-project.NAME.sales_model`
OPTIONS(
  model_type = 'linear_reg',
  input_label_cols = ['Sales Volume']
) AS
SELECT
  Year,
  Engine_Size,
  Price,
  `Sales Volume`
FROM `my-bigquarry-project.NAME.Lamborghini_sales`;


SELECT *
FROM ML.PREDICT(
  MODEL `my-bigquarry-project.NAME.sales_model`,
  (
    SELECT
      2020 AS Year,
      631 AS Horsepower,
      235000 AS Base_Price
  )
);

