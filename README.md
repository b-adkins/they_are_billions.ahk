# they_are_billions.ahk
AutoHotkey configuration for They Are Billions, the famously difficult zombie indie game.

Until Numantian Games comes out with their own hotkey system, here's a third-party one for They Are Billions! (I sympathize as a developer - I know it's not trivial, especially for a custom engine!)

This is an [AutoHotKey](https://autohotkey.com/) script. AutoHotKey is an powerful and popular open-source program to modify your controls. AutoHotKey version 1.1.05+ required.

# Inspiration
Hotkeys are heavily inspired by Starcraft 1 and 2. This means that:

1) As in Starcraft 1, hotkeys come from the name of the building
2) Keys on the left-hand are preferred; thus letters can come from the middle of a word
3) They sometimes use the Starcraft building name - e.g. B (Barracks) for Soldier Center

# Setup
You need to edit the script for your screen size. (Mine is a 2048x1152 monitor.)

1. Take a screenshot of They Are Billions
2. Open your screenshot in Paint
3. Get the coordinates of the _top-left_ and _bottom-right_ pixels of the 3x5 button grid (right on the edge of the clickable area)
4. Set x_min and y_min to the top-left corner and x_max and y_max to the top-right corner

# Usage
With AutoHotKey installed, just double click on the .ahk file!

# License
GPLv3+ for everybody except Numantian Games, who can do WTF they want with this code! <3
