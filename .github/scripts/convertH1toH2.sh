#!/bin/sh

basePath="./KnowledgeBase/"

echo "[DEBUG] Converting all H1 to H2 in all markdown files in ${basePath}..."

find ${basePath} -type f \( -iname "*.md" ! -iname "*index*" ! -iname "*readme*" \) -exec sh -c '
  path="$1"
  echo "[DEBUG] Converting all H1 to H2 in ${path}..."
  # Replace all instances of # with ## - this converts all H1 to H2
  sed -i 's/\(^#\)\(\s\)/\#\#\2/g' "${path}"
  echo "[DEBUG] All H1 converted to H2 in ${path}."
' sh {} \;
  echo "[DEBUG] Converting all H1 to H2 in ${path}..."
  # Replace all instances of # with ## - this converts all H1 to H2
  sed -i 's/\(^#\)\(\s\)/\#\#\2/g' "${path}"
  echo "[DEBUG] All H1 converted to H2 in ${path}."
done

echo "[DEBUG] All H1 converted to H2 in all markdown files in ${basePath}."