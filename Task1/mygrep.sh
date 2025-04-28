#!/bin/bash

# Default options
show_line_numbers=false
invert_match=false
search_string=""
file_path=""

# Function to print usage information
print_usage() {
  echo "Usage: $0 [options] search_string file"
  echo "Options:"
  echo "  -n    Show line numbers"
  echo "  -v    Invert match (show non-matching lines)"
  echo "  -vn or -nv  Combine -v and -n"
  echo "  --help  Show this help message"
}

# Handle command-line arguments
while getopts "nv" opt; do
  case "$opt" in
    n)
      show_line_numbers=true
      ;;
    v)
      invert_match=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      print_usage
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))

# Handle --help
if [[ "$1" == "--help" ]]; then
  print_usage
  exit 0
fi

# Check for required arguments
if [[ $# -lt 2 ]]; then
  echo "Error: Missing search string and/or file path" >&2
  print_usage
  exit 1
fi

search_string="$1"
file_path="$2"

# Check if the file exists
if [[ ! -f "$file_path" ]]; then
  echo "Error: File not found: $file_path" >&2
  exit 1
fi

# Process the file line by line
line_number=1
while IFS= read -r line; do
  found=$(echo "$line" | grep -i "$search_string")
  match=$?

  if [[ "$invert_match" == "true" ]]; then
    if [[ "$match" -ne 0 ]]; then
      if [[ "$show_line_numbers" == "true" ]]; then
        echo "$line_number:$line"
      else
        echo "$line"
      fi
    fi
  else
    if [[ "$match" -eq 0 ]]; then
      if [[ "$show_line_numbers" == "true" ]]; then
        echo "$line_number:$line"
      else
        echo "$line"
      fi
    fi
  fi
  ((line_number++))
done < "$file_path"

exit 0
