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
global x_min := 1325
global y_min := 955
global x_max := 1630
global y_max := 1132
global dx := (x_max - x_min)/i_size
global dy := (y_max - y_min)/j_size

indexToCoords(i, j)
{
   x := x_min + i*dx
   y := y_min + j*dy
   return [x, y]
}

; Apparently, this speeds things up?
SetControlDelay -1

; Make clicks relative
; Assumes game is running fullscreen
CoordMode, ToolTip, Screen


; Variables for menu state machine
; Keeps track of which menu is open based on what keys have been hit
global active_menu = "menu"
global allowed_menus = ["none", "colonists", "resources", "electricity", "industry", "military", "defense", "soldiers", "engineering"]


; Menu is optional
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


; Since the top-level menus already have hotkeys in-game, I just have to update
; the state machine.
;
; This is meant to be a pass-through - it notes that the menu key has been hit, 
; then passes the keypress to the game.
;
; At the moment, I don't have it implemented that way, thus this function that 
; might seem a bit redundant.
RegisterOpenedMenu(menu)
{
  if(active_menu = "none")
  {
    active_menu := menu
  }
}

;
; Town hall menu
;
b::Enter  ; b for build, like in Starcraft

; A "back" button - returns to higher level menus
$Tab::
    ClickOnButton(4, 0)
    active_menu := "none"   
return

;
; ColonistsMenu
;
#If active_menu = "none"
$c::
    RegisterOpenedMenu("colonists")
    Send c
return

#If active_menu = "colonists"
t::ClickOnButton(0, 0) ; Tent
c::ClickOnButton(1, 0) ; Cottage
h::ClickOnButton(2, 0) ; stone House

;
; ResourcesMenu
;
#If active_menu = "none"
$r::
    RegisterOpenedMenu("resources")
    Send r
return

#If active_menu = "resources"
h::ClickOnButton(0, 0) ; Hunter
f::ClickOnButton(1, 0) ; Fisherman
w::ClickOnButton(2, 0) ; Wood
q::ClickOnButton(0, 1) ; Quarry
a::ClickOnButton(1, 1) ; f_A_rm

;
; ElectricityMenu
;
#If active_menu = "none"
$e::
    RegisterOpenedMenu("electricity")
    Send e
return

#If active_menu = "electricity"
t::ClickOnButton(0, 0) ; Tesla tower
w::ClickOnButton(0, 1) ; (Wind)mill
; a::ClickOnButton( , )  ; Advanced mill  ; Why would you?
; p::ClickOnButton( , )  ; Power plant  ; Don't use too often

;
; IndustryMenu
;
#If active_menu = "none"
$i::
    RegisterOpenedMenu("industry")
    Send i
return

#If active_menu = "industry"
w::ClickOnButton(0, 0) ; Warehouse
; d::ClickOnButton( , ) ; woo_D workshop
; s::ClickOnButton( , ) ; Stone workshop
f::ClickOnButton(2, 1) ; Foundry
m::ClickOnButton(0, 2) ; Market
a::ClickOnButton(1, 2) ; bAnk

;
; MilitaryMenu
;
#If active_menu = "none"
$m::
    RegisterOpenedMenu("military")
    Send m
return

#If active_menu = "military"
b::ClickOnButton(0, 0) ; Barracks (solider's center)
g::ClickOnButton(0, 1) ; Great ballista
; x::ClickOnButton(, ) ; eXecutor
s::ClickOnButton(1, 1) ; Shock
; f::ClickOnButton(, ) ; Factory (engineering center)

;
; DefenseMenu
;
#If active_menu = "none"
$d::
    RegisterOpenedMenu("defense")
    ; Send d
    ; Looks like the devs never implemented the key
    ClickOnButton(2, 1)
return

; Too much repetition, I went with a grid layout instead
#If active_menu = "defense"
q::ClickOnButton(0, 0) ; Wooden wall
w::ClickOnButton(1, 0) ; Wooden tower
e::ClickOnButton(2, 0) ; Wooden gate
a::ClickOnButton(0, 1) ; Stone wall
s::ClickOnButton(1, 1) ; Stone tower
d::ClickOnButton(2, 1) ; Stone gate
; e::ClickOnButton( , ) ; Spikes
; d::ClickOnButton( , ) ; Barbed wire

; Moved rotate to context-sensitive "r"
$r::Tab


;
; SoldiersCenter - 5. I like to bind my low-tech production to 5 and high tech to 6
;
; R::ClickOnButton() ; Ranger
; E::ClickOnButton() ; marinE (soldier)
; G::ClickOnButton() ; Ghost (sniper)

;
; EngineeringCenter - 6
;
; Y::ClickOnButton() ; pYro (lucifer)
; T::ClickOnButton() ; Thanatos
; G::ClickOnButton() ; Goliath (titan)