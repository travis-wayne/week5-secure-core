# Vulnerability Scanner Review

## AI-Generated First Draft

The first AI-generated scanner was tested against the Week 5 vulnerable training fixture.

### What the Scanner Detected

The scanner detected:

- A hardcoded secret-like value
- Request input without visible validation
- SQL query construction using request input

### Review Finding 1: Missing Detection Rule

**Test file:**  
`training-fixtures/missed.js`

**Pattern tested:**  
Request-derived input passed to `exec()`.

**Expected behavior:**  
The scanner should identify dangerous use of `exec` or `eval` near request-derived input.

**Actual behavior:**  
[Write what your scanner actually returned.]

**Conclusion:**  
The AI-generated scanner does not currently detect this pattern.

### Review Finding 2: Static Analysis Limitation

**Issue:**  
The scanner relies on static patterns and nearby code.

**Why this matters:**  
A validation function may exist in another file or middleware layer and not be visible to the scanner.

**Conclusion:**  
A scanner finding is a warning that requires human review. A clean scan does not prove that the application is secure.

## Improvements Planned

1. Add an EXEC001 rule for dangerous `exec` or `eval` usage near request-derived input.
2. Add another detection rule not present in the original AI draft.