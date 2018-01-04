#!/bin/env sh

# Quick autogeneration script so I don't have to write the hotkey reference manually
#
# Well, I have to do these parts manually
# 1) Remove unimplemented sections
# 2) Insert the text explaining the grid layout:
#       Too much repetition, I went with a grid layout instead

OUTFILE=hotkey_reference.md

echo "# Hotkey Reference" > $OUTFILE
echo "## General" >> $OUTFILE
echo "- __B__ - build menu (same as clicking command center button or pressing enter)" >> $OUTFILE
echo "- __ESC__ - return to build menu. This is your panic button!" >> $OUTFILE

# grep matches a) menu titles and b) hotkey lines
# sed 1) trims down to just the commented text
#     2) substitutes Markdown level-two header (```##```) for the comment character
grep "ClickOnButton.*; .*[A-Z]*$\|^ *;.*Menu" they_are_billions.ahk | sed -e 's/^.*ClickOnButton.*; /- /' -e 's/Menu/ Menu/' -e 's/^;/## /' >> $OUTFILE

# Emphasizes the captial character that is the hotkey
sed -i -e 's!\([A-Z]\)! __\1__ !' $OUTFILE

# @todo Find some way for this to not effect the menu headers but still include them, something like:
# sed -i -e '/##/d;s!\([A-Z]\)!__\1__!' $OUTFILE

