# Analyzing eCommerce Business Performance with SQL

### **Overview :**
In a company measuring business performance is very important to track, monitor, and assess the success or failure of various business processes. This can help us to see current market conditions, growth analysis, and product analysis, and to develop opportunities for new, more effective business methods. Therefore, this project will analyze the business performance of an eCommerce company, taking into account several business metrics, namely customer growth, product quality, and payment types.

In this project, an analysis will be carried out using **PostgreSQL** and visualizing the results using **Tableau**.

<img src="https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/90f010bd-167d-40fc-91f6-f9a0cff1b496" height="100"/>

<img src="https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/3e2d350b-8dac-4411-a295-33b351f9efd2" height="100"/>

<img src="https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/7ae0bef7-fb24-45cc-97d9-6c67c18c070a" height="80"/>

### **Datasets :**
The dataset used is provided by Rakamin Academy, [Brazilian E-Commerce Public Dataset by Olist](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/tree/main/Dataset). Or it can be accessed on the [Kaggle dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce). This is a Brazilian e-commerce public dataset of orders made at the Olist Store. The dataset has information on 100k orders from 2016 to 2018 made at multiple marketplaces in Brazil. Its features allow viewing orders from various dimensions: from order status, price, payment, and freight performance to customer location, product attributes, and finally reviews written by customers. This also released a geolocation dataset that relates Brazilian zip codes to lat/long coordinates.

**SQL Query Files :**
* [Data Preparation.sql](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/01.%20Data%20Preparation.sql)
* [Annual Customer Activity Growth Analysis.sql](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/02.%20Annual%20Customer%20Activity%20Growth%20Analysis.sql)
* [Annual Product Category Quality Analysis.sql](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/03.%20Annual%20Product%20Category%20Quality%20Analysis.sql)
* [Annual Payment Type Usage Analysis.sql](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/04.%20Annual%20Payment%20Type%20Usage%20Analysis.sql)

**ERD Files :**
* [ERD Final.pgerd](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/ERD/ERD%20Final.pgerd)
* [ERD Final.png](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/ERD/ERD%20Final.png)

