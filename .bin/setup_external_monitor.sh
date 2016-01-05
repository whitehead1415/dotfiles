#!/usr/bin/bash
# Automatically append monitors to right of each other

export DISPLAY=:0
export XAUTHORITY=/home/whitehead/.Xauthority

# wait for xrandr output to change because xrandr takes a few seconds to update it's output
initial_xrandr_output=`xrandr`
timeout=15

until [[ $initial_xrandr_output != `xrandr` || "$timeout" == "0" ]]; do
    sleep 1
    timeout=$(($timeout - 1))
done

# Test if monitor has resolution set by using xrandr output
# example
# when it is setup xrandr looks like "HDMI1 connected 3840x2400+3840+0 (normal ..."
# this function tries to match the wxh resolution
function is_output_setup {
    output=$1
    echo `xrandr | grep ^$output | grep -Eo '[0-9]{1,4}x[0-9]{1,4}'`
}

# Set order to loop through outputs
OUTPUTS=("HDMI1" "HDMI2" "DP1")

for output in "${OUTPUTS[@]}"
do :
   is_output_connected=`xrandr | sed -n '/'^$output' connected/p'`


   if [ -n "$is_output_connected" ]; then

       if [[ -n "$(is_output_setup $output)" ]]; then
           continue
       fi

       # get fb size from first line of output in xrandr
       screen_line=`xrandr | grep Screen | awk -F ',' '{print $2}'`
       current_fb_width=`echo $screen_line | awk '/[0-9]/ {print $2}'`
       current_fb_height=`echo $screen_line | awk '/[0-9]/ {print $4}'`

       # get max resolution of output
       WxH=`xrandr | grep ^$output -A 1 | sed -n '1!p' | awk -F ' ' '{print $1}'`

       # multiply by scale factor
       width=$((`echo $WxH | awk -F 'x' '{print $1}'` * 2))
       height=$((`echo $WxH | awk -F 'x' '{print $2}'` * 2))

       new_fb_width=$(($current_fb_width + $width))

       if [ "$height" -gt "$current_fb_height" ]; then
           new_fb_height=$height
       else
           new_fb_height=$current_fb_height
       fi

       cmd="xrandr --output $output --auto --scale 2x2 --pos "$current_fb_width"x0 --fb "$new_fb_width"x"$new_fb_height
       eval $cmd
   else
       xrandr --output $output --off
   fi

done
