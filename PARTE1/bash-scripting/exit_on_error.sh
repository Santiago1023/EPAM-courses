#!/bin/bash

# exit_on_error.sh
set -e

echo "Check non-existing file"
cat non-existing-file.txt 
echo "moving on"