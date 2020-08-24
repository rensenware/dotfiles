#!/bin/sh

cal | rofi -dmenu -theme-str "mainbox { children: [listview]; }" -location 5 -yoffset -29 -width 14 -lines 8 -font "Iosevka Extended 13" -kb-row-down "" -kb-row-up ""
