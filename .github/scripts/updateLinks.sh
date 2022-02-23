#!/bin/sh

basePath="./KnowledgeBase/"

for path in $(find ${basePath} -type f \( -iname "*.md" ! -iname "*index*" ! -iname "*readme*" \) -print); do
  sed -i 's/\((\)\.\.\/\(.*\)/\1\.\.\/\.\.\/\2/g' ${path} # replace all instances of ../ with ../../
  sed -i`` 's/\(.*\).md/\L\1/g' ${path} # convert links to other markdown files to lowercase permalinks with .md extension removed
done
