-- Daily Active Users (DAU)
SELECT
  DATE(event_time) AS event_date,
  COUNT(DISTINCT user_id) AS dau
FROM events
GROUP BY 1
ORDER BY 1;

-- Weekly Active Users (WAU)
SELECT
  DATE_TRUNC('week', event_time) AS week_start,
  COUNT(DISTINCT user_id) AS wau
FROM events
GROUP BY 1
ORDER BY 1;
