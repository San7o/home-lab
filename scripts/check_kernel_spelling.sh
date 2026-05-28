#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# Ensure we are running from the root of the kernel source tree
if [ ! -f "Kbuild" ] || [ ! -d "kernel" ]; then
    echo "Error: Run this script from the root of the Linux kernel source tree." >&2
    exit 1
fi

# Define a local dictionary file if you want to ignore specific kernel jargon
# Otherwise, codespell uses its internal dictionaries
EXCLUDE_DIR="Documentation/devicetree/bindings" # Example of high false-positive areas

echo "========================================================"
echo " Starting Linux Kernel Spelling Audit"
echo "========================================================"

# Run codespell
# -q 2: Quiet mode (only print the warnings)
# -S: Skip paths matching these patterns
# -I: File with words to ignore
codespell -q 2 \
    -S "*.o,*.ko,*.gz,*.bz2,*.tar,*.png,*.jpg,${EXCLUDE_DIR}" \
    --ignore-words=.codespell \
    "${@:-.}" # Checks arguments passed, defaults to current directory (tree root)

echo "--------------------------------------------------------"
echo " Audit complete."
