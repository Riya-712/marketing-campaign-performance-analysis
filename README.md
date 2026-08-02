# Marketing Channel & Funnel Performance Analysis

Analysis of marketing channel effectiveness and on-site conversion funnel behavior 
using real Google Merchandise Store e-commerce data (GA4, via BigQuery public dataset).

## Problem
Identify which marketing channels are efficient vs. wasting spend, and where users 
drop off in the purchase funnel.

## Approach
- Queried 92 days of GA4 event data in BigQuery SQL across 11 traffic channels
- Built a wasted-spend flagging system using median-threshold logic (SQL window functions)
- Analyzed the full purchase funnel (view → cart → checkout → purchase)
- Visualized findings in an interactive Looker Studio dashboard

## Key Finding
Google's largest traffic channel (organic search) converts below average (1.41% vs. 1.71%), 
while paid search (cpc) converts at just 1.07% — the lowest of all channels despite being 
a paid channel. Two channels, representing 150K+ combined users, were flagged as 
high-traffic/low-conversion.

## Recommendation
Reallocate paid search budget toward better-converting channels (organic, merchandise-store 
referral); investigate an 84.8% cart-abandonment rate and ~85% checkout-abandonment rate 
as top UX priorities.

## Links
- 📊 [Live Looker Studio Dashboard](https://datastudio.google.com/reporting/c2bd700c-d2fc-485a-9970-092c882ea036)
- 📄 [Full Analysis Report](./Marketing_Channel_Funnel_Analysis_Report.pdf)
- 🗂️ SQL queries: `channel_performance.sql`, `funnel_analysis.sql`, `wasted_spend_flagging.sql`

## Tools
BigQuery SQL, Looker Studio
