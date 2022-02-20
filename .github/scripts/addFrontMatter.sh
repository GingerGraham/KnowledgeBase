#!/bin/sh

basePath="./KnowledgeBase/"
startEnd="---"
tab="    "

for path in $(find ${basePath} -type f \( -iname "*.md" ! -iname "*index*" ! -iname "*readme*" \) -print); do
  subject=$(dirname ${path}) # generate a category from the parent directory of the file
  subjectLower=$(dirname ${path} | awk -F "/" '{print tolower($NF)}') # generate a category from the parent directory of the file - in lowercase
  title=$(basename -s .md ${path}) # generate a title from the file name
  titleLower=$(echo ${title} | awk '{print tolower($0)}') # set the title to lowercase
  titleSpaces=$(echo ${title} | tr "-" " " ) # replace hyphens with spaces
  frontMatter="${startEnd}\npermalink: /${subjectLower}/${titleLower}/\nsubject: ${subject}\ntitle: ${titleSpaces}\n${startEnd}" # build Liquid Front Matter - builds multiline string
  sed -i "1i ${frontMatter}" ${path} # prepend the front matter to the head of the file
done
