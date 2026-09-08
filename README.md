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
### 2. Central Region Performance

*Finding:* Central region sales declined by approximately 2.8% in 2018 despite a 33% increase in order volume. Average order value declined by approximately 27%, meaning the increase in orders was not enough to offset the lower revenue generated per order. The decline was concentrated in several sub-categories, with Copiers showing the largest decrease. The Canon imageCLASS 2200 Advanced Copier alone declined by approximately $17.5K in sales.

*Business Implication:* Central is generating more orders but extracting less revenue per order. The sharp decline in a previously significant copier product contributed substantially to the regional sales decline.

*Recommendation:* Investigate changes in Central's order composition and the reasons behind the decline in high-value products, particularly the Canon imageCLASS 2200 Advanced Copier. Potential factors such as product availability, customer demand, or product mix should be investigated before deciding on corrective actions.
### 3. Strong Sales Seasonality

*Finding:* Sales show a strong recurring seasonal pattern. November is the highest-sales month across the dataset, generating approximately $350K in total sales, while February is the weakest month at approximately $59K. November sales are nearly 6 times higher than February sales.

*Business Implication:* The business experiences a significant difference in sales activity throughout the year. The consistently weaker performance in January and February represents a potential opportunity to improve revenue during the early months of the year.

*Recommendation:* Maintain strong preparation for the November sales period while investigating strategies to increase order activity during January and February. Potential approaches could include targeted promotions, customer re-engagement campaigns, and seasonal offers designed to encourage additional purchases during weaker periods.
### 4. High-Value Customer Product Concentration

*Finding:* The highest-value 25% of customers generate approximately 55% of total sales. Within this customer group, Technology is the largest category, generating approximately $539K, or 43% of their sales. Within Technology, Phones and Machines together account for approximately 64% of Technology sales for this customer segment.

*Business Implication:* Revenue is concentrated among high-value customers, and their Technology purchases represent an important part of this revenue. Heavy reliance on a relatively small customer group and a limited set of product areas could create concentration risk if purchasing patterns change.

*Recommendation:* Prioritize retention and engagement of high-value customers while monitoring the products and sub-categories that contribute most to their sales. Management should also evaluate opportunities to broaden product demand and reduce excessive reliance on specific customer and product groups over time.
