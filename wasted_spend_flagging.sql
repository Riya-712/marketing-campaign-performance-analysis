-- Wasted spend list 

WITH channel_stats AS (
  SELECT
    traffic_source.source AS source,
    traffic_source.medium AS medium,
    COUNT(DISTINCT user_pseudo_id) AS users,
    COUNTIF(event_name = 'purchase') AS purchases,
    ROUND(SAFE_DIVIDE(COUNTIF(event_name = 'purchase'), COUNT(DISTINCT user_pseudo_id)) * 100, 2) AS conversion_rate_pct
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
  GROUP BY source, medium
  HAVING COUNT(DISTINCT user_pseudo_id) >= 10   -- exclude noise/near-zero segments
),
medians AS (
  SELECT
    APPROX_QUANTILES(users, 2)[OFFSET(1)] AS median_users,
    APPROX_QUANTILES(conversion_rate_pct, 2)[OFFSET(1)] AS median_conversion
  FROM channel_stats
)
SELECT
  c.source,
  c.medium,
  c.users,
  c.purchases,
  c.conversion_rate_pct,
  m.median_users,
  m.median_conversion,
  CASE
    WHEN c.users >= m.median_users AND c.conversion_rate_pct < m.median_conversion
      THEN 'FLAG: High traffic, low conversion'
    ELSE 'OK'
  END AS wasted_spend_flag
FROM channel_stats c
CROSS JOIN medians m
ORDER BY c.users DESC