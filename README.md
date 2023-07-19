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

![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/cbf62b91-7996-45c2-adc3-48dd519248ac)

![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/a93b0d38-15d2-4d96-b1b0-e5b5b4cd1b3f)

1. **Table of revenue per year**

   Create a table that contains total company revenue information for each year
   
   ![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/0a1d9f58-00e8-4242-8d33-c85008010063)

2. **Table of the number of canceled orders per year**

   Create a table that contains information on the total number of canceled orders for each year
   
   ![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/11e46eba-2712-483c-b76b-df559e9ffb32)

   ![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/5120eb75-1db6-4128-becb-310c53ce7cbf)

   **Observation :**
   * There is an increase in revenue every year. although the previous data, namely repeat orders, showed a decrease from 2017 to 2018. This could be due to a sharp increase in the number of new customers each year
   * There was an increase in canceled orders from 2016 to 2018. However, the value is not on a large scale, still in the hundreds compared to the thousands. It is better if additional data is needed regarding the review of reasons for canceling orders to avoid an increase in the number of cancels in the following year
  
3. **Table of the top categories that generate the largest revenue per year**

   Create a table containing the product category names that provide the highest total revenue for each year

   ![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/1c7235f9-f5d3-4728-bfb3-3e35eee954ec)

4. **Table of categories that experienced the most canceled orders per year**

   Create a table containing the names of the product categories that have the highest number of canceled orders for each year
   
   ![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/74038d52-4882-48a9-8f17-e02e06045ca2)

   ![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/95b6addf-4ddc-42e4-8d14-7bddfa3a57b8)

   Observation :
   * It can be seen that the types of product categories, both top revenue and top canceled, all have different types each year
   * However, there was an interesting thing in 2018, it was found that the Health Beauty category was in the same position as the top highest revenue and canceled. This could be because the most orders were in the health and beauty categories


## **Analysis of Annual Payment Type Usage**

**Overview :**

Effective income analysis requires consideration of the payment method and its impact on customer behavior. Research indicates that customers are likely to abandon their purchase if their preferred payment option is unavailable. In e-commerce, offering an open payment system with diverse options is essential. Analyzing the performance of each payment type will provide valuable insights, enabling strategic partnerships with payment providers to enhance customer satisfaction and optimize revenue streams.

1. **Total usage of each type of payment all time**

   Displays the total usage of each type of payment at all time, sorted from the favorite

   ![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/98a35659-1327-4a4b-833e-1d9bb8edbf0c)
   
   ![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/d524b7cd-78cc-494e-ad57-3b339641a6bd)

   **Observation :**
   * There are 4 common payment methods, Credit Card, Boleto, Voucher, Debit Card
   * The use of credit cards as a means of payment is the most compared to other types of payments. By looking at this, companies can work with credit card provider banks to provide more attractive promotions. Further analysis can be carried out on customer behavior in using credit cards, such as the payment credit type chosen, what product categories are usually purchased with credit cards, etc.
   * Because many customers use credit cards, boleto and vouchers, bonuses or promotions can be given that target the most favorite payment types.

2. **Details of the amount used for each type of payment for each year**

   Displays detailed information on the amount of usage for each type of payment for each year
   
   ![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/922ddb58-5769-4ebc-a6f1-aa0867a6dcf3)

   ![image](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/abdd16f4-f631-4221-91ad-67e16f87d4c4)

   **Observation :**
   * Furthermore, for each type of payment tends to increase significantly every year.
   * However, payments using vouchers have decreased in 2018. This could be due to a reduction in promotions using vouchers.
   * Further analysis can be carried out by confirming with other departments, such as Marketing, Analyst or Business Development.

## **Summary**

* Customer activity experienced growth in every metric from 2016 to 2018, including an increase in the number of new customers and Monthly Active Users (MAU). However, repeat customer orders remained stagnant during this period. Moreover, the average number of orders made by customers was only once.
* The analysis of Product Category Quality revealed a consistent growth in the company's total revenue each year. Interestingly, the most canceled product categories and best selling orders changed annually. Notably, the health beauty category emerged as both the most sold and the most canceled product category.
* Additionally, each type of payment showed a significant increase year over year. Credit cards were the most commonly used payment method from 2016 to 2018. However, payments made using vouchers experienced a decline in 2018.










   








 
