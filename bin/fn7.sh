#!/bin/bash
 
# External output may be "VGA" or "VGA-0" or "DVI-0" or "TMDS-1"
EXTERNAL_OUTPUT="VGA-0"
INTERNAL_OUTPUT="LVDS"
EXTERNAL_LOCATION="right"
 
# Figure out which user and X11 display to work on
# TODO there has to be a better way to do this?
X_USER=tzachar
export DISPLAY=:0.0
 
# Switch to X user if necessary
if [ "$X_USER" != "$USER" ]; then
       SU="su $X_USER -c"
else
       SU="sh -c"
fi
 
case "$EXTERNAL_LOCATION" in
       left|LEFT)
               EXTERNAL_LOCATION="--left-of $INTERNAL_OUTPUT"
               ;;
       right|RIGHT)
               EXTERNAL_LOCATION="--right-of $INTERNAL_OUTPUT"
               ;;
       top|TOP|above|ABOVE)
               EXTERNAL_LOCATION="--above $INTERNAL_OUTPUT"
               ;;
       bottom|BOTTOM|below|BELOW)
               EXTERNAL_LOCATION="--below $INTERNAL_OUTPUT"
               ;;
       *)
               EXTERNAL_LOCATION="--left-of $INTERNAL_OUTPUT"
               ;;
esac
 
# Figure out current state
INTERNAL_STATE=$($SU xrandr | grep ^$INTERNAL_OUTPUT | grep con | sed "s/.*connected //" | sed "s/(.*//")
EXTERNAL_STATE=$($SU xrandr | grep ^$EXTERNAL_OUTPUT | grep con | sed "s/.*connected //" | sed "s/(.*//")
 
if [ -z "$INTERNAL_STATE" ]; then
       STATE="external"
elif [ -z "$EXTERNAL_STATE" ]; then
       STATE="internal"
else
       INTERNAL_STATE=$(echo $INTERNAL_STATE | sed "s/[0-9]*x[0-9]*//")
       EXTERNAL_STATE=$(echo $EXTERNAL_STATE | sed "s/[0-9]*x[0-9]*//")
       if [ "$INTERNAL_STATE" = "$EXTERNAL_STATE" ]; then
               STATE="mirror"
       else
               STATE="both"
       fi
fi
 
function screen_external(){
       $SU "xrandr --output $INTERNAL_OUTPUT --off"
       $SU "xrandr --output $EXTERNAL_OUTPUT --auto"
}
 
function screen_internal(){
       $SU "xrandr --output $EXTERNAL_OUTPUT --off"
       $SU "xrandr --output $INTERNAL_OUTPUT --auto"
}
 
function screen_mirror(){
       $SU "xrandr --output $INTERNAL_OUTPUT --auto"
       $SU "xrandr --output $EXTERNAL_OUTPUT --auto --same-as $INTERNAL_OUTPUT"
}
 
function screen_both(){
       $SU "xrandr --output $INTERNAL_OUTPUT --auto"
       $SU "xrandr --output $EXTERNAL_OUTPUT --auto $EXTERNAL_LOCATION"
}
 
function screen_toggle(){
       case "$STATE" in
               internal)
                       screen_mirror
                       ;;
               mirror)
                       screen_external
                       ;;
               external)
                       screen_both
                       ;;
               both)
                       screen_internal
                       ;;
               *)
                       screen_internal
                       ;;
       esac
}
 
# What should we do?
DO="$1"
if [ -z "$DO" ]; then
       if [ $(basename $0) = "fn7.sh" ]; then
               DO="toggle"
       fi
fi
 
case "$DO" in
       toggle)
               screen_toggle
               ;;
       internal)
               screen_internal
               ;;
       external)
               screen_external
               ;;
       mirror)
               screen_mirror
               ;;
       both)
               screen_both
               ;;
       status)
               echo "Current Fn-F7 state is: $STATE"
               echo
               echo "Attached monitors:"
               $SU xrandr | grep "\Wconnected" | sed "s/^/ /"
               ;;
       *)
               echo "usage: $0 <command>" >&2
               echo >&2
               echo "  commands:" >&2
               echo "          status" >&2
               echo "          internal" >&2
               echo "          external" >&2
               echo "          mirror" >&2
               echo "          both" >&2
               echo "          toggle" >&2
               echo >&2
               ;;
esac
