# SQL Analytics Portfolio

SQL analytics focused on operational monitoring, execution analysis, fee optimization, and real-time trading workflows.

Written against a production PostgreSQL database for a live automated trading platform.

---

## My Role

My primary involvement was on the operational and analytical side — writing and running queries to monitor system behavior, identify anomalies, and support data-driven decisions in a live 24/7 production environment.

Core infrastructure and execution systems were primarily developed by my technical co-founder.

---

## Structure

```
sql-portfolio/
├── queries/
│   ├── 01_position_performance.sql      — win rate & PnL by pair
│   ├── 02_machine_execution_quality.sql — node performance & hold time
│   ├── 03_fee_efficiency.sql            — PnL-to-fee ratio per pair
│   ├── 04_hourly_distribution.sql       — trade volume by hour (UTC)
│   ├── 05_long_short_split.sql          — directional bias analysis
│   ├── 06_execution_leg_classification  — ladder depth & anomaly flagging
│   └── 07_daily_pnl_trend.sql           — day-over-day performance tracking
├── screenshots/                         — dashboard & monitoring visuals
└── notes/
    └── operational_context.md           — what these queries supported
```

---

## What the queries cover

| Query | Focus |
|---|---|
| 01 | Win rate, PnL, fees aggregated per trading pair |
| 02 | Execution node health — hold time, win rate per machine |
| 03 | Fee efficiency ratio — gross PnL vs fees at scale |
| 04 | Hourly trade distribution — peak windows identification |
| 05 | Long vs short performance split |
| 06 | Position leg depth — flags stuck ladders as risk signals |
| 07 | Daily P&L trend — early degradation detection |

---

## Skills

`GROUP BY` · `HAVING` · `CASE WHEN` · `NULLIF` · `EXTRACT EPOCH` · conditional aggregation · timestamp arithmetic · multi-metric aggregation · operational analytics
