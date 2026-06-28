# GitHub Projects v2 — Roadmap/Epic Creation Pattern

Use when a user asks to create an epic/roadmap item on a GitHub Projects v2 board.

## Proven workflow

1. Verify repo and auth before side effects:
   - `git status --short && git branch --show-current`
   - `gh auth status`
   - `gh repo view --json nameWithOwner,url`
2. Inspect existing conventions:
   - `gh issue list --repo OWNER/REPO --search "[Epic]" --limit 20 --state all --json number,title,labels,state,url`
   - `gh label list --repo OWNER/REPO --limit 100 --json name,description,color`
3. Inspect project metadata:
   - `gh project view PROJECT_NUMBER --owner OWNER --format json`
   - `gh project field-list PROJECT_NUMBER --owner OWNER --format json`
4. For iteration fields, `gh project field-list` may not include iteration IDs. Query GraphQL:

```bash
gh api graphql \
  -f query='query($owner:String!,$number:Int!){ user(login:$owner){ projectV2(number:$number){ id title fields(first:30){ nodes{ ... on ProjectV2IterationField { id name configuration { iterations { id title startDate duration } completedIterations { id title startDate duration } } } ... on ProjectV2SingleSelectField { id name options { id name } } ... on ProjectV2Field { id name dataType } } } } } }' \
  -f owner=OWNER -F number=PROJECT_NUMBER
```

5. Create the issue with a durable body file, not a fragile shell heredoc:
   - `write_file('/tmp/epic.md', body)`
   - `gh issue create --repo OWNER/REPO --title "[Epic] ..." --body-file /tmp/epic.md --label ...`
6. Add the issue to the project:
   - `gh project item-add PROJECT_NUMBER --owner OWNER --url ISSUE_URL --format json`
   - Capture the returned `item.id`.
7. Populate project fields with `gh project item-edit`:

```bash
gh project item-edit --id ITEM_ID --project-id PROJECT_ID --field-id STATUS_FIELD_ID --single-select-option-id READY_OPTION_ID
gh project item-edit --id ITEM_ID --project-id PROJECT_ID --field-id AREA_FIELD_ID --single-select-option-id AREA_OPTION_ID
gh project item-edit --id ITEM_ID --project-id PROJECT_ID --field-id PRIORITY_FIELD_ID --single-select-option-id PRIORITY_OPTION_ID
gh project item-edit --id ITEM_ID --project-id PROJECT_ID --field-id ITERATION_FIELD_ID --iteration-id ITERATION_ID
gh project item-edit --id ITEM_ID --project-id PROJECT_ID --field-id SIZE_FIELD_ID --single-select-option-id SIZE_OPTION_ID
gh project item-edit --id ITEM_ID --project-id PROJECT_ID --field-id OWNER_TEXT_FIELD_ID --text 'owner-login-or-name'
gh project item-edit --id ITEM_ID --project-id PROJECT_ID --field-id TARGET_DATE_FIELD_ID --date 'YYYY-MM-DD'
```

8. Verify both the issue and project fields:
   - `gh issue view ISSUE_NUMBER --repo OWNER/REPO --json number,title,state,labels,url,projectItems`
   - GraphQL item field-values query to confirm Status, Area, Priority, Iteration, Size, Owner, Target Date.

## Pitfalls

- Projects v2 field values require internal field IDs and option IDs, not display names.
- Iteration IDs are only visible via GraphQL field configuration.
- Project board required fields may include custom text/date fields (`Owner`, `Target Date`) that labels alone do not satisfy.
- Repo labels and project fields are distinct; set both when the team uses both.
- If the user asks for “next sprint,” compute/use the active or next iteration from the project configuration rather than guessing a date range.
