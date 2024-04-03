#!/bin/bash

basePath="./KnowledgeBase/"

echo "[INFO] Converting all links to lowercase permalinks in all markdown files in ${basePath}..."

find ${basePath} -type f \( -iname "*.md" ! -iname "*index*" ! -iname "*readme*" \) -print | while IFS= read -r path; do
  echo "[INFO] Converting all links to lowercase permalinks in ${path}..."
  sed -i`` 's/\(.*\).md/\L\1/g' ${path} # convert links to other markdown files to lowercase permalinks with .md extension removed
  echo "[INFO] All links converted to lowercase permalinks in ${path}."
done

echo "[INFO] All links converted to lowercase permalinks in all markdown files in ${basePath}."
