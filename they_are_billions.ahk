; 1. Get screen region for buttons
; 2. Divide into (12? 3x4 grid)
; 3. Calculate center of each button
; 4. Create [functor] to click on that point on button press
ControlClick X50 Y90

; 3x5 grid
i_size := 3
j_size := 5

; Bounding corners of the 3x5 grid of buttons
; First draft: Take this from a screenshot
; Second draft: Generate this from resolution?
x_min := 1328
y_min := 959
x_max := 1629
y_max := 1130
dx := (x_max - x_min)/i_size
dy := (y_max - y_min)/j_size

indexToCoords(i, j)
{
  x := x_min + i*dx
  y := y_min + j*dx
  return [x, y]
}

ClickOnButton(i, j)
{
    x, y = indexToCoords(i, j)

    ; Click in the center of each button
    x := x + dx/2
    y := y + dy/2 

    ; Quoted x and y required to call ControlClick
    ; See https://autohotkey.com/board/topic/51382-controlclick-variables/
    ControlClick, % "x" x " y" y, WinTitle
}

; First draft: get a couple common hotkeys working at all
; Second draft: implement state machine to dive into menus

; ColonistsMenu - C
T::ClickOnButton(0, 0) ; Tent
C::ClickOnButton(0, 1) ; Cottage
; Stone H_ouse

; ResourcesMenu
H::ClickOnButton(0, 0) ; Hunter
F::ClickOnButton(0, 1) ; Fisherman
W::ClickOnButton(0, 2) ; Wood
Q::ClickOnButton(1, 0) ; Quarry
A::ClickOnButton(1, 1) ; f_A_rm

; ElectricityMenu
T::ClickOnButton(0, 0) ; Tesla tower
M::ClickOnButton(1, 0) ; Mill
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
; B::ClickOnButton( , ) ; Bank

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