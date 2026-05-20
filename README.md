# SQL Analytics Portfolio — sMower HFT System

SQL queries written against the production PostgreSQL schema of **sMower LTD** — a live high-frequency trading platform processing $13M+/month on Binance and OKX.

**Schema**: `monitor_server`  
**Tables**: `orders`, `closed_positions`, `init_setting`

---

### Query 1 — Closed Position Performance by Pair

Aggregate win rate, total PnL, and average profit per trade for each trading pair.

```sql
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
```

**Why it matters**: Surfaces which pairs drive the most value — used to adjust strategy limits per instrument.

---

### Query 2 — Machine Execution Quality

Compare performance across execution machines (nodes) — hits, rejects, and average hold time.

```sql
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
```

**Why it matters**: Identifies if a specific node is underperforming — triggers investigation of connectivity or config drift.

---

### Query 3 — Fee Efficiency Ratio

Calculate gross PnL relative to fees paid — the key metric for HFT viability at scale.

```sql
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
```

**Why it matters**: At $13M/month volume, even a 0.001% fee shift changes profitability. Pairs with low ratio get deprioritized.

---

### Query 4 — Hourly Trade Distribution

Identify peak execution windows to understand market regime and resource allocation.

```sql
SELECT
    EXTRACT(HOUR FROM closed_time::TIMESTAMP AT TIME ZONE 'UTC')          AS hour_utc,
    COUNT(*)                                                               AS trade_count,
    ROUND(SUM(pnl)::NUMERIC, 4)                                           AS hourly_pnl,
    ROUND(AVG(pnl)::NUMERIC, 4)                                           AS avg_pnl
FROM closed_positions
GROUP BY hour_utc
ORDER BY hour_utc;
```

**Why it matters**: Some hours show 3x trade density — used to tune strategy aggressiveness by time window.

---

### Query 5 — Position Type Split (Long vs Short)

Measure directional bias — whether the system skews long or short and how each performs.

```sql
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
```

---

### Query 6 — Trade Legs per Position

Join `orders` to reconstruct how many execution legs each position used — used to detect over-improvement or stuck ladders.

```sql
SELECT
    cp.pair_name,
    cp.machine_id,
    cp.open_time,
    cp.pnl,
    cp.trades                                                              AS legs_count,
    CASE
        WHEN cp.trades = 1 THEN 'clean'
        WHEN cp.trades BETWEEN 2 AND 4 THEN 'improved'
        ELSE 'deep_ladder'
    END                                                                    AS execution_type
FROM closed_positions cp
ORDER BY cp.trades DESC, cp.pnl ASC;
```

**Why it matters**: Deep ladders (5+ legs) may indicate the system was stuck improving against adverse price moves — a risk signal.

---

### Query 7 — Daily P&L Trend

Track day-over-day performance to catch degradation early.

```sql
SELECT
    DATE(closed_time::TIMESTAMP)                                           AS trade_date,
    COUNT(*)                                                               AS trades,
    ROUND(SUM(pnl)::NUMERIC, 4)                                           AS daily_pnl,
    ROUND(AVG(pnl)::NUMERIC, 4)                                           AS avg_trade_pnl,
    ROUND(SUM(fee)::NUMERIC, 4)                                           AS daily_fees
FROM closed_positions
GROUP BY trade_date
ORDER BY trade_date;
```

---

## Skills Demonstrated

| Skill | Queries |
|---|---|
| Conditional aggregation (`CASE WHEN`) | Q1, Q2, Q3, Q5 |
| `HAVING` + `NULLIF` safety | Q3 |
| Timestamp arithmetic (`EXTRACT EPOCH`) | Q2, Q4, Q7 |
| Business-driven query design | All |
| Multi-metric aggregation | Q1, Q5, Q7 |
| Execution quality analysis | Q2, Q6 |

---

*Yotam Raz — [LinkedIn](https://www.linkedin.com/in/yotam-raz-a98697242/) · yotamraz306@gmail.com*
