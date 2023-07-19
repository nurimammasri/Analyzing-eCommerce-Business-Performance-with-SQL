# Analyzing eCommerce Business Performance with SQL

### **Overview :**
In a company measuring business performance is very important to track, monitor, and assess the success or failure of various business processes. This can help us to see current market conditions, growth analysis, and product analysis, and to develop opportunities for new, more effective business methods. Therefore, this project will analyze the business performance of an eCommerce company, taking into account several business metrics, namely customer growth, product quality, and payment types.

In this project, an analysis will be carried out using **PostgreSQL** and visualizing the results using **Tableau**.

<img src="https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/90f010bd-167d-40fc-91f6-f9a0cff1b496" height="100"/>

<img src="https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/3e2d350b-8dac-4411-a295-33b351f9efd2" height="100"/>

<img src="https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/assets/54845293/7ae0bef7-fb24-45cc-97d9-6c67c18c070a" height="80"/>

### **Datasets :**
The dataset used is provided by Rakamin Academy, [Brazilian E-Commerce Public Dataset by Olist](https://github.com/nurimammasri/Analyzing-eCommerce-Business-Performance-with-SQL/tree/main/Dataset). Or it can be accessed on the [Kaggle dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce). This is a Brazilian e-commerce public dataset of orders made at the Olist Store. The dataset has information on 100k orders from 2016 to 2018 made at multiple marketplaces in Brazil. Its features allow viewing orders from various dimensions: from order status, price, payment, and freight performance to customer location, product attributes, and finally reviews written by customers. This also released a geolocation dataset that relates Brazilian zip codes to lat/long coordinates.

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

















 
