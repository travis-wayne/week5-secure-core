# Security Policy Peer Review

## Reviewer

**Reviewer:** Student B**Author:** Student A**Date:** 26 August 2026

## Policy Reviewed

**File:** `security-policy.md`

## Review Findings

### Finding 1

**Policy statement reviewed:**

> HIGH-severity static findings must block merges.

**Reviewer observation:** The policy statement is clear, but the evidence location should identify the actual GitHub Actions workflow and the failed and successful workflow runs.

**Why this matters:** A security policy must be verifiable against a technical control and evidence.

**Suggested improvement:** Add `.github/workflows/security-scan.yml` and GitHub Actions run history to the evidence location.

**Author response:** Accepted.

**Change made:** Updated `CI-01` in `security-policy.md` to reference `.github/workflows/security-scan.yml` and GitHub Actions run evidence.

### Finding 2

**Policy statement reviewed:**

> Sensitive API endpoints must apply rate limiting.

**Reviewer observation:** The policy should distinguish between the local rate-limit demonstration and rate limiting that is active in the Medusa backend.

**Why this matters:** A local HTTP 429 response proves the demonstration works, but it does not prove that the production or deployed backend uses the same control.

**Suggested improvement:** Identify the local HTTP 429 evidence and mark Medusa deployment as requiring verification.

**Author response:** Accepted.

**Change made:** Updated `AP-03` in `security-policy.md` to identify the middleware and HTTP 429 evidence, while marking backend deployment verification as required.

### Finding 3

**Policy statement reviewed:**

> User-controlled SQL values must be passed to database APIs as bound parameters.

**Reviewer observation:** The policy should state that input validation does not replace parameterized SQL queries.

**Why this matters:** A denylist or length check may limit some input but does not make string-concatenated SQL safe.

**Suggested improvement:** Keep server-side validation and SQL parameterization as separate controls in the policy.

**Author response:** Accepted.

**Change made:** Updated `AP-01` and `AP-02` in `security-policy.md` to separate server-side validation from parameterized database access.

## Evidence Reviewed

| Evidence | Review result |
| --- | --- |
| `tools/vulnerability_scanner.py` | Scanner contains the corrected EXEC001 and HIGH-severity JWT001 rules. |
| `training-fixtures/vulnerable.js` | Produces a HIGH finding and exit code `1`. |
| `training-fixtures/clean.js` | Produces no findings and exit code `0`. |
| `artifacts/medusa-scan-findings.txt` | Records the Medusa source scan. |
| `artifacts/rate-limit-evidence.txt` | Records the local HTTP 429 demonstration. |
| `.github/workflows/security-scan.yml` | Defines the automated security-scan workflow. |

## Final Review Status

- [x] Review completed

- [x] At least one specific improvement identified

- [x] Improvement applied to `security-policy.md`

- [x] Control register updated where necessary

- [x] Local scanner and fixture evidence reviewed

- [x] Deployed and planned controls are distinguished

- [x] No real secrets or credentials are included

- [x] Final policy re-checked

**Final reviewer approval:** ____________________**Approval date:** ____________________