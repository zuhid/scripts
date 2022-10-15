#!/bin/bash

file=database/YesNo.csv
datalist=()

while IFS=, read -ra fields; do
  # printf "%s\n" "${fields[@]}"
  # for ((i = 0; i < ${#fields[@]}; i++)); do
  #   echo "${fields[i]}"
  # done
  # echo "${fields[@]}"
  echo ${fields[@]}
  datalist+=($fields)
done <"$file"

# echo "${#datalist[@]}" # get length
for ((i = 0; i < ${#datalist[@]}; i++)); do
  echo "${datalist[i]}"
done

# echo "$datalist"

# while IFS=, read -r Id Updated Text Active SortOrder; do
#   # do something... Don't forget to skip the header line!
#   echo "$Id $Updated $Text $Active $SortOrder"
# done <database/YesNo.csv

# arr_csv=()
# while read line; do
#     arr_csv+=("$line")
# done <database/YesNo.csv

# index=0
# for record in "${arr_csv[@]}"; do
#   echo "one = $record"
#     # echo "Record at index-${index} : $record"
#   ((index++))
# done

# value=$(<database/YesNo.csv)
# echo "$value"

# read -r firstline <database/YesNo.csv
# echo "firstline = $firstline"

# while IFS="," read -r rec_column1 rec_column2 rec_column3 rec_column4; do
#   # while read line; do
#    echo "Record is : $rec_column1"
#    echo "Record is : $rec_column2"
#    echo "Record is : $rec_column3"
#    echo "Record is : $rec_column4"
# done < <(tail -n +2 database/YesNo.csv)
