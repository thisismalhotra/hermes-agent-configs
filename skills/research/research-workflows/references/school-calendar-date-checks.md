# School Calendar Date Checks

Use this reference for quick school-date lookups such as first day of school, open house dates, breaks, and staggered starts.

## Workflow
1. Identify the exact district/school before searching. Do not infer from nearby metro areas; families may attend a different district across a state line.
2. Use the official district website first. Prefer pages named `Calendar`, `Academic Calendar`, `Back to School`, or official PDF resources hosted by the district/Finalsite/BoardDocs.
3. For “this year,” map the current date to the relevant school year (e.g. July 2026 → 2026–2027 school year).
4. Inspect PDFs visually if text extraction is unavailable; key labels often include “First day for students,” “First day of school,” “Teacher workday,” or “Modified Year-Round Calendar.”
5. Include exceptions succinctly: kindergarten staggered start, early colleges, modified calendars, school-specific calendars.
6. Answer with the date first, then the source context.

## Local example: Fort Mill School District, SC
Official source pattern:
- District calendar page: `https://www.fortmillschools.org/calendar`
- Calendar PDFs may redirect via `/fs/resource-manager/view/...` to `resources.finalsite.net/...pdf`.

Observed 2026–2027 official PDF title:
- `Approved 26-27 Calendar Revised 4-1-26 - Updated 5-7-26`

Key answer from the 2026–2027 calendar:
- First day of school for Fort Mill students: **Monday, August 3, 2026**.
- Kindergarten staggered start:
  - Jan–Mar birthdays: Monday, Aug 3
  - Apr–Jun: Tuesday, Aug 4
  - Jul–Sep: Wednesday, Aug 5
  - Oct–Dec: Thursday, Aug 6
  - All kindergarten students attend Friday, Aug 7

## Pitfall captured
A nearby-district answer can be wrong even if geographically plausible. In this session, Charlotte-Mecklenburg Schools was checked first, but the user's children attend Fort Mill School District in South Carolina. Always verify district before finalizing school-date answers.