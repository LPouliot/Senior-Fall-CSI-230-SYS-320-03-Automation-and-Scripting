#! /bin/bash

# Grabbing  table data using xmlstarlet
echo ""
xmlstarlet sel -H -t -m "//table/tr[position()>1]" \
 -v "td[1]" -o "| " \
 -v "td[2]" -o " |" \
 -v "td[3]" -n Assignment.html
echo ""


