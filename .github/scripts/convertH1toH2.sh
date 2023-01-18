#!/bin/sh

basePath="./KnowledgeBase/"

for path in $(find ${basePath} -type f \( -iname "*.md" ! -iname "*index*" ! -iname "*readme*" \) -print); do
  # Replace all instances of # with ## - this converts all H1 to H2
  sed -i 's/\(^#\)\(\s\)/\#\#\2/g' ${path}
done