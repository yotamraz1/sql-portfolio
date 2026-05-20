-- Hourly Trade Distribution
-- Trade count and PnL broken down by hour (UTC).
-- Used to identify peak execution windows and tune strategy aggressiveness by time window.

SELECT
    EXTRACT(HOUR FROM closed_time::TIMESTAMP AT TIME ZONE 'UTC')          AS hour_utc,
    COUNT(*)                                                               AS trade_count,
    ROUND(SUM(pnl)::NUMERIC, 4)                                           AS hourly_pnl,
    ROUND(AVG(pnl)::NUMERIC, 4)                                           AS avg_pnl
FROM closed_positions
GROUP BY hour_utc
ORDER BY hour_utc;
