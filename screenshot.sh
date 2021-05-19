#!/bin/dash

dmenucmd="dmenu -i -b"
xclipcmd="xclip -selection clipboard -t image/png -i"
xdocmd="xdotool getactivewindow"

savedirectory="/home/rensenware/Pictures/Screenshots"
dateformat="date +%s"
delay=5

type1="selection" type2="full" type3="window" type4="delayed"
clip1="yes"       clip2="no"   clip3="back"

id="873728822"
group="Screenshot"
icon=/usr/share/icons/Papirus-Dark/48x48/devices/camera-photo.svg
message="Screenshot taken!"
clipmessage="Screenshot copied to clipboard!"

getclip(){ clipchoice=$(echo "$clip1\n$clip2\n$clip3" | $dmenucmd -p "Copy to clipboard?"); }

removefiller() {
    filename="$savedirectory/$(ls $savedirectory | tail -n 1)"
    filetype=$(file $filename | cut -d\  -f2)
    if [ "$filetype" = "empty" ]; then
        rm $filename
    fi
}

delayednotify() {
    i=$1
    while :; do
        dunstify -a "$group" -i "$icon" -r "$id" "Taking screenshot in $(echo $i)..."
        sleep 0.5
        if [ $i -eq 1 ]; then
            dunstctl close
        fi
        sleep 0.5
        i=$((i-1))
        if [ $i -eq 0 ]; then
            break
        fi
    done

    if [ "$clipchoice" = "$clip1" ]; then
        dunstify -a "$group" -i "$icon" -r "$id" "$clipmessage"
    else
        dunstify -a "$group" -i "$icon" -r "$id" "$message"
    fi
}

type1() {
    getclip
    case "$clipchoice" in
        "")
            exit ;;
        "$clip1")
            maim -s -u | tee $savedirectory/Screenshot-$($dateformat).png | $xclipcmd 
            removefiller
            dunstify -a "$group" -i "$icon" -r "$id" "$clipmessage" ;;
        "$clip2")
            maim -s -u $savedirectory/Screenshot-$($dateformat).png
            dunstify -a "$group" -i "$icon" -r "$id" "$message" ;;
        "$clip3")
            loop=1 ;;
    esac
}

type2() {
    getclip
    case "$clipchoice" in
        "")
            exit ;;
        "$clip1")
            maim -u | tee $savedirectory/Screenshot-$($dateformat).png | $xclipcmd 
            removefiller
            dunstify -a "$group" -i "$icon" -r "$id" "$clipmessage" ;;
        "$clip2")
            maim -u $savedirectory/Screenshot-$($dateformat).png
            dunstify -a "$group" -i "$icon" -r "$id" "$message" ;;
        "$clip3")
            loop=1 ;;
    esac
}

type3() {
    getclip
    case "$clipchoice" in
        "")
            exit ;;
        "$clip1")
            maim -i $($xdocmd) -u | tee $savedirectory/Screenshot-$($dateformat).png | $xclipcmd 
            removefiller
            dunstify -a "$group" -i "$icon" -r "$id" "$clipmessage" ;;
        "$clip2")
            maim -i $($xdocmd) -u $savedirectory/Screenshot-$($dateformat).png
            dunstify -a "$group" -i "$icon" -r "$id" "$message" ;;
        "$clip3")
            loop=1 ;;
    esac
}

type4() {
    type4loop=1

    while [ "$type4loop" -eq 1 ]
    do
        type4loop=0

        type4choice=$(echo "$type1\n$type2\n$type3\nback" | $dmenucmd -p "Delayed Screenshot")
        case "$type4choice" in
            "")
                exit ;;
            "$type1")
                getclip
                case "$clipchoice" in
                    "")
                        exit ;;
                    "$clip1")
                        geometry=$(slop)
                        delayednotify 5 &
                        maim -g $geometry -u -d $delay | tee $savedirectory/Screenshot-$($dateformat).png | $xclipcmd
                        removefiller ;;
                    "$clip2")
                        geometry=$(slop)
                        delayednotify 5 &
                        maim -g $geometry -u -d $delay $savedirectory/Screenshot-$($dateformat).png ;;
                    "$clip3")
                        type4loop=1 ;;
                esac
            ;;
            "$type2")
                getclip
                case "$clipchoice" in
                    "")
                        exit ;;
                    "$clip1")
                        delayednotify 5 &
                        maim -u -d $delay | tee $savedirectory/Screenshot-$($dateformat).png | $xclipcmd
                        removefiller ;;
                    "$clip2")
                        delayednotify 5 &
                        maim -u -d $delay $savedirectory/Screenshot-$($dateformat).png ;;
                    "$clip3")
                        type4loop=1 ;;
                esac
            ;;
            "$type3")
                getclip
                case "$clipchoice" in
                    "")
                        exit ;;
                    "$clip1")
                        delayednotify 5 &
                        maim -i $($xdocmd) -u -d $delay | tee $savedirectory/Screenshot-$($dateformat).png | $xclipcmd
                        removefiller ;;
                    "$clip2")
                        delayednotify 5 &
                        maim -i $($xdocmd) -u -d $delay $savedirectory/Screenshot-$($dateformat).png ;;
                    "$clip3")
                        type4loop=1 ;;
                esac
            ;;
            "back")
                loop=1 ;;
        esac
    done
}

loop=1

while [ "$loop" -eq 1 ]
do
    loop=0
    typechoice=$(echo "$type1\n$type2\n$type3\n$type4" | $dmenucmd -p "Screenshot")
    case "$typechoice" in
        "")
            exit ;;
        "$type1")
            type1 ;;
        "$type2")
            type2 ;;
        "$type3")
            type3 ;;
        "$type4")
            type4 ;;
    esac
done
