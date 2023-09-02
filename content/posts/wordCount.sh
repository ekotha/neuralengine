#!/bin/bash

# Define the folder containing the markdown files - in case you forget type in bash wordCount.sh to test
folder="."

# Define the output file for storing the results
output_file="./wordCounts.txt"

# Exclude this file from the word count
exclude_file="_index.md"

# Get the list of markdown files in the folder
while IFS= read -d '' -r file; do
  # Exclude YAML front matter from the word count
  count=$(sed '/^---/,/^---/d' "$file" | wc -w | awk '{print $1}')
  
  # Add the word count to the total count
  total_count=$((total_count + count))
  
  # Write the file name and word count to the output file
  echo "$(basename "$file"): $count" >> "$output_file"
done < <(find "$folder" -type f -name "*.md" -not -name "$exclude_file" -print0)

# Write the total word count to the output file
echo "Total word count: $total_count" >> "$output_file"


