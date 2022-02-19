#!/bin/sh

basePath="./KnowledgeBase/"
startEnd="---"
tab="    "

echo ${pwd}

for path in $(find ${basePath} -type f \( -iname "*.md" ! -iname "*index*" ! -iname "*readme*" \) -print); do
  subject=$(dirname ${path} | awk -F "/" '{print tolower $NF}') # generate a category from the parent directory of the file - in lowercase
  title=$(basename -s .md ${path} | awk '{print tolower $0}') # generate a permalink from the file name - in lowercase
  titleSpaces=${title//-/ } # replace hyphens with spaces
  frontMatter="${startEnd}\npermalink: /${subject}/${title}/\nsubject: ${subject}\ntitle: ${titleSpaces}\n${startEnd}" # build Liquid Front Matter - builds multiline string
  sed -i "1i ${frontMatter}" ${path} # prepend the front matter to the head of the file
done
