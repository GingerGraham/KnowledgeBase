#!/bin/sh

basePath="./KnowledgeBase/"
startEnd="---"
collection="collection: knowledge"
tab="    "

echo ${pwd}

for path in $(find ${basePath} -type f \( -iname "*.md" ! -iname "*index*" ! -iname "*readme*" \) -print); do
  category=$(dirname ${path} | awk -F "/" '{print $NF}') # generate a category from the parent directory of the file
  frontMatter="${startEnd}\n${collection}\ncategories:\n${tab}- ${category}\n${startEnd}" # build Liquid Front Matter - builds multiline string
  sed -i "1i ${frontMatter}" ${path} # prepend the front matter to the head of the file
done
