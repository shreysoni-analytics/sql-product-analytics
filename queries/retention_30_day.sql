-- 30-day user retention by signup cohort

WITH signup_cohorts AS (
  SELECT
    user_id,
    DATE_TRUNC('month', signup_date) AS cohort_month
  FROM users
),

activity AS (
  SELECT DISTINCT
    user_id,
    DATE(event_time) AS active_date
  FROM events
)

SELECT
  cohort_month,
  COUNT(DISTINCT s.user_id) AS cohort_size,
  COUNT(DISTINCT a.user_id) AS retained_users_30d,
  ROUND(
    COUNT(DISTINCT a.user_id) * 1.0 / COUNT(DISTINCT s.user_id),
    3
  ) AS retention_rate_30d
FROM signup_cohorts s
LEFT JOIN activity a
  ON s.user_id = a.user_id
 AND a.active_date BETWEEN s.cohort_month
                         AND s.cohort_month + INTERVAL '30 day'
GROUP BY 1
ORDER BY 1;
