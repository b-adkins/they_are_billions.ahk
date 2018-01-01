; 1. Get screen region for buttons
; 2. Divide into (12? 3x4 grid)
; 3. Calculate center of each button
; 4. Create [functor] to click on that point on button press

; 5x3 grid of buttons
i_size := 5
j_size := 3

; Bounding corners of the grid of buttons
; First draft: Take this from a screenshot
; Second draft: Generate this from resolution?
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
global active_menu = "colonists"
global allowed_menus = ["none", "colonists", "resources", "electricity", "industry", "military", "defense", "soldiers", "engineering"]


; Menu is optional
ClickOnButton(i, j, menu)
{
    if(menu != "any" and menu != active_menu)
      return

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


; Since the top-level menus already have hotkeys in-game, I just have to update the state machine
RegisterOpenedMenu(menu)
{
  if(active_menu = "none")
  {
    active_menu := menu
  }
}

; b for build, like in Starcraft
b::Enter
Tab::
    ClickOnButton(4, 0, "any")
    active_menu := "none"
return

; ColonistsMenu
$c::
    RegisterOpenedMenu("colonists")
    Send c
return
e::ClickOnButton(0, 0, "colonists") ; tEnt
t::ClickOnButton(1, 0, "colonists") ; coTtage
; Stone H_ouse

; ResourcesMenu - R
h::ClickOnButton(0, 0, "resources") ; Hunter
f::ClickOnButton(1, 0, "resources") ; Fisherman
w::ClickOnButton(2, 0, "resources") ; Wood
q::ClickOnButton(0, 1, "resources") ; Quarry
a::ClickOnButton(1, 1, "resources") ; f_A_rm

; ElectricityMenu - E
y::ClickOnButton(0, 0, "electricity") ; Tesla tower (pYlon)
m::ClickOnButton(1, 0, "electricity") ; Mill
; A::ClickOnButton( , )  ; Advanced mill
; P::ClickOnButton( , )  ; Power plant

; IndustryMenu - I
; D::ClickOnButton( , ) ; woo_D workshop
; S::ClickOnButton( , ) ; Stone workshop
; F::ClickOnButton( , ) ; Foundry
; W::ClickOnButton( , ) ; wareHouse
; M::ClickOnButton( , ) ; Market
; A::ClickOnButton( , ) ; bAnk

; MilitaryMenu - M
; G::ClickOnButton(, ) ; Great ballista
; X::ClickOnButton(, ) ; eXecutor
; S::ClickOnButton(, ) ; Shock
; B::ClickOnButton(, ) ; Barracks (solider's center)
; F::ClickOnButton(, ) ; Factory (engineering center)

; DefenseMenu - D
; So much repetition, I went with a grid layout instead
; Q::ClickOnButton( , ) ; Wooden wall
; A::ClickOnButton( , ) ; Wooden tower
; Z::ClickOnButton( , ) ; Wooden gate
; W::ClickOnButton( , ) ; Stone wall
; S::ClickOnButton( , ) ; Stone tower
; X::ClickOnButton( , ) ; Stone gate
; E::ClickOnButton( , ) ; Spikes
; D::ClickOnButton( , ) ; Barbed wire

; SoldiersCenter - 5. I like to bind my low-tech production to 5 and high tech to 6
; R::ClickOnButton() ; Ranger
; E::ClickOnButton() ; marinE (soldier)
; G::ClickOnButton() ; Ghost (sniper)

; EngineeringCenter - 6
; Y::ClickOnButton() ; pYro (lucifer)
; T::ClickOnButton() ; Thanatos
; G::ClickOnButton() ; Goliath (titan)