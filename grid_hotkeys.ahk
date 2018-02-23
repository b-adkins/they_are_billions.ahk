; Until Numantian Games comes out with their own hotkey system, here's 
; a third-party one for They Are Billions.
;
; (I sympathize as a developer - I know it's not trivial, especially for a 
; custom engine!)
;  
; Copyright Boone Adkins 2018
; Licensed under GPL v3+
; Special license for Numantian Games/developers of They Are Billions: WTFPL


; 5x3 grid of buttons
i_size := 5
j_size := 3

; Bounding corners of the grid of buttons
; First draft: manually get from a screenshot
; Second draft: autogenerate from resolution?
global x_min := 883
global y_min := 637
global x_max := 1087
global y_max := 755
global dx := (x_max - x_min)/i_size
global dy := (y_max - y_min)/j_size

indexToCoords(i, j)
{
   x := x_min + i*dx
   y := y_min + j*dy
   return [x, y]
}

; Make clicks relative
; Assumes game is running fullscreen
CoordMode, ToolTip, Screen


; Variables for menu state machine
; Keeps track of which menu is open based on what keys have been hit
global active_menu = "menu"
global allowed_menus = ["none", "colonists", "resources", "electricity", "industry", "military", "defense", "soldiers", "engineering"]


ClickOnButton(i, j)
{
    pt := indexToCoords(i, j)
    x_ := pt[1]
    y_ := pt[2]
    
    ; Click in the center of each button
    x := x_ + dx/2
    y := y_ + dy/2

    
    ; Trying different approaches to get a mouseclick
    
    ; ControlClick doesn't seem to move the mouse cursor in They Are Billions
    ; ControlClick is called with a string of the form "x200 y400"
    ;ControlClick, x%x% y%y%, A
    
    
    ; Techniques that move user's mouse
    MouseGetPos, mX, mY  ; Save old position   

    ; Click, Left, 1335, 960
    Click, Left, %x%, %y% ; Doesn't work with Expressions?
       
    ; 
    ; MouseMove 1335, 960  ; Don't want to grab user's mouse cursor anyway
    ; MouseMove, x, y  ; Doesn't work with Expressions?
    ; Click
    
    MouseMove, %mX%, %mY%, 0  ; Return cursor to old position
}

q::ClickOnButton(0, 0) ; Q - 
w::ClickOnButton(1, 0) ; W - 
e::ClickOnButton(2, 0) ; E -
r::ClickOnButton(3, 0) ; R - 
t::ClickOnButton(4, 0) ; T -
y::ClickOnButton(5, 0) ; Y - 
a::ClickOnButton(0, 1) ; A - 
s::ClickOnButton(1, 1) ; S - 
d::ClickOnButton(2, 1) ; D -
f::ClickOnButton(3, 1) ; F - 
g::ClickOnButton(4, 1) ; G - 
z::ClickOnButton(0, 2) ; Z - 
x::ClickOnButton(1, 2) ; X - 
c::ClickOnButton(2, 2) ; C -
v::ClickOnButton(3, 2) ; V -
b::ClickOnButton(4, 2) ; B -

