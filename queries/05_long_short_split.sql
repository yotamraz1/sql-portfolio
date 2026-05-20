-- Long vs Short Performance
-- Directional bias and performance split by position type.
-- Used to monitor if the system is skewing in one direction and how each side performs.

SELECT
    positiontype,
    COUNT(*)                                                               AS trades,
    ROUND(SUM(pnl)::NUMERIC, 4)                                           AS total_pnl,
    ROUND(AVG(pnl)::NUMERIC, 4)                                           AS avg_pnl,
    ROUND(
        100.0 * SUM(CASE WHEN pnl > 0 THEN 1 ELSE 0 END) / COUNT(*), 1
    )                                                                      AS win_rate_pct
FROM closed_positions
GROUP BY positiontype
ORDER BY total_pnl DESC;
