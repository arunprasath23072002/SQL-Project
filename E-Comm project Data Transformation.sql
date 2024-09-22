use ecomm;
select * from customer_churn;

-- Data Transformation:

/* Column Renaming: 
   1)   Rename the column "PreferedOrderCat" to "PreferredOrderCat". 
   2)   Rename the column "HourSpendOnApp" to "HoursSpentOnApp".*/

ALTER TABLE customer_churn
RENAME COLUMN PreferedOrderCat TO PreferredOrderCat;

ALTER TABLE customer_churn
RENAME COLUMN HourSpendOnApp TO HoursSpentOnApp;


/*Creating New Columns: 
  1)   Create a new column named ‘ComplaintReceived’ with values "Yes"
		if the corresponding value in the ‘Complain’ is 1, and "No" otherwise.
  2)   Create a new column named 'ChurnStatus'. Set its value to “Churned” 
		if the corresponding value in the 'Churn' column is 1, else assign “Active”.*/

-- CREATE TABLE 'ComplaintReceived' 
ALTER TABLE customer_churn
ADD  ComplaintReceived VARCHAR(5);
update customer_churn
set ComplaintReceived = case when complain=1 then 'YES' else 'No' end;

-- CREATE TABLE 'ChurnStatus'
ALTER TABLE customer_churn
ADD COLUMN ChurnStatus VARCHAR(10);
UPDATE customer_churn
SET ChurnStatus = IF (Churn=1, 'Churn','Active');


/*Column Dropping: 
  1)   Drop the columns "Churn" and "Complain" from the table.*/
-- Drop the "Churn" column
ALTER TABLE customer_churn
DROP COLUMN Churn;

-- Drop the "Complain" column
ALTER TABLE customer_churn
DROP COLUMN Complain;




