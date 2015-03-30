#!/usr/bin/wish

set wtitle "Relax"
set titlearg [lindex $argv 0]

wm title . "$wtitle"
label .prompt -text "$wtitle" -relief groove

#
set pos 0

pack  .prompt -side top -fill x -fill y

raise .
set x [winfo vrootwidth .]
set w [winfo width .]
set x [exec echo $x/2-$w/2 | bc]
set y [winfo vrootheight .]
set h [winfo height .]
set y [exec echo $y/2-$h/2 | bc]

wm geometry . 150x150+$x+$y
frame .bottom
button .bottom.ok -text "Ok" -command {exit}
pack  .bottom.ok  -side left -fill x -fill y
pack  .bottom -side top

