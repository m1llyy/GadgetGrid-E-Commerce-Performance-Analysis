# GadgetGrid-E-Commerce-Performance-Analysis
<div align="center">
  <img width="800" height="400" alt="image" src="https://github.com/user-attachments/assets/0e3d6365-38b8-4cfc-919d-7955b8f2b386" />
</div>

# Company Background
Founded in 2018, GadgetGrid is a global e-commerce company specializing in electronic products. Like most e-commerce companies, GadgetGrid sells products through their online site as well as through their mobile app. They leverage a variety of marketing channels to reach customers, such as Email campaigns, SEO, and affiliate links. Over the past few years, their more popular products have been products from Apple, Samsung, and ThinkPad. Since founding, GadgetGrid has grown to nearly 88,000 customers across 194 countries, generating over 108,000 transactions and approximately $28M in revenue.

To support strategic decisions across finance, sales, product, and marketing, transactional data spanning 2019–2022 was analyzed to surface insights into revenue trends, product performance, and customer purchasing behavior.

## North Star Metric
GadgetGrid's primary measure of success is <b> total revenue </b> in USD. Supporting metrics include:
<li> <b>Order Volume</b> - total transactions placed. </li>
<li> <b>Average Order Value</b> - average spend per transaction. </li>
<li> <b>Refund Rate</b> — proportion of orders with a recorded return. </li>
<li> <b>Loyalty Member Share </b> — percentage of orders placed by loyalty members. </li>


## Areas of Analysis
<li> <b> Sales Trends </b> - Examining revenue, order volume, and average order value (AOV) across 2019-2022 to identify growth patterns and post-pandemic demand shifts. </li>
<li> <b> Product Performance </b> - Analyzing performance across the core product catalog to understand which products drive the most revenue and where refund rates are highest. </li>
<li> <b> Geographical Performance </b> - Evaluating purchasing behavior across 194 countries to surface regional demand patterns and opportunities for improvement. </li>
<li> <b> Loyalty Program </b> - Program adoption, member vs. non-member purchasing behavior and retention analysis. </li>
<li> <b> Marketing Channel Effectiveness </b> - Channel contribution to revenue, growth trends, and performance by acquisition source. </li>
<br />

