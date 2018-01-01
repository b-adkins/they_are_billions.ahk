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

; Make clicks relative
; Assume game is running fullscreen
CoordMode, ToolTip, Screen

; First draft: get a couple common hotkeys working at all
; Second draft: implement state machine to dive into menus

; B for build, like in Starcraft
b::Enter
Tab::ClickOnButton(4, 0)

; ColonistsMenu - C
e::ClickOnButton(0, 0) ; tEnt
t::ClickOnButton(1, 0) ; coTtage
; Stone H_ouse

; ResourcesMenu
h::ClickOnButton(0, 0) ; Hunter
f::ClickOnButton(1, 0) ; Fisherman
w::ClickOnButton(2, 0) ; Wood
q::ClickOnButton(0, 1) ; Quarry
a::ClickOnButton(1, 1) ; f_A_rm

; ElectricityMenu
y::ClickOnButton(0, 0) ; Tesla tower (pYlon)
m::ClickOnButton(1, 0) ; Mill
; A::ClickOnButton( , )  ; Advanced mill
; P::ClickOnButton( , )  ; Power plant

; MilitaryMenu
; G::ClickOnButton(, ) ; Great ballista
; X::ClickOnButton(, ) ; eXecutor
; S::ClickOnButton(, ) ; Shock
; B::ClickOnButton(, ) ; Barracks (solider's center)
; F::ClickOnButton(, ) ; Factory (engineering center)

; IndustryMenu
; D::ClickOnButton( , ) ; woo_D workshop
; S::ClickOnButton( , ) ; Stone workshop
; F::ClickOnButton( , ) ; Foundry
; W::ClickOnButton( , ) ; wareHouse
; M::ClickOnButton( , ) ; Market
; A::ClickOnButton( , ) ; bAnk

; DefenseMenu
; So much repetition, I went with a grid layout instead
; Q::ClickOnButton( , ) ; Wooden wall
; A::ClickOnButton( , ) ; Wooden tower
; Z::ClickOnButton( , ) ; Wooden gate
; W::ClickOnButton( , ) ; Stone wall
; S::ClickOnButton( , ) ; Stone tower
; X::ClickOnButton( , ) ; Stone gate
; E::ClickOnButton( , ) ; Spikes
; D::ClickOnButton( , ) ; Barbed wire

; SoldiersCenter
; R::ClickOnButton() ; Ranger
; E::ClickOnButton() ; marinE (soldier)
; G::ClickOnButton() ; Ghost (sniper)

; EngineeringCenter
; Y::ClickOnButton() ; pYro (lucifer)
; T::ClickOnButton() ; Thanatos
; G::ClickOnButton() ; Goliath (titan)