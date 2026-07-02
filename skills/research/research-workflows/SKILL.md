---
name: research-workflows
description: "Use when doing research and knowledge gathering: arXiv discovery, literature/paper writing, blog/RSS monitoring, LLM wiki knowledge bases, market data, and evidence-backed synthesis."
version: 1.0.0
author: Hermes Agent
license: MIT
metadata:
  hermes:
    tags: [research, arxiv, literature, papers, rss, knowledge-base, polymarket]
    related_skills: [mlops-model-workflows]
---

# Research Workflows

## Overview
This umbrella covers research tasks as a class: finding papers, writing/reviewing ML papers, monitoring blogs/RSS feeds, building/querying knowledge bases, collecting market data, and producing grounded syntheses.

Archived predecessor packages remain recoverable with references/scripts intact: `arxiv`, `blogwatcher`, `llm-wiki`, `polymarket`, and `research-paper-writing`.

## When to Use
- The user asks for academic paper discovery, summaries, or related work.
- The user asks to draft, revise, or evaluate an ML research paper.
- The user asks to monitor blogs/RSS/Atom feeds.
- The user asks to build/query a markdown knowledge base such as Karpathy's LLM Wiki.
- The user asks for Polymarket markets, prices, orderbooks, or historical data.

## Shared Workflow
1. Define the research question and required evidence standard.
2. Search authoritative sources first; collect URLs/IDs and timestamps.
3. Extract primary content before synthesizing; do not summarize from snippets alone when detail matters.
4. Separate facts, interpretation, and uncertainty.
5. Return citations/links and any generated files or datasets.

## Paper Discovery and Writing
- Use arXiv search by keyword/author/category/ID; include paper IDs and dates.
- For paper writing, preserve contribution claims, experimental evidence, and reviewer expectations.
- Avoid fabricating citations; every citation must trace to a source.

## Monitoring and Knowledge Bases
- Blog/RSS monitoring should be quiet when nothing changed and explicit when errors occur.
- Knowledge-base work should preserve source links and stable filenames.

## Market/Forecasting Data
- For Polymarket, distinguish market metadata, current prices, order books, and historical data.
- Include retrieval time because markets move.

## Public Company / Stock Snapshots
- For quick stock-portfolio questions, use `references/public-company-stock-snapshot.md`.
- Confirm ambiguous company names/tickers, retrieve current or recent quote data, ground fundamentals in primary filings when possible, and frame the answer by portfolio role, valuation, risks, and sizing rather than a simplistic buy/sell call.

## E-commerce / Product Variant Checks
When asked whether a pictured product is available in other colors, sizes, regions, or variants:
1. Identify the exact product and model from the screenshot/photo first (OCR visible title/model; use vision if needed).
2. Verify the exact model on the manufacturer/brand page before relying on marketplace search results.
3. Inspect variant selectors and product metadata for the exact model (e.g. Color, Style, Model). Treat related search results as separate products unless they share the same model/SKU.
4. Cross-check a major retailer page when available, but distinguish exact-model listings from adjacent product lines that advertise “other colors/patterns.”
5. Answer with the exact model, observed variant(s), source type(s) checked, and any caveat about related models.

## Local School Calendar / Date Checks
When asked about school dates (first day, breaks, open house, staggered starts):
1. Do not assume the school district from the user's metro area or prior nearby searches; verify the exact district/school from memory, the user's wording, or a direct clarification if necessary.
2. Prefer the official district website and its PDF/calendar resource over search snippets or third-party calendars.
3. For “this year,” check the live current date/year and choose the relevant school year before answering.
4. If the district has exceptions (kindergarten staggered start, early college, modified year-round, school-specific calendars), include the exception only when relevant and label it clearly.
5. Keep the answer short first, then offer to check a specific school if needed.
6. See `references/school-calendar-date-checks.md` for source patterns and local examples.

## Common Pitfalls
When asked for a school start date, first day of school, open house, break date, or similar calendar fact:
1. Infer the likely district/school from context only when obvious, but state the assumption in the final answer.
2. Prefer the official district/school calendar page over general search results; if Google/search is blocked or noisy, navigate directly to the district site and use its site search/navigation.
3. Expand accordion sections for the relevant academic year and inspect linked PDFs, not just the visible page text.
4. For PDF calendars, use browser/vision/OCR when text extraction is unavailable; visually verify the date label on the calendar itself.
5. Check whether special calendars exist for early colleges, middle colleges, magnet programs, or non-traditional schools, and mention exceptions briefly.
6. Keep the user-facing answer short: lead with the date, then list any important exceptions and the source assumption.

## Common Pitfalls
1. Treating search result snippets as sources.
2. Mixing outdated and current market data without timestamps.
3. Producing literature reviews without citations.
4. Overwriting a knowledge base without preserving provenance.
5. For product color/variant questions, conflating marketplace “other colors/patterns” for adjacent models with true variants of the exact model shown.

## Verification Checklist
- [ ] Research question and scope stated.
- [ ] Primary sources extracted or queried.
- [ ] Citations/URLs/IDs included.
- [ ] Uncertainty and timestamps included where relevant.
- [ ] Generated files/datasets verified.
- [ ] For product variant checks, exact model/SKU was verified against manufacturer or authoritative retailer data.
