use ecomm;
select * from customer_churn;

/*  Data Exploration and Analysis:*/

--  1)  Retrieve the count of churned and active customers from the dataset.
select ChurnStatus, count(ChurnStatus) as count_of_ChurnStatus from customer_churn 
group by ChurnStatus order by ChurnStatus;

--  2)  Display the average tenure of customers who churned.
SELECT ChurnStatus, ROUND(AVG(tenure),2) AS Average_tenure FROM customer_churn 
WHERE ChurnStatus='churned';

--  3)  Calculate the total cashback amount earned by customers who churned.
SELECT ChurnStatus, SUM(CashbackAmount) AS total_cashback_amount FROM customer_churn 
WHERE ChurnStatus='churned';

--  4)  Determine the percentage of churned customers who complained.
SELECT ChurnStatus, round((sum(IF(ComplaintReceived='Yes',1,0))*100/count(*)),2)  AS percentage_of_churned_who_complained
FROM customer_churn WHERE ChurnStatus='churned';

--  5)  Find the gender distribution of customers who complained.
SELECT Gender, COUNT(*) AS Complained FROM customer_churn WHERE ComplaintReceived='Yes' 
GROUP BY Gender;

--  6)  Identify the city tier with the highest number of churned customers whose preferred order category is Laptop & Accessory.
SELECT CityTier, Count(*) AS number_of_churned FROM customer_churn 
where ChurnStatus='churned' AND PreferredOrderCat='Laptop & Accessory'
GROUP BY CityTier ORDER BY CityTier DESC LIMIT 1;

--  7)  Identify the most preferred payment mode among active customers.
SELECT PreferredPaymentMode,COUNT(*) AS preferred_payment_mode_count FROM customer_churn 
WHERE ChurnStatus='active' 
GROUP BY PreferredPaymentMode
ORDER BY preferred_payment_mode_count DESC LIMIT 1;

--  8)  List the preferred login device(s) among customers who took more than 10 days since their last order.
SELECT PreferredLoginDevice, COUNT(PreferredLoginDevice) AS Count_of_PreferredLoginDevice FROM customer_churn
WHERE DaySinceLastOrder>10
GROUP BY PreferredLoginDevice;

--  9)  List the number of active customers who spent more than 3 hours on the app.
SELECT ChurnStatus, HoursSpentOnApp, COUNT(*) AS Number_of_customer_spentOnApp FROM  customer_churn 
WHERE ChurnStatus='active' AND HoursSpentOnApp>3
GROUP BY HoursSpentOnApp;

-- 10)  Find the average cashback amount received by customers who spent at least 2 hours on the app.
SELECT ROUND(AVG(CashbackAmount),2) AS average_cashback_amount FROM customer_churn 
WHERE HoursSpentOnApp>=2;

-- 11)  Display the maximum hours spent on the app by customers in each preferred order category.
SELECT PreferredOrderCat, MAX(HoursSpentOnApp) AS Maximum_hours_spent FROM customer_churn 
GROUP BY PreferredOrderCat;

-- 12)  Find the average order amount hike from last year for customers in each marital status category.
SELECT MaritalStatus, ROUND(AVG(OrderAmountHikeFromlastYear),2) AS AVERAGE_OrderAmountHikeFromlastYear FROM customer_churn 
GROUP BY MaritalStatus;

-- 13)  Calculate the total order amount hike from last year for customers who are single and prefer mobile phones for ordering.
SELECT MaritalStatus, PreferredOrderCat, SUM(OrderAmountHikeFromlastYear) AS Total_OrderAmountHikeFromlastYear FROM customer_churn 
WHERE MaritalStatus= 'single' AND PreferredOrderCat= 'Mobile Phone';

-- 14)  Find the average number of devices registered among customers who used UPI as their preferred payment mode.
SELECT PreferredPaymentMode, ROUND(AVG(NumberOfDeviceRegistered),2) AS AVERAGE_NumberOfDeviceRegistered FROM customer_churn
WHERE PreferredPaymentMode='UPI';

-- 15)  Determine the city tier with the highest number of customers
SELECT CityTier, COUNT(*) AS COUNT_OF_CUSTOMERS FROM customer_churn 
GROUP BY CityTier
ORDER BY COUNT_OF_CUSTOMERS DESC LIMIT 1;

-- 16)  Find the marital status of customers with the highest number of addresses.
SELECT MaritalStatus, count(NumberOfAddress) AS Highest_number_of_addresses FROM customer_churn
GROUP BY MaritalStatus 
ORDER BY Highest_number_of_addresses DESC LIMIT 1;

-- 17)  Identify the gender that utilized the highest number of coupons.
SELECT Gender, COUNT(CouponUsed) AS Highest_number_of_coupon FROM customer_churn 
GROUP BY Gender
ORDER BY Highest_number_of_coupon DESC LIMIT 1;

-- 18)  List the average satisfaction score in each of the preferred order categories.
SELECT PreferredOrderCat, ROUND(AVG(SatisfactionScore),2) AS Average_satisfaction_each_category FROM customer_churn
GROUP BY PreferredOrderCat
ORDER BY Average_satisfaction_each_category DESC;

-- 19)  Calculate the total order count for customers who prefer using credit cards and have the maximum satisfaction score.
SELECT PreferredPaymentMode, SUM(OrderCount) AS Total_order_count FROM customer_churn 
WHERE (SELECT MAX(SatisfactionScore) FROM CUSTOMER_CHURN) 
GROUP BY PreferredPaymentMode  HAVING  PreferredPaymentMode= 'Credit Card';

