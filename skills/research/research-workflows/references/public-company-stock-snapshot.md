# Public Company / Stock Snapshot Workflow

Use this when the user asks for a quick portfolio lens on a publicly traded company.

## Evidence pattern

1. Confirm the intended ticker/company, especially when names are ambiguous (for example, "Marvel" may mean Marvell Technology `MRVL`; Marvel Entertainment itself is owned by Disney).
2. Pull a current/recent market quote from a finance endpoint or other source and include the retrieval date/time when available.
3. Pull primary financials from SEC Company Facts when the company is a U.S. filer:
   - Discover CIK from `https://www.sec.gov/files/company_tickers.json` when needed.
   - Use `https://data.sec.gov/api/xbrl/companyfacts/CIK##########.json` with a real User-Agent.
   - Prefer `frame` values for period-specific quarterly facts where possible; beware duplicate rows for the same period due to amendments or comparative re-filings.
4. Compute only simple ratios that are grounded in retrieved data: P/E, dividend yield, revenue growth, market cap from price × diluted shares, price/sales, net debt.
5. Present the portfolio role first, then quality, cyclicality/defensiveness, valuation, risks, and sizing.

## Portfolio framing template

- **Role:** core compounder, defensive consumer, cyclical industrial, speculative growth/AI, income, etc.
- **Business quality:** moat, balance sheet, recurring revenue or membership model, execution history.
- **Valuation:** state whether it is obviously cheap, fair, expensive, or expectations-heavy; avoid precision beyond the data.
- **Risks:** business-cycle, customer concentration, margins, rates, policy, commodity/input costs, or hype/expectations.
- **Sizing:** core positions can be larger; cyclical or high-valuation growth names should usually be satellite positions unless the user explicitly wants concentration.

## Pitfalls

- Do not treat a single boom/bust year as normalized earnings for cyclicals; discuss mid-cycle earnings.
- Do not make buy/sell commands. Use "how I’d frame it" / "not personal financial advice" language.
- Avoid claiming exact real-time market data if the source only provides a last close or delayed quote.
- If the quote endpoint fails, use an alternate source before falling back to older fundamentals only.