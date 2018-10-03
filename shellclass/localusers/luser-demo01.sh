#!/bin/bash

# Hello from the main OS.

# Display 'Hello'
echo 'Hello'

# Assign a value to a variable
WORD='script'

echo "$WORD"

echo '$WORD'

echo "This is a shell $WORD"

echo "This is a shell ${WORD}"

echo "${WORD}ing is fun!"

echo "$WORDing is fun!"

ENDING='ed'

echo "Tis is ${WORD}${ENDING}."

ENDING='ing'
echo "${WORD}${ENDING} is fun!"

ENDING='s'
echo "You are going to write may ${WORD}${ENDING} in this class!"
