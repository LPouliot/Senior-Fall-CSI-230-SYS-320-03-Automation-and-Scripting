#! /bin/bash

# Grabbing  table data using xmlstarlet
echo ""
# position()>1 helps with  getting all of the rows except the first one, since the first one is the HTML header
xmlstarlet sel -H -t -m "//table/tr[position()>1]" \
 -v "td[1]" -o "| " \
 -v "td[2]" -o " |" \
 -v "td[3]" -n Assignment.html
echo ""


