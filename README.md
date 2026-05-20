# Operational Analytics Portfolio — SQL

SQL analytics focused on real-time operational monitoring, execution validation, anomaly analysis, fee optimization, and workflow performance tracking.

Written against a production database for a live automated trading platform running 24/7 across multiple exchanges.

---

## My Role

My involvement focused on operational analytics, monitoring workflows, execution validation, and production-oriented data analysis within a real-time trading environment.

Core infrastructure architecture and execution systems were primarily developed by my technical co-founder.

---

## Focus Areas

- **Execution monitoring** — tracking fill quality, win rates, and anomalies per instrument and per machine
- **Fee optimization** — identifying which instruments had favorable fee-to-profit ratios at scale
- **Machine performance** — detecting node-level degradation before it compounds
- **Operational KPIs** — daily P&L trends, hourly distribution, directional bias
- **Anomaly flagging** — classifying execution depth to surface stuck or abnormal workflows

---

## Queries

```
queries/
├── 01_position_performance.sql      — win rate & PnL aggregated by pair
├── 02_machine_execution_quality.sql — node performance, hold time, win rate
├── 03_fee_efficiency.sql            — gross PnL vs fees — viability at scale
├── 04_hourly_distribution.sql       — peak execution windows identification
├── 05_long_short_split.sql          — directional bias & performance by side
├── 06_execution_leg_classification  — ladder depth, stuck position detection
└── 07_daily_pnl_trend.sql           — day-over-day degradation tracking
```

---

## Operational Context

These queries were part of day-to-day work on a live production system. They supported decisions like:

- Adjusting strategy limits per instrument based on PnL-to-fee ratio
- Investigating specific machines showing higher-than-expected hold times
- Identifying hours where execution quality dropped and tuning accordingly
- Catching daily performance degradation before it became a significant loss

See `notes/operational_context.md` for full context.

---

## Technologies

- **SQL / PostgreSQL** — primary analytics language
- **Python** — pandas, Plotly for downstream visualization
- **Linux / AWS** — environment where queries ran against live data
- **Excel** — operational reporting and KPI dashboards

---

## Skills

`GROUP BY` · `HAVING` · `CASE WHEN` · `NULLIF` · `EXTRACT EPOCH` · conditional aggregation · timestamp arithmetic · multi-metric aggregation · business-driven query design
