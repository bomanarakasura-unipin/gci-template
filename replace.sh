#!/bin/bash

echo "Replacing placeholders in files..."
find . -type f ! -path "./.git/*" | while read -r file; do
  # Check if file contains the placeholder
  if grep -q "gci-parent-name" "$file" 2>/dev/null; then
    echo "  Updating: $file"
    sed -i "s/gci-parent-name/gci-parent-name/g" "$file"
  fi
done
