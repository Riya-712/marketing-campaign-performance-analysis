SELECT * FROM bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131 LIMIT 10

-- event date range
SELECT MIN(event_date) AS first_day, MAX(event_date) AS last_day, COUNT(DISTINCT event_date) AS days
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

-- Channel/traffic source performance

SELECT
  traffic_source.source AS source,
  traffic_source.medium AS medium,
  COUNT(DISTINCT user_pseudo_id) AS users,
  COUNTIF(event_name = 'purchase') AS purchases,
  ROUND(SAFE_DIVIDE(COUNTIF(event_name = 'purchase'), COUNT(DISTINCT user_pseudo_id)) * 100, 2) AS conversion_rate_pct
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
GROUP BY source, medium
ORDER BY users DESC