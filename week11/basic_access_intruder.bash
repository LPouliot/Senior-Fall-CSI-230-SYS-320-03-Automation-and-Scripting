#!/bin/bash

# Target IP
IP="10.0.17.24"

# Creating the loop
for i in {1..20}; do
	# Curling the website
	curl "$IP"
done
