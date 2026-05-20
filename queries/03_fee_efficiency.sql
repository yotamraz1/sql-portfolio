-- Fee Efficiency Ratio
-- Gross PnL relative to fees paid per pair.
-- At high trading volumes, even a small fee shift changes profitability significantly.
-- Pairs with low ratio get deprioritized in strategy configuration.

SELECT
    pair_name,
    ROUND(SUM(pnl)::NUMERIC, 4)                                           AS gross_pnl,
    ROUND(SUM(fee)::NUMERIC, 4)                                           AS total_fees,
    ROUND(
        (SUM(pnl) / NULLIF(SUM(fee), 0))::NUMERIC, 2
    )                                                                      AS pnl_to_fee_ratio
FROM closed_positions
GROUP BY pair_name
HAVING SUM(fee) > 0
ORDER BY pnl_to_fee_ratio DESC;
