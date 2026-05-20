-- Machine Execution Quality
-- Compare performance across execution nodes — win rate and average hold time per machine.
-- Identifies if a specific node is underperforming — triggers investigation of connectivity or config drift.

SELECT
    machine_id,
    COUNT(*)                                                               AS trades,
    ROUND(
        100.0 * SUM(CASE WHEN pnl > 0 THEN 1 ELSE 0 END) / COUNT(*), 1
    )                                                                      AS win_rate_pct,
    ROUND(AVG(EXTRACT(EPOCH FROM (
        closed_time::TIMESTAMP - open_time::TIMESTAMP
    )))::NUMERIC, 2)                                                       AS avg_hold_seconds,
    ROUND(AVG(pnl)::NUMERIC, 4)                                           AS avg_pnl
FROM closed_positions
GROUP BY machine_id
ORDER BY avg_hold_seconds ASC;
