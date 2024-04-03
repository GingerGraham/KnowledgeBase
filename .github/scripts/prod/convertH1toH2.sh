#!/bin/bash

basePath="./KnowledgeBase/"

echo "[INFO] Converting all H1 to H2 in all markdown files in ${basePath}..."

for path in $(find ${basePath} -type f \( -iname "*.md" ! -iname "*index*" ! -iname "*readme*" \) -print); do
  echo "[INFO] Converting all H1 to H2 in ${path}..."
  sed -i 's/\(^#\)\(\s\)/\#\#\2/g' "${path}" # Replace all instances of # with ## - this converts all H1 to H2
  echo "[INFO] All H1 converted to H2 in ${path}."
done

echo "[INFO] All H1 converted to H2 in all markdown files in ${basePath}."