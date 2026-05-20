-- Daily P&L Trend
-- Day-over-day performance tracking.
-- Used to catch degradation early and monitor system health over time.

SELECT
    DATE(closed_time::TIMESTAMP)                                           AS trade_date,
    COUNT(*)                                                               AS trades,
    ROUND(SUM(pnl)::NUMERIC, 4)                                           AS daily_pnl,
    ROUND(AVG(pnl)::NUMERIC, 4)                                           AS avg_trade_pnl,
    ROUND(SUM(fee)::NUMERIC, 4)                                           AS daily_fees
FROM closed_positions
GROUP BY trade_date
ORDER BY trade_date;