<details open>
  <summary>Table of Contents</summary>
  
  - [Executive Summary](#executive-summary)
  - [Dataset](#dataset-structure)
  - [Sales Trends](#sales-trends)
  - [Seasonality Trends](#seasonality-trends)
  - [Product Trends](#product-trends)
      - [Refund Rates](#refund-rates)
  - [Geographic Performance](#geographic-performance)
  - [Loyalty Program](#loyalty-program)
  - [Marketing Channel Effectiveness](#marketing-channel-effectiveness)
  - [Recommendations](#recommendations)
    
</details>
<br />

# Overview
## Executive Summary
This project analyzes four years of e-commerce sales data (2019–2022) for GadgetGrid, a consumer electronics retailer serving 194 countries, spanning 108K+ transactions and $28.1M in total sales. Using Excel, SQL, and Tableau to surface insights across sales trends, product performance, geography, loyalty program, and marketing channels.

Key findings:
- Sales peaked in 2020 at $10.2M — a 163% YoY spike driven by pandemic demand for WFH electronics — before declining 52% by 2022
- Two products dominate — the 27in 4K Monitor and AirPods together account for ~63% of total sales; laptops carry the highest refund rates (11–12%)
- North America drives 52% of sales at $14.6M, with the US alone at 47% — significant geographic concentration risk
- Loyalty program is maturing — member order share grew from 12% to 52% between 2019–2022, with member AOV surpassing non-members for the first time in 2022
- Direct channel dominates at 83% of sales, though this likely reflects attribution gaps rather than true direct intent; email is the fastest growing channel at 5.8x order growth



## Dataset Structure
<img alt="image" src="https://github.com/user-attachments/assets/83ebf555-ba84-4227-b774-54d358ac6caf" />
Download the full Excel file <a href="https://docs.google.com/spreadsheets/d/1Aj63R9SBPkxhMo8NtUTvP8k1w7onVZRM/edit?usp=sharing&ouid=110060741658196042398&rtpof=true&sd=true">here</a>.
**Note:** For best experience, download the file and open in Microsoft Excel rather than Google Sheets.

# Deep Dive Insights
## Sales Trends
![Sales Summary Stats](./assets/stats-banner.svg)

- <b> Pre-COVID (2019) </b>: Established baseline of $3.9M in sales across 16.8K orders with an AOV of $230.
- <b> COVID (2020) </b>: Order volume doubled to 33.8K with AOV peaking at $300, reflecting a shift towards higher-ticket purchases.
- <b> Post-COVID (2021-2022) </b>: While sales in 2021 remained high, there was a steady decline with an AOV of $255. In 2022, sales declined 52% from peak, normalizing towards pre-pandemic levels with $5M in sales and an AOV of $230.   

<img alt="sales orders aov" src="https://github.com/user-attachments/assets/99343937-a0fe-4edd-88a8-74c6f079e3dc" />


## Seasonality Trends
- Best Perfoming Months: September, November, and December are consistently strong performing.
- December was the highest performing month across all four years, likely driven by holiday gift purchasing. December 2020 was the single highest-revenue month in the dataset at $1.25M which is roughly 3x the December 2019 figure.
- A secondary mid-year peak was observed in September-October across 2020-2021, potentially signfying back to school and early procurement. This pattern is consistent with product mixture (laptop, monitor, headphones) which skews towards academic and professional usage. 
- Worst Performing Months: Feburary is around the lowest or near lowest every year, suggesting a post-holiday hangover. 
<!-- <img alt="image" src="https://github.com/user-attachments/assets/d6ae3278-9fe5-41e6-98a1-f303e47c4ed2" /> -->

<img alt="seasonality" src="https://github.com/user-attachments/assets/cbe4c16d-7809-4be4-a76f-67b45ca29c18" />


## Product Trends
- <b> Best Performing Products </b>: The 27in 4K Monitor and AirPods were the top two products by sales, generating $9.9M and $7.7M respectively and together accounting for ~63% of total sales across 2019-2022.
- <b> Order Volume </b>: AirPods led in terms of order volume with 48K in units, reflecting strong mid-price point demand; the 27in 4K Monitor led in sales value despite lower order volume of 23K units.
- <b> Covid Driven Sales </b>: MacBook Air and ThinkPad saw the sharpest COVID driven sales spikes in 2020, consistent with remote work and learning demand. MacBook Air jumped from $607K in 2019 to $2.9M in 2020. Additionally, Samsung Webcam was not present in 2019 catalog, but grew steadily through 2021 ($171K), which further supports the WFH narrative.
<img alt="product performance" src="https://github.com/user-attachments/assets/1c899fe5-a6c1-4629-ab73-702bbb25cff5" />


### Refund Rates
From 2019-2022, 5,377 out of 108K orders were refunded, which is about a 5% return rate.
- <b> Highest Refund Rate </b>: MacBook Air and ThinkPad carried the highest refund rates at 11% and 12%, suggesting a product quality or customer expectation mismatch - notably after their large sales spikes during the pandemic when demand was high and potentially impulse driven.
- <b> Highest Refund Volume </b>: AirPods had the highest refund volume at 2.6K units, followed by the 27in 4K gaming monitor at 1.4K units.
- <b> Lowest Refund Volume </b>: Samsung Cable had the cleanest refund rate at 2.4% which is consistent with low-complexity and low-price-point, carrying a lower return risk. 

<img alt="Refund Rate" src="https://github.com/user-attachments/assets/16799467-fa87-4692-ab21-838d25fb1e7b" />


## Geographic Performance
<img alt="region" src="https://github.com/user-attachments/assets/c3bef42b-8aa8-4c57-bb65-dbe510c1d0c4" />


- <b> Top Performing Region</b>: North America was the top region by sales at $14.6M across 56K orders.
- <b> Top Performing Country</b>: The US was the dominant market by a significant margin, generating $13.3M in sales, which accounts for 47% of total sales across 2019-2022. It's also more than 6x the next highest country (GB at $2.1M).
- <b> Smallest Performing Region</b>: LATAM was the smallest region by sales but showed proportional growth during 2020 which was consistent with other regions. It suggests that baseline demand exists and could be further developed with region specific marketing or pricing strategies.
<img alt="top 10 countries" src="https://github.com/user-attachments/assets/f78a7bf1-b2b7-4c37-89b9-0a0e03101465" />


## Loyalty Program
![Loyalty Summary Stats](./assets/loyalty-banner.svg)
- <b> Growth</b>: Loyalty program membership grew substantially over the four-year period, from just 12% of total orders in 2019 to 52% by 2022. Member order volume grew 6.5x from 2K in 2019 to 13K in 2020.
- <b> AOV Shift</b>:In the early years (2019–2020), non-members outspent members on a per-order basis — non-member AOV peaked at $346 in 2020 compared to $228 for members, indicating the program was not yet driving higher-value purchases. By 2022, the dynamic had flipped — member AOV ($245) surpassed non-member AOV ($215) for the first time, suggesting the program began attracting or retaining higher-value customers as it matured.
- <b> Sales Composition</b>:Non-member sales dominated total sales through 2020 ($7.2M vs $3.0M for members) but member sales overtook non-members by 2021 ($4.9M vs $4.3M), marking a structural shift in where revenue was coming from.

<img alt="Loyalty Program" src="https://github.com/user-attachments/assets/d6fdee40-4737-4d21-a9c5-38b7e8061151" />


### Further Analysis
- <b> Channel Acquisition </b>: Email was the only channel where loyalty members outnumber non-members with 10.8K vs 7.7K, accounting for 60% of email acquired customers. Every other channel skews non-member. This suggests email is the strongest loyalty acquisition channel and scaling it would likely drive membership growth.
<img alt="loyalty marketing" src="https://github.com/user-attachments/assets/033694fa-0759-4f3f-989c-bbc16c363a28" />


- <b> Product Mix </b>: As the loyalty program matured, members went from accounting for roughly 10% of AirPods and Monitor sales in 2019 to over 50% in 2022. These 2 products drive the most revenue for GadgetGrid. On the other side, non-member dominated Macbook Air and Samsung Cable the entire time. This lines up with the AOV shift in 2022 where members aren't just spending more, they're increasingly buying the products that matter most to the business.
<img alt="member share" src="https://github.com/user-attachments/assets/9e293728-8a2f-422c-a628-a41b3ce2c2f4" />


- <b> Purchase Frequency </b>: Orders per customer across both groups were ~1.2, suggesting the loyalty program isn't driving meaningful repeat behavior. The program's current value appears to lie more in acquisition and spend patterns than in retention. 


## Marketing Channel Effectiveness
<img alt="marketing channel" src="https://github.com/user-attachments/assets/a36aba45-2389-468b-8463-1ab942fbe92e" />

- <b> Dominant Channel</b>: Direct was the dominant marketing channel with $23.2M in sales and accounts for 83% of total sales. However, this figure deserves a closer look - an 83% direct attribution rate is unusually high and may reflect gaps in UTM tracking rather than true direct intent. This potentially masks the real contribution of other channels
- <b> Highest AOV Channel </b>: Affiliate had the highest AOV of $347 in 2020, suggesting affiliate-driven customers tend to make higher-value purchases and are ready to buy.
- <b> Fastest Growing </b>: Email was the fastest growing channel, expanding 5.8x in order volume from 2019 to 2021. With a consistent AOV around $180 and strong volume growth, it represents the most scalable and likely cost-efficient channel.


<!-- # Recommendations
## Product
- <b> Reevaluate the Bose Soundsport</b>: With only 27 total orders and $3,339 in sales across four years, the product failed to gain meaningful traction. Given that AirPods dominated the headphone category at 48K orders, the Soundsport may be redundant in the catalog. Discontinuing or replacing it with a more competitive audio product is worth considering.
 
## Loyalty Program
- <b> Continue the Program for at Least Another Year </b>: Membership grew from 12% to 52% of total orders between 2019 and 2022, and member sales overtook non-member sales by 2021. For the first time in 2022, members outspent non-members per order. Ultimately, the trajectory is storng but one year isn't a trend yet.
- <b> Investigate the AOV Gap </b>: For three out of four years, non-members outspent members on a per order basis, which may suggest loyalty members are leveraging rewards or discount or offset the price. It's worth understanding whether members are actually spending more or just using disocunts to pay less.
- <b> Invest in Email to Drive Membership Growth </b>: Email is the only channel where members outnumber non-members, accounting for 60% of email acquired customers. If growing the loyalty program is a priority, scaling email makes the most sense. 

## Marketing Channels
- <b> Invest further in email</b>: Email was the fastest growing channel, expanding 5.8x in order volume from 2019 to 2021. It also maintained a consistent AOV around $180, making it a reliable and likely cost-efficient channel worth scaling.

## Seasonality
- <b>Double down on Q4 </b>: December is consistently the highest performing month across all four years. Targeted promotions and marketing spend should be concentrated around the holiday season to maximize the demand peak.
- <b> Address the Q1 slump </b>: February is the weakest month every year. Introducing post-holiday promotions, new year campaigns, or limited-time bundles in January and February could help soften the post holiday dip.

## Geographic Expansion
- <b> Develop LATAM and APAC further </b>: Both regions showed proportional growth during 2020 consistent with NA and EMEA. This confirms that baseline demand exists. Localized marketing, regional pricing strategies, or partnerships could help convert that into consistent revenue. 
- <b> Reduce geographic concentration risk </b>: The US accounts for 47% of total sales, meaning overall performance is heavily dependent on a single market. Diversifying revenue across top international markets like GB, CA, JP, and DE would reduce exposure to US-specific demand fluctuations. !-->

# Recommendations

| Recommendation | Area | Priority | Expected Impact |
|---|---|---|---|
| Double down on Q4 promotions | Seasonality | 🟢 High | Maximize the highest revenue window of the year. December alone hit $1.25M in 2020 |
| Invest in email to drive membership growth | Loyalty / Marketing | 🟢 High | Email is the only channel where members out-number non-members — scaling it directly grows loyalty enrollment |
| Continue the loyalty program | Loyalty | 🟢 High | Member order share grew from 12% to 52% and AOV flipped in 2022. Momentum is worth sustaining |
| Investigate the AOV gap | Loyalty | 🟡 Medium | Determines whether the program drives genuine spend or discount-driven behavior. Important for evaluating true profitability |
| Address the Q1 slump | Seasonality | 🟡 Medium | February is consistently the weakest month and targeted campaigns could recover lost revenue during the post-holiday dip |
| Develop LATAM and APAC further | Geography | 🟡 Medium | Both regions showed proportional COVID-era growth confirming demand exists — localized strategies could unlock consistent revenue |
| Reevaluate the Bose Soundsport | Product | 🟡 Medium | 27 orders and $3.3K in sales over four years. Catalog space could be better allocated to a more competitive audio product |
| Reduce geographic concentration risk | Geography | 🔴 Low | US accounts for 47% of sales — diversifying across GB, CA, JP, DE reduces single-market dependency |
| Audit direct channel attribution | Marketing | 🔴 Low | 83% direct attribution is unusually high — UTM audit could surface true channel contributions and improve budget allocation |

