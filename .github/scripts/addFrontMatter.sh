#!/bin/sh

basePath="./KnowledgeBase/"
startEnd="---"
#tab="    "

echo "[DEBUG] Adding front matter to all markdown files in ${basePath}..."

find ${basePath} -type f \( -iname "*.md" ! -iname "*index*" ! -iname "*readme*" \) -print | while IFS= read -r path; do
  echo "[DEBUG] Adding front matter to ${path}..."
  subject=$(dirname "${path}") # generate a category from the parent directory of the file
  # subjectLower=$(dirname "${path}" | awk -F "/" '{print tolower($NF)}') # generate a category from the parent directory of the file - in lowercase
  title=$(basename -s .md "${path}") # generate a title from the file name
  titleLower=$(echo "${title}" | awk '{print tolower($0)}') # set the title to lowercase
  titleSpaces=$(echo "${title}" | tr "-" " " ) # replace hyphens with spaces
  excerpt=$(sed -n 3p "${path}") # get the first non-title line of the file
  # Remove special chracters from excerpt
  excerpt=$(echo "${excerpt}" | sed -e 's/[^a-zA-Z0-9 ]//g')
  frontMatter="${startEnd}\npermalink: /knowledge/${titleLower}/\nsubject: ${subject}\ntitle: ${titleSpaces}\nexcerpt: "${excerpt}"\n${startEnd}" # build Liquid Front Matter - builds multiline string
  echo "[DEBUG] Front matter: ${frontMatter}"
  # Removed the subject from the front matter as the path on my website does not include the subject and all posts as from /knowledge
  #frontMatter="${startEnd}\npermalink: /knowledge/${subjectLower}/${titleLower}/\nsubject: ${subject}\ntitle: ${titleSpaces}\nexcerpt: "${excerpt}"\n${startEnd}" # build Liquid Front Matter - builds multiline string
  sed -i "1i ${frontMatter}" "${path}" # prepend the front matter to the head of the file
  # Add new line after end of file
  echo "" >> "${path}"
  # Append breadcrumbs include to the end of the file on a new line and adding a new line to the end of the file
  echo "{% include breadcrumbs2.html %}" >> "${path}"
  echo "[DEBUG] Front matter added to ${path}."
done

echo "[DEBUG] Front matter added to all markdown files in ${basePath}."
