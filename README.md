# Superstore Sales Analysis

## Project Overview

This is an end-to-end Data Analyst portfolio project analyzing Superstore sales data to identify revenue trends, customer behavior, product performance, regional opportunities, seasonality, and shipping patterns.

The analysis follows a complete data analytics workflow using Python, SQL, and Power BI, with the goal of transforming raw transactional data into actionable business insights and recommendations.
## Business Problem

The objective of this project is to analyze Superstore sales data and identify the key factors influencing revenue performance.

The analysis focuses on:

- Identifying sales and revenue trends over time
- Understanding customer purchasing behavior and revenue concentration
- Evaluating product and category performance
- Comparing regional sales performance
- Investigating seasonal patterns in sales and order activity
- Evaluating shipping performance and potential operational opportunities

The goal is to translate these findings into actionable business insights and recommendations that could support decisions around customer engagement, product performance, regional growth, and operational efficiency
## Objectives

The key objectives of this analysis are to:

- Analyze overall sales performance and year-over-year growth
- Identify seasonal trends and periods of high and low sales activity
- Segment customers based on their contribution to total sales
- Identify high-performing and underperforming products and sub-categories
- Evaluate regional sales performance and identify areas requiring attention
- Analyze shipping performance across shipping modes and regions
- Translate analytical findings into actionable business recommendations
- ## Dataset

The project uses the Superstore Sales Dataset containing 9,800 transactional records across 18 original columns.

Key fields include:

- Order and shipping dates
- Customer and order information
- Customer segment
- Geographic information
- Product and category information
- Sales

The dataset does not contain fields such as Quantity, Profit, Discount, or Cost. Therefore, the analysis focuses on sales/revenue, order activity, customer behavior, product performance, regional performance, seasonality, and shipping patterns.

### Data Preparation

Python and Pandas were used to:

- Inspect the dataset structure and data types
- Check for missing values
- Convert date fields into appropriate datetime formats
- Create derived shipping duration information
- Perform exploratory analysis and validate key findings

SQL was then used to reproduce and extend the analysis through business-focused queries

## Tools & Technologies

- *Python* — Data cleaning, exploration, analysis, and visualization
- *Pandas* — Data manipulation and analysis
- *NumPy* — Numerical analysis
- *Matplotlib & Seaborn* — Data visualization
- *SQL (PostgreSQL)* — Business-focused querying and analysis
- *Power BI* — Interactive dashboard development and reporting
- *GitHub* — Project documentation and version control
- ## Analysis Workflow

The project follows a structured end-to-end analytics workflow:

### 1. Python & Exploratory Data Analysis

Python and Pandas were used to inspect, clean, transform, and explore the dataset. Exploratory analysis was performed to identify sales trends, customer patterns, product performance, regional differences, seasonality, and shipping behavior.

### 2. SQL Analysis

PostgreSQL was used to reproduce key findings and perform deeper business-focused analysis. SQL queries were used to analyze customer segments, regional performance, product-level changes, order activity, and shipping performance.

### 3. Power BI Dashboard

Power BI was used to transform the analytical findings into interactive dashboards for business reporting and decision-making.

The dashboard provides views of:

- Overall sales performance
- Year-over-year sales growth
- Monthly sales trends
- Category and regional performance
- Customer value segments
- Top customers and products
- Sub-category performance
- Shipping performance

### 4. Business Insights & Recommendations

The analytical results were evaluated from a business perspective to identify revenue opportunities, areas requiring attention, and potential operational improvements.
## Key Findings

### 1. Revenue Concentration

*Finding:* Approximately 25% of customers account for 55% of total sales, indicating significant revenue concentration among high-value customers.

*Business Implication:* A relatively small customer group contributes a large share of revenue, making retention and engagement of these customers particularly important.

*Recommendation:* Prioritize retention and re-engagement strategies for high-value customers and continue monitoring their purchasing behavior, particularly during weaker sales periods.
