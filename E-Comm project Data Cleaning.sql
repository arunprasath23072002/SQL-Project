use ecomm;
select * from  customer_churn;

-- Data Cleaning:
-- Handling Missing Values and Outliers:
/* 1)  Impute mean for the following columns, and round off to the nearest integer if required: 
	  WarehouseToHome, HourSpendOnApp, OrderAmountHikeFromlastYear, DaySinceLastOrder.*/

-- mean values update by warehouseToHome column
set @mean_warehousetohome=round((select avg(WarehouseToHome is not null) from customer_churn),0);
select @mean_warehousetohome;
set sql_safe_updates=0;
update customer_churn
set WarehouseToHome= @mean_warehousetohome
where WarehouseToHome is null;

-- mean values update missing field by HourSpendOnApp column
set @HourSpendOnApp= round((select avg(HourSpendOnApp is not null) from customer_churn),0);
select @HourSpendOnApp;
update customer_churn
set HourSpendOnApp = @HourSpendOnApp
where HourSpendOnApp is null;

-- mean values update missing field by OrderAmountHikeFromlastYear column
set @OrderAmountHikeFromlastYear = round((select avg(OrderAmountHikeFromlastYear is not null) from customer_churn),0);
select @OrderAmountHikeFromlastYear;
update customer_churn
set OrderAmountHikeFromlastYear = @OrderAmountHikeFromlastYear
where OrderAmountHikeFromlastYear is null;

-- mean values update missing field by DaySinceLastOrder column
set @DaySinceLastOrder = round((select avg(DaySinceLastOrder is not null) from customer_churn),0);
select @DaySinceLastOrder;
update customer_churn
set DaySinceLastOrder = @DaySinceLastOrder
where DaySinceLastOrder is null;


/*  2) Impute mode for the following columns: Tenure, CouponUsed, OrderCount.*/
select Tenure from customer_churn group by Tenure order by count(Tenure) desc limit 1 ;

-- impute mode for the missing field of the Tenure column 
set @Tenure=(select Tenure from customer_churn group by Tenure order by count(Tenure) desc limit 1 );
select @Tenure;
update customer_churn
set tenure =@Tenure
where tenure is null;

-- Impute mode for the missing field of the CouponUsed column
select CouponUsed, count(couponused) from customer_churn group by CouponUsed order by count(CouponUsed) desc ;
select CouponUsed from customer_churn group by CouponUsed order by count(CouponUsed) desc limit 1;
set @CouponUsed =(select CouponUsed from customer_churn group by CouponUsed order by count(CouponUsed) desc limit 1);
select @CouponUsed;
update customer_churn
set couponused = @couponused
where couponused is null;

-- Impute mode for the missing field of the OrderCount column
select OrderCount, count(OrderCount) from customer_churn group by ordercount order by count(ordercount) desc;
select ordercount from customer_churn group by ordercount order by count(ordercount) desc limit 1;
set @ordercount = (select ordercount from customer_churn group by ordercount order by count(ordercount) desc limit 1);
select @ordercount;
update customer_churn
set ordercount = @ordercount
where ordercount is null;



/*  3)  Handle outliers in the 'WarehouseToHome' column by deleting rows where the values are greater than 100.*/
-- Delete the outlier WarehouseToHome column 
DELETE FROM customer_churn
WHERE WarehouseToHome > 100;



-- Dealing with Inconsistencies: 
/*  1)  Replace occurrences of “Phone” in the 'PreferredLoginDevice' column and 
	  “Mobile” in the 'PreferedOrderCat' column with “Mobile Phone” to ensure uniformity.*/

-- Replace inconsistence 'phone' word change to 'Mobile Phone'
update customer_churn
set PreferredLoginDevice= concat('Mobile ',PreferredLoginDevice) 
where PreferredLoginDevice='Phone';

-- Replace inconsistence 'Mobile' word change to 'Mobile Phone'
update customer_churn
set PreferedOrderCat = 'Mobile Phone'
where PreferedOrderCat ='Mobile';

/*  2)  Standardize payment mode values: Replace "COD" with "Cash on Delivery" and "CC" with "Credit Card" 
		in the PreferredPaymentMode column.*/
select PreferredPaymentMode, count(PreferredPaymentMode) from customer_churn group by PreferredPaymentMode;

-- Replace "COD" with "Cash on Delivery" in the PreferredPaymentMode column.
update customer_churn
set PreferredPaymentMode ='Credit Card'
where PreferredPaymentMode = 'cc';

-- Replace "CC" with "Credit Card" in the PreferredPaymentMode column.
update customer_churn
set PreferredPaymentMode = 'Cash on Delivery'
where PreferredPaymentMode = 'COD';

