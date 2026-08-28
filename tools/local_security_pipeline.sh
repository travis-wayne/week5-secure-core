#!/usr/bin/env bash

set -uo pipefail

TARGET="${1:-.}"

echo "========================================"
echo "       LOCAL SECURITY PIPELINE"
echo "========================================"
echo
echo "Target: $TARGET"
echo

echo "[1/2] Running vulnerability scanner..."
echo

python3 tools/vulnerability_scanner.py "$TARGET"

SCAN_EXIT=$?

echo
echo "[2/2] Evaluating security result..."
echo

if [ "$SCAN_EXIT" -eq 1 ]; then
    echo "SECURITY GATE: FAILED"
    echo "A HIGH-severity finding was detected."
    exit 1
elif [ "$SCAN_EXIT" -eq 0 ]; then
    echo "SECURITY GATE: PASSED"
    echo "No HIGH-severity finding was detected."
    exit 0
else
    echo "SECURITY GATE: ERROR"
    echo "The scanner did not complete normally."
    exit 2
fi