# Security Policy

This policy applies to the e-commerce backend, its API, data stores, source code, and CI/CD pipeline.

## 1. Data at Rest

- Do not commit passwords, API keys, JWT secrets, private keys, or database credentials to Git.

- Load secrets through environment variables or an approved secret manager.

- Use authenticated database and Redis connections with the minimum required permissions.

- Do not write passwords, tokens, or sensitive customer data to application logs.

## 2. Data in Transit

- Use HTTPS for deployed public traffic.

- Keep PostgreSQL and Redis on private application networks.

- Do not place passwords, tokens, or other secrets in URLs or publicly accessible logs.

## 3. Access Control and API Protection

- Use a strong, environment-based JWT secret and configure token expiry.

- Verify the expected JWT algorithm and use verified JWT claims for authorization decisions.

- Do not trust user-controlled identity or role fields from request bodies.

- Validate all user-controlled input on the server.

- Use parameterized database queries for all user-controlled values. Input validation does not replace SQL parameterization.

- Apply rate limiting to sensitive endpoints. A rate limiter reduces repeated abuse but does not prevent SQL injection.

- The vulnerability scanner is an early-warning control. It does not replace testing, code review, or manual security analysis.

## 4. Incident Response

The following events must be reported and investigated:

- A real secret, password, token, or private key is exposed.

- Repeated authentication failures or suspicious probing exceed the defined threshold.

- Unexpected administrative activity or privilege changes occur.

- A HIGH-severity scanner finding reaches the CI pipeline.

Response actions include preserving evidence, rotating or revoking affected credentials, investigating possible misuse, fixing the underlying issue, and notifying the system owner.

## 5. Acceptable Use

- Test only systems that you own or are explicitly authorized to test.

- Keep security testing inside the approved local lab, repository, or training branch.

- Use fake secrets and synthetic data in vulnerable fixtures.

- Never deploy intentionally vulnerable training fixtures.

- Never place real credentials in source files, screenshots, prompts, logs, or repositories.

## Control Register

| ID | Control | Evidence | Status |
| --- | --- | --- | --- |
| SEC-01 | Secrets are loaded from environment variables or secret management. | Configuration and repository review | Planned / verify |
| SEC-02 | JWTs use managed secrets, expiry, and verified claims. | Authentication source and tests | Planned / verify |
| SEC-03 | API input is validated and SQL queries are parameterized. | Route source and tests | Demonstrated locally; verify in the backend |
| SEC-04 | Sensitive endpoints use rate limiting. | Middleware and HTTP 429 test | Demonstrated locally; verify in the backend |
| SEC-05 | HIGH scanner findings fail the CI security job. | `.github/workflows/security-scan.yml` and Actions run | Planned until pushed and verified |
| SEC-06 | Security testing uses authorized systems and synthetic data. | Lab instructions and training fixtures | Active for this project |

A passing scanner or workflow means only that the configured checks found no reported HIGH issue. It does not prove that the application is completely secure.