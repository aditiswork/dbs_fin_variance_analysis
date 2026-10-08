# DBS Group Holdings — Quarterly Financial Variance Analysis

A SQL-based variance analysis of DBS Group Holdings' quarterly financial performance (1Q25–2Q26), built to practice FP&A-style variance tracking: quarter-over-quarter swings in income, profit, expenses, and cost-income ratio.

## Data source
All figures are transcribed directly from DBS's own quarterly CFO investor presentations (publicly available at [dbs.com/investors](https://www.dbs.com/investors)), specifically each quarter's "Highlights" and net profit bridge slides. No modeled or estimated figures — every value ties back to a stated line in DBS's own disclosures.

## What's here
- `dbs_quarterly.csv` — raw transcribed dataset (6 quarters: 1Q25–2Q26)
- `dbs_financials.db` — SQLite database built from the CSV
- `queries.sql` — variance analysis queries (QoQ % change, cost-income ratio trend, largest swing detection)

## Headline finding
**4Q25 was DBS's weakest quarter in the series**: total income fell 10.1% QoQ and net profit fell 20.2% QoQ — the sharpest swing across all 6 quarters — driven by seasonally lower fee income and a prudent downgrade of a previously watchlisted real estate exposure to NPL status. Cost-income ratio also peaked that quarter at 44%, versus a 37–40% range in every other quarter.

The business recovered sharply the following quarter: 1Q26 saw an 11.6% QoQ income rebound and 24.3% QoQ profit growth, the single largest positive swing in the dataset.

## Example query
```sql
SELECT quarter, total_income,
    total_income - LAG(total_income) OVER (ORDER BY rowid) AS qoq_variance,
    ROUND(100.0 * (total_income - LAG(total_income) OVER (ORDER BY rowid)) 
          / LAG(total_income) OVER (ORDER BY rowid), 1) AS qoq_variance_pct
FROM quarterly_financials ORDER BY rowid;
```
