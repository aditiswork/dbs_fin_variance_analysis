-- DBS Group Holdings: Quarterly Variance Analysis (1Q25-2Q26)
-- Data source: DBS CFO Presentations, quarterly investor relations decks

-- 1. QoQ variance in total income, net profit, and expenses
SELECT 
    quarter,
    total_income,
    total_income - LAG(total_income) OVER (ORDER BY rowid) AS qoq_income_variance,
    ROUND(100.0 * (total_income - LAG(total_income) OVER (ORDER BY rowid)) 
          / LAG(total_income) OVER (ORDER BY rowid), 1) AS qoq_income_variance_pct,
    net_profit,
    net_profit - LAG(net_profit) OVER (ORDER BY rowid) AS qoq_profit_variance,
    ROUND(100.0 * (net_profit - LAG(net_profit) OVER (ORDER BY rowid)) 
          / LAG(net_profit) OVER (ORDER BY rowid), 1) AS qoq_profit_variance_pct
FROM quarterly_financials
ORDER BY rowid;

-- 2. Cost-income ratio trend and expense variance
SELECT 
    quarter,
    expenses,
    cost_income_ratio,
    expenses - LAG(expenses) OVER (ORDER BY rowid) AS qoq_expense_variance,
    cost_income_ratio - LAG(cost_income_ratio) OVER (ORDER BY rowid) AS cir_variance_pts
FROM quarterly_financials
ORDER BY rowid;

-- 3. Wealth management segment income variance (the fastest-growing line)
SELECT 
    quarter,
    wealth_income,
    wealth_income - LAG(wealth_income) OVER (ORDER BY rowid) AS qoq_wealth_variance,
    ROUND(100.0 * (wealth_income - LAG(wealth_income) OVER (ORDER BY rowid)) 
          / LAG(wealth_income) OVER (ORDER BY rowid), 1) AS qoq_wealth_variance_pct
FROM quarterly_financials
ORDER BY rowid;

-- 4. Flag the single largest swing quarter, by income variance
SELECT 
    quarter,
    total_income - LAG(total_income) OVER (ORDER BY rowid) AS qoq_variance
FROM quarterly_financials
ORDER BY ABS(qoq_variance) DESC
LIMIT 1;