-- 20)  How many customers are there who spent only one hour on the app and days since their last order was more than 5?
SELECT COUNT(*) COUNT_OF_CUSTOMERS FROM customer_churn WHERE HoursSpentOnApp =1 AND DaySinceLastOrder>5;

-- 21)  What is the average satisfaction score of customers who have complained
SELECT ComplaintReceived, round(AVG(SatisfactionScore),2) AS Average_satisfactionscore FROM customer_churn 
WHERE ComplaintReceived='Yes';

-- 22)  How many customers are there in each preferred order category
SELECT PreferredOrderCat, COUNT(*) AS count_of_customer_PreferredOrderCat FROM  customer_churn
GROUP BY PreferredOrderCat
ORDER BY count_of_customer_PreferredOrderCat DESC;

-- 23)  What is the average cashback amount received by married customers
SELECT MaritalStatus, round(AVG(CashbackAmount),2) AS Average_CashbackAmount FROM customer_churn
WHERE MaritalStatus = 'Married';

-- 24)  What is the average number of devices registered by customers who are not using Mobile Phone as their preferred login device?
SELECT ROUND(AVG(NumberOfDeviceRegistered),2) AS Average_number_of_devices_registered FROM customer_churn 
WHERE PreferredLoginDevice<>'Mobile Phone';
SELECT ROUND(AVG(NumberOfDeviceRegistered),2) AS Average_number_of_devices_registered FROM customer_churn 
GROUP BY PreferredLoginDevice 
HAVING 'Mobile Phone' NOT IN (PreferredLoginDevice);

-- 25)  List the preferred order category among customers who used more than 5 coupons
SELECT CustomerID,PreferredOrderCat, CouponUsed  FROM customer_churn 
WHERE CouponUsed> 5;

-- 26)  List the top 3 preferred order categories with the highest average cashback amount.
SELECT PreferredOrderCat, ROUND(AVG(CashbackAmount),2) AS Average_CashbackAmount FROM customer_churn 
GROUP BY PreferredOrderCat
ORDER BY Average_CashbackAmount DESC LIMIT 3;

-- 27)  Find the preferred payment modes of customers whose average tenure is 10 months and have placed more than 500 orders.
SELECT PreferredPaymentMode, ROUND(AVG(Tenure)) AS Average_Tenure, SUM(OrderCount) AS Sum_of_orders_placed FROM customer_churn
GROUP BY PreferredPaymentMode
HAVING  Sum_of_orders_placed>500 AND Average_Tenure= 10;

/* 28)  Categorize customers based on their distance from the warehouse to home such as 'Very Close Distance' 
		for distances <=5km, 'Close Distance' for <=10km, 'Moderate Distance' for <=15km, and 'Far Distance' for >15km. 
		Then, display the churn status breakdown for each distance category.*/
SELECT CustomerID, WarehouseToHome, IF(WarehouseToHome<=5, 'Very Close Distance',IF(WarehouseToHome<=10,'Close Distance', 
IF(WarehouseToHome<=15,'Moderate Distance', 'Far Distance'))) AS Distance_category FROM customer_churn;

SELECT CustomerID, WarehouseToHome, 
	CASE
		WHEN WarehouseToHome<=5 THEN 'Very Close Distance'
        WHEN WarehouseToHome<=10 THEN 'Close Distance'
        WHEN WarehouseToHome<=15 THEN 'Moderate Distance'
        ELSE 'Far Distance'
	END AS Distance_category
FROM customer_churn;

/*  29)  List the customer’s order details who are married, live in City Tier-1, and their order counts are more than 
		 the average number of orders placed by all customers.*/
SELECT * FROM customer_churn
WHERE MaritalStatus= 'married' AND CityTier= '1' AND OrderCount>(SELECT AVG(OrderCount) FROM customer_churn);


-- 30)  a) Create a ‘customer_returns’ table in the ‘ecomm’ database and insert the data: 
-- 		   create table 'customer_returns'
use ecomm;
CREATE TABLE customer_returns(
	ReturnID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES customer_churn (CustomerID),
    ReturnDate DATE,
    RefundAmount INT
);

-- 		   INSERT VALUES INTO customer_returns TABLE
INSERT INTO customer_returns VALUES
	(1001, 50022, '2023-01-01', 2130),
    (1002, 50316, '2023-01-23', 2000),
    (1003, 51099, '2023-02-14', 2290),
    (1004, 52321, '2023-03-08', 2510),
    (1005, 52928, '2023-03-20', 3000),
    (1006, 53749, '2023-04-17', 1740),
    (1007, 54206, '2023-04-21', 3250),
    (1008, 54838, '2023-04-30', 1990);

SELECT * FROM customer_returns;

-- B)  Display the return details along with the customer details of those who have churned and have made complaints.
SELECT customer_returns.ReturnID, customer_returns.CustomerID, customer_returns.ReturnDate, 
customer_returns.RefundAmount, customer_churn.ComplaintReceived, customer_churn.ChurnStatus
FROM  customer_returns
LEFT JOIN customer_churn ON customer_returns.CustomerID=customer_churn.CustomerID
WHERE ChurnStatus= 'Churned' AND ComplaintReceived ='YES';



