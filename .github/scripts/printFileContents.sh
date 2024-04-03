#!/bin/bash

# Directory containing the markdown files
dir="./KnowledgeBase/"

echo "[DEBUG] Generating output for all markdown files in $dir"

# Find all markdown files in the directory and its subdirectories
find $dir -name "*.md" | while read -r file; do
  echo "[DEBUG] Found markdown file: $file"
  echo "Printing contents of $file"
  cat "$file"
done

echo "[DEBUG] Done generating output for all markdown files in $dir"