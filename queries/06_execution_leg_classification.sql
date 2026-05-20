-- Execution Leg Classification
-- Classify positions by number of execution legs.
-- Deep ladders (5+ legs) flag positions where the system was stuck improving
-- against adverse price moves — used as a risk and anomaly signal.

SELECT
    pair_name,
    machine_id,
    open_time,
    pnl,
    trades                                                                 AS legs_count,
    CASE
        WHEN trades = 1 THEN 'clean'
        WHEN trades BETWEEN 2 AND 4 THEN 'improved'
        ELSE 'deep_ladder'
    END                                                                    AS execution_type
FROM closed_positions
ORDER BY trades DESC, pnl ASC;