**Tableau Dashboard :** [Visualization](https://public.tableau.com/views/AnalyzingeCommerceBusinessPerformance_16897228876050/Dashboard?:language=en-US&publish=yes&:display_count=n&:origin=viz_share_link)


## Data Preparation

1. **Creating Database & Table :**

   * **Create Database**
  
     We can create an ecommerce database by using the CREATE DATABASE query or by using the pgAdmin 4 GUI

   * **Create Tables**
     
     Create several tables in the ecommerce database by using the CREATE TABLE query or using the pgAdmin 4 GUI, along with column names, data types, and primary keys.

   * **List of Tables Created :**
     customers, geolocation, order_items, order_payments, order_reviews, orders, products, sellers

2. **Importing Data :**

   * **Import Data into Table**
     
     After make sure column names and data types match, then we enter the .csv data into each table by using the COPY query or using the pgAdmin GUI.

   * **Pre-Cleaning Data**
   
     Specifically for geolocation data, cleaning will be carried out first including :
     1. Drop Duplicate Rows
     2. Change Special Character in City
     3. Input new geolocations from customers and sellers

3. **Entity Relationship :**

   Next, create an ERD by specifying the Primary key and Foreign key for each table. Then the relationship between the keys is connected by specifying the Constraint name. So that an Entity Relationship Diagram (ERD) is formed as shown in the picture.

   ![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/c2a20db9-17ab-4c7c-8367-8a270f99ff3b)


## **Annual Customer Activity Growth Analysis**

**Overview :**

The increase in growth customers is a reflection of the effectiveness  in sales. That's why customer growth is one of the main goals of an e-commerce company. It is not only essential to grow our customers but also to retain them. One of the metrics used to measure eCommerce business performance is customer activity that interacts on the eCommerce platform. In this section, we will analyze several metrics related to customer activity such as the number of active customers, the number of new customers, the number of customers who make repeat orders and also the average transactions made by customers every year. Analyze whether the eCommerce business performance in terms of customer activity has grown, stagnated or even decreased in the past year.

   ![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/64bac72d-1246-45ef-8202-852f2c4e9d93)

1. **Average Monthly Active User (MAU) per year**
   
   Displays the average number of monthly active users (monthly active users) for each year

   ![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/dd2a2178-c449-4478-8eb6-d8e001567b2b)

2. **Total new customers per year**

   Displays the number of new customers in each year

   ![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/c1e44f65-c56b-4ecb-8c6e-ed2a9d7e5d0b)

   ![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/1815ac65-6951-494b-9f34-5b7293b83a92)

   **Observation :**
   * Monthly Active Users have increased every year, adding up to thousands of customers
   * There was a significant increase in 2017, but it could be because the data is only available for 4 months starting in September. Then it increased again in 2018
   * This shows that e-commerce performance is related to having good engagement to attract customer interest, which is indicated by an increase in the average active customer. Also promotion of branding awareness good ecommerce so new customers are interested in starting orders, besides that it is possible, there are promos or vouchers for new customers which are also interesting.

   ![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/7135c1ae-431c-49b4-979e-4380d12af665)
   
   **Observation :**
   * The fact that the data for 2016 starts from 4 months, starting from September
   * In 2017, every month experienced an increase, most in November.
   * This increase in November is likely due to Black Friday. Black Friday is the colloquial term for the Friday after Thanksgiving. It traditionally marks the start of the Christmas shopping season. Many stores offer highly promoted sales at discounted prices and are often open early, sometimes as late as midnight.
   * But 2018 looks a bit stagnant for the increase in active users


3. **The number of customers who make repeat orders per year**

   Displays the number of customers who make purchases more than once (repeat orders) in each year

   ![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/dcb2cfc9-d09f-45f9-b0ab-d3d22607b73e)

4. **Average order frequency for each year**

   Displays the average number of orders made by customers for each year

   ![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/a1665184-a330-4ea5-9742-d40e4898f9e9)

   ![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/5f9f13c6-e01d-4997-ad15-5a6c6f206e21)

   **Observation :**
   * There was a significant increase in repeat orders in 2017. However, there was a decrease in 2018 as many as 100 customers
   * From the average value of the number of orders it can be seen that most people order only once in the last 3 years

5. **Additional**
   * It is known that the data only starts at 4 months in 2016 in September. So many new customers have just bought or tried the products in this e-commerce. This can be seen from the increase in new customers and MAU (Monthly Active Users) from 2016 - 2018. However, there is a difference in the number of repeat orders, that in 2016 - 2017 there has been a significant increase, but in 2017 - 2018 it has decreased. So that further analysis can be carried out on the causes of the decline in repeat orders in the last year and also in terms of existing business methods.
   * The small average number of orders for each customer may be due to the lack of programs or maintenance from business marketing. This can be improved by holding a loyalty program, introducing new products and attracting potential customers for each new product launched.


## **Annual Product Category Quality Analysis**

**Overview :**

E-Commerce business performance is of course very closely related to the products available in it. Analyzing product quality in eCommerce can provide decisions for developing a more effective business. By analyzing product quality in e-commerce, we can gain insight on how to better develop our business. Product quality is important because it influences a company's success and helps build its reputation in the customer market. When a company can create high-quality products that continuously meet customer demands, it can result in a higher return on investment and increased revenue. In this section, we will analyze product categories that have a positive impact (in terms of revenue metrics) as well as product categories that have a negative impact (in terms of the number of order cancellation metrics) for the company each year.

![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/bb8c9ddc-dbdb-4355-97d1-d7a5a7e29103)

1. **Table of revenue per year**

   Create a table that contains total company revenue information for each year
   
   ![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/de2b45e4-6a99-416b-a8ae-b82382e2b995)

2. **Table of the number of canceled orders per year**

   Create a table that contains information on the total number of canceled orders for each year
   
   ![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/60e7eb2e-9380-4571-9d09-42607638532e)

   ![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/5120eb75-1db6-4128-becb-310c53ce7cbf)

   **Observation :**
   * There is an increase in revenue every year. although the previous data, namely repeat orders, showed a decrease from 2017 to 2018. This could be due to a sharp increase in the number of new customers each year
   * There was an increase in canceled orders from 2016 to 2018. However, the value is not on a large scale, still in the hundreds compared to the thousands. It is better if additional data is needed regarding the review of reasons for canceling orders to avoid an increase in the number of cancels in the following year
  
3. **Table of the top categories that generate the largest revenue per year**

   Create a table containing the product category names that provide the highest total revenue for each year

   ![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/4d767c3c-1213-4f31-856f-b871c06c50ef)

4. **Table of categories that experienced the most canceled orders per year**

   Create a table containing the names of the product categories that have the highest number of canceled orders for each year
   
   ![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/a9ef8ba2-9d46-4cf8-b140-8fb02472c4ff)

   ![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/95b6addf-4ddc-42e4-8d14-7bddfa3a57b8)

   Observation :
   * It can be seen that the types of product categories, both top revenue and top canceled, all have different types each year
   * However, there was an interesting thing in 2018, it was found that the Health Beauty category was in the same position as the top highest revenue and canceled. This could be because the most orders were in the health and beauty categories











   








 
