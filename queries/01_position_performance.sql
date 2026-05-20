-- Position Performance by Pair
-- Aggregate win rate, total PnL, and average profit per trade for each trading pair.
-- Surfaces which pairs drive the most value — used to adjust strategy limits per instrument.

SELECT
    pair_name,
    COUNT(*)                                                               AS total_trades,
    ROUND(SUM(pnl)::NUMERIC, 4)                                           AS total_pnl,
    ROUND(AVG(pnl)::NUMERIC, 4)                                           AS avg_pnl_per_trade,
    ROUND(
        100.0 * SUM(CASE WHEN pnl > 0 THEN 1 ELSE 0 END) / COUNT(*), 1
    )                                                                      AS win_rate_pct,
    ROUND(SUM(fee)::NUMERIC, 4)                                           AS total_fees
FROM closed_positions
GROUP BY pair_name
ORDER BY total_pnl DESC;
