#!/bin/bash

# Directory containing the markdown files
dir="./KnowledgeBase/"

echo "[INFO] Generating output for all markdown files in $dir"

# Find all markdown files in the directory and its subdirectories
find $dir -name "*.md" | while read -r file; do
  echo "[INFO] Found markdown file: $file"
  echo "Printing contents of $file"
  cat "$file"
done

echo "[INFO] Done generating output for all markdown files in $dir"