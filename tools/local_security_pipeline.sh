#!/bin/bash

set -o pipefail

echo "========================================"
echo "      LOCAL SECURITY PIPELINE"
echo "========================================"

mkdir -p artifacts

echo ""
echo "[1/2] Running vulnerability scanner..."

python3 tools/vulnerability_scanner.py . \
  | tee artifacts/local-security-findings.txt

SCAN_EXIT_CODE=${PIPESTATUS[0]}

echo ""
echo "[2/2] Evaluating security result..."

if [ "$SCAN_EXIT_CODE" -eq 1 ]; then
    echo ""
    echo "SECURITY GATE: FAILED"
    echo "HIGH-severity finding detected."
    echo "Pipeline blocked."
    exit 1
fi

if [ "$SCAN_EXIT_CODE" -eq 0 ]; then
    echo ""
    echo "SECURITY GATE: PASSED"
    echo "No HIGH-severity finding detected."
    echo "Pipeline may proceed."
    exit 0
fi

echo ""
echo "SECURITY GATE: ERROR"
echo "Scanner returned unexpected exit code: $SCAN_EXIT_CODE"
exit "$SCAN_EXIT_CODE"