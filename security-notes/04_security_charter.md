# Day 5 - Security Working Rules (Charter)

## Objective
Define simple and clear rules for testing, documenting, and proving security work.

## Rules
1. All offensive tests must be performed **only inside the lab environment**.
2. Every test must be documented with:
   - the command used,
   - the result observed.
3. Screenshots must be captured as proof for important steps.
4. All configurations and security rules must be versioned with Git.
5. False positives must be explicitly noted and explained.
6. Sensitive data (passwords, tokens, secrets) must **not** be stored in the repository.
7. Logs must be preserved for investigation and later analysis.

## Evidence Policy
Each action must produce evidence:
- Command used
- Output result
- Screenshot (when relevant)

Evidence storage path:
- `/evidence/phase1/`
- `/evidence/phase2/`
- `/evidence/phase3/`

Supporting folders:
- `/evidence/screenshots/`
- `/evidence/logs/`

## Daily Checklist
- [ ] Test performed
- [ ] Result recorded
- [ ] Screenshot taken
- [ ] Commit pushed
- [ ] Sync with teammate

## Team Alignment (Binôme)
Message to teammate (Youssef):

> We will follow the same rules: every test is documented, every important action has evidence, and we keep one shared workflow.

## Conclusion
This charter ensures:
- Reproducibility
- Traceability
- Professional workflow
