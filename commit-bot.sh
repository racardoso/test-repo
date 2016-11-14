#!/bin/sh

# Lets made some dummy commits

# strinf on file that will be replaced
first="int a = 10;"

replace=(
  "int a = 20;" 
  "int a = 15;" 
  "int a = 30;" 
  "int a = 20;" 
  "int a = 13;" 
  "int a = 45;" 
  "int a = 42;" 
  "int a = 23;" 
  "int b = 12;" # now we introduces a error
  "a - b" 
  "a \* b" 
  "a - b" 
)

old=$first

file="test.cpp"

count=0

for i in "${replace[@]}";
do
  sed -i -e "s/$old/$i/g" "$file"
  old=$i
  git commit -a -m "Replaced: $old with $i"
  count=$((count + 1))
  if [ $count == 9 ]; then
    old="a + b"
    echo $i
  fi
  
done

echo -e "Done: ${#replace[@]} commits are made! git log --oneline to check\n"
exit 0
