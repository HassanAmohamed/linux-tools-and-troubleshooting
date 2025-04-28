# mygrep.sh - A Minimal grep Clone

A custom   script that mimics basic `grep` functionality with support for line numbers and inverted matching.

## Features

### Core Functionality
- Search for strings in text files (case-insensitive)
- Print matching lines with optional line numbers
- Invert matches to show non-matching lines

### Supported Options
| Option | Description                      |
|--------|----------------------------------|
| `-n`   | Show line numbers with matches   |
| `-v`   | Invert match (show non-matches)  |
| `--help` | Show usage information          |

## Usage

``` 
./mygrep.sh [OPTIONS] PATTERN FILENAME
Examples
Basic search:

 
./mygrep.sh hello testfile.txt
Show line numbers:

 
./mygrep.sh -n hello testfile.txt
Inverted match with line numbers:

 
./mygrep.sh -vn hello testfile.txt
Requirements
  shell

Readable text file input

Error Handling
The script validates:

Presence of both pattern and filename arguments

File existence and readability

Proper option combinations

Testing
Test file testfile.txt contents:

Hello world
This is a test
another test line
HELLO AGAIN
Don't match this line
Testing one two three
Expected test cases:

 
./mygrep.sh hello testfile.txt          # Basic match
./mygrep.sh -n hello testfile.txt       # With line numbers
./mygrep.sh -vn hello testfile.txt      # Inverted match
./mygrep.sh -v testfile.txt             # Should error (missing pattern)
Implementation Notes
Technical Highlights
Uses getopts for robust option parsing

Handles combined flags (-vn equals -v -n)

Case-insensitive matching by default

Clean error messaging

Potential Enhancements
Regex Support:

Would modify matching to use grep -P or similar

Additional Flags:

 
-i # Case sensitivity toggle
-c # Count matches only
-l # Show matching files only
Implementation Challenge:

Most complex aspect was handling inverted matches (-v) with other options while maintaining proper output formatting