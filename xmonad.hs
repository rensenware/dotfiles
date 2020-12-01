-- Imports
import XMonad hiding ( (|||) )
import System.Exit (exitWith, ExitCode(ExitSuccess) )
import Data.Map as M
import Data.Maybe (maybeToList)
import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W
import Control.Monad ((>=>), join, liftM, when)

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops as H
import XMonad.Hooks.ManageHelpers

import XMonad.Util.SpawnOnce
import XMonad.Util.Cursor
import XMonad.Util.Run (spawnPipe, hPutStrLn)

import XMonad.Actions.UpdatePointer
import XMonad.Actions.CycleWS
import XMonad.Actions.SwapWorkspaces
import XMonad.Actions.Navigation2D
import qualified XMonad.Actions.FlexibleManipulate as Flex

import XMonad.Layout.ResizableTile
import XMonad.Layout.NoBorders
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.TwoPanePersistent
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Renamed
import XMonad.Layout.Grid
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Fullscreen

-- Keybinds
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

-- Basic applications
  [ ((modm, xK_Return), spawn $ XMonad.terminal conf)
  , ((modm, xK_a ), spawn "j4-dmenu-desktop --dmenu \'dmenu -i -x 265 -z 895 -p Run\'")
  , ((modm .|. shiftMask, xK_a ), spawn "dmenu_run -i")
  , ((modm .|. controlMask, xK_a), spawn "/home/rensenware/.config/scripts/dmenuconfig.sh")
  , ((0, xK_Print), spawn "/home/rensenware/.config/scripts/dmenuscreenshot.sh")

-- Session controls
  , ((modm .|. controlMask .|. shiftMask, xK_Delete), io (exitWith ExitSuccess))   
  , ((modm .|. shiftMask, xK_End), spawn "xmonad --recompile; xmonad --restart")
  , ((modm, xK_Delete), spawn "poweroff")
  , ((modm .|. shiftMask, xK_Delete), spawn "reboot")
  , ((modm, xK_End), spawn "betterlockscreen --lock")

-- Program launchers
  , ((modm .|. controlMask .|. shiftMask, xK_b), spawn "firefox")
  , ((modm .|. controlMask .|. shiftMask, xK_d), spawn "lightcord")
  , ((modm .|. controlMask .|. shiftMask, xK_s), spawn "spotify --force-device-scale-factor=1.32")
  , ((modm .|. controlMask .|. shiftMask, xK_f), spawn "pcmanfm")
  , ((modm .|. controlMask .|. shiftMask, xK_l), spawn "libreoffice --writer")
  , ((modm .|. controlMask .|. shiftMask, xK_p), spawn "pinta")
  , ((modm .|. controlMask .|. shiftMask, xK_t), spawn "deluge-gtk")
  , ((modm .|. controlMask .|. shiftMask, xK_x), spawn "ksysguard")

-- Thinkpad special keys
  , ((0, xF86XK_Tools), spawn "/home/rensenware/.config/scripts/dwmtouchpad.sh")
  , ((0, xF86XK_Bluetooth), spawn "/home/rensenware/.config/scripts/dwmbluetooth.sh")
  , ((0, xF86XK_WLAN), spawn "/home/rensenware/.config/scripts/dwmwlan.sh")
  , ((0, xF86XK_Display), spawn "/home/rensenware/.config/scripts/dmenudisplay.sh none")
  , ((modm, xF86XK_Display), spawn "/home/rensenware/.config/scripts/screentoggle.sh")
  , ((modm .|. shiftMask, xF86XK_Display), spawn "arandr")

-- Spotify controls
  , ((modm, xK_Up), spawn "playerctl -p spotify play-pause")
  , ((modm, xK_Down), spawn "playerctl -p spotify play-pause")
  , ((modm, xK_Right), spawn "playerctl -p spotify next")
  , ((modm, xK_Left), spawn "playerctl -p spotify previous")

-- Kill focused window
  , ((modm, xK_q ), kill)

-- Toggle floating
  , ((modm, xK_space ), withFocused $ windows . W.sink)

-- "Fullscreening"
  , ((modm, xK_d), sendMessage ToggleStruts)

-- Layouts
  , ((modm, xK_i), sendMessage $ JumpToLayout "[⊢]")
  , ((modm, xK_o), sendMessage $ JumpToLayout "[•]")
  , ((modm, xK_p), sendMessage $ JumpToLayout "[ ]")
  , ((modm .|. shiftMask, xK_o), sendMessage $ JumpToLayout "[|]")
  , ((modm .|. shiftMask, xK_i), sendMessage $ JumpToLayout "[⊤]")
  , ((modm .|. controlMask, xK_i), sendMessage $ JumpToLayout "[#]")
  , ((modm .|. controlMask, xK_o), sendMessage $ JumpToLayout "[@]")

-- Focusing
  , ((modm, xK_j), windows W.focusDown)
  , ((modm, xK_k), windows W.focusUp)
  , ((modm, xK_h), windows W.focusMaster)

-- Stack control
  , ((modm .|. shiftMask, xK_j), windows W.swapDown)
  , ((modm .|. shiftMask, xK_k), windows W.swapUp)
  , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)
  
-- Positional navigation
  , ((modm, xK_m), windowGo D False)
  , ((modm, xK_comma), windowGo U False)
  , ((modm, xK_period), windowGo R False)
  , ((modm, xK_n), windowGo L False)

-- Resizing
  , ((modm, xK_t), sendMessage Shrink)
  , ((modm, xK_y), sendMessage Expand)
  , ((modm .|. shiftMask, xK_t), sendMessage MirrorShrink)
  , ((modm .|. shiftMask, xK_y), sendMessage MirrorExpand)

-- Increase number of windows in master area
  , ((modm, xK_minus), sendMessage (IncMasterN (-1)))
  , ((modm, xK_equal), sendMessage (IncMasterN 1))

-- Audio controls
  , ((0, xF86XK_AudioMute), spawn "/home/rensenware/.config/scripts/volume.sh --toggle")
  , ((0, xF86XK_AudioLowerVolume), spawn "/home/rensenware/.config/scripts/volume.sh --down")
  , ((0, xF86XK_AudioRaiseVolume), spawn "/home/rensenware/.config/scripts/volume.sh --up")
  , ((0, xF86XK_AudioMicMute), spawn "/home/rensenware/.config/scripts/volume.sh --mictoggle")
  , ((modm, xF86XK_AudioLowerVolume), spawn "/home/rensenware/.config/scripts/volume.sh --micdown")
  , ((modm, xF86XK_AudioRaiseVolume), spawn "/home/rensenware/.config/scripts/volume.sh --micup")

-- Brightness controls
  , ((0, xF86XK_MonBrightnessUp), spawn "/home/rensenware/.config/scripts/changebrightness.sh up")
  , ((0, xF86XK_MonBrightnessDown), spawn "/home/rensenware/.config/scripts/changebrightness.sh down")
-- Workspace switching
  , ((modm, xK_Tab), nextWS)
  , ((modm, xK_grave), prevWS)
  ]
  ++
  [((m .|. modm, k), windows $ f i)
    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
  ++
  [((mod1Mask, k), windows $ swapWithCurrent i)
    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]]

-- Mouse keys
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
  [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                     >> windows W.shiftMaster))
  , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
  , ((modm, button3), (\w -> focus w >> Flex.mouseWindow Flex.resize w
                                     >> windows W.shiftMaster))
  ]

-- Autostart
myStartupHook = do
  spawnOnce "echo 0 > /tmp/.windowmanager"
  spawnOnce "xrandr --output eDP1 --mode 1920x1080 --output HDMI2 --off"
  spawnOnce "pacmd set-card-profile alsa_card.pci-0000_00_1f.3 output:analog-stereo+input:analog-stereo"
  spawnOnce "picom --config /home/rensenware/.config/picom/config --experimental-backends &"
  spawnOnce "/home/rensenware/.fehbg &"
  spawnOnce "dunst &"
  spawnOnce "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &"
  spawnOnce "kglobalaccel5 &"
  spawnOnce "xset r rate 300 50 &"

-- Layouts
myLayoutHook = avoidStruts $ smartBorders $                                  (
   renamed [Replace "[⊢]"] $ ResizableTall 1 (5/100) (1/2) []          ) ||| (
   renamed [Replace "[⊤]"] $ Mirror $ ResizableTall 1 (5/100) (1/2) [] ) ||| (
   renamed [Replace "[•]"] $ fullscreenFull Full                       ) ||| (
   renamed [Replace "[|]"] $ TwoPanePersistent Nothing (5/100) (1/2)   ) ||| (
   renamed [Replace "[ ]"] $ simplestFloat                             ) ||| (
   renamed [Replace "[#]"] $ Grid                                      ) ||| (
   renamed [Replace "[@]"] $ emptyBSP                                  )

-- Window Management
myManageHook = composeAll [
  className =? "Pavucontrol" --> doFloat
  , isFullscreen --> doFullFloat ]

addNETSupported :: Atom -> X ()
addNETSupported x   = withDisplay $ \dpy -> do
    r               <- asks theRoot
    a_NET_SUPPORTED <- getAtom "_NET_SUPPORTED"
    a               <- getAtom "ATOM"
    liftIO $ do
       sup <- (join . maybeToList) <$> getWindowProperty32 dpy a_NET_SUPPORTED r
       when (fromIntegral x `notElem` sup) $
         changeProperty32 dpy r a_NET_SUPPORTED a propModeAppend [fromIntegral x]

addEWMHFullscreen :: X ()
addEWMHFullscreen   = do
    wms <- getAtom "_NET_WM_STATE"
    wfs <- getAtom "_NET_WM_STATE_FULLSCREEN"
    mapM_ addNETSupported [wms, wfs]

-- Bar
myLogHook h = dynamicLogWithPP defaultPP
  { ppCurrent           = wrap "%{F#f8f8f2}%{B#44475a} " " %{F#dedede}%{B#1e1f29}"
  , ppVisible          = wrap "" ""
  --, ppHidden           = wrap "%{F#82AAFF} " " %{F#dedede}"
  , ppHidden           = wrap "%{F#bd93f9} " " %{F#dedede}"
  , ppHiddenNoWindows  = wrap " " " "
  , ppTitle            = wrap " " "" . shorten 120
  , ppUrgent           = wrap "%{F#44475a}%{B#f8f8f2} " " %{F#dedede}%{B#1e1f29}"
  , ppLayout           = wrap " " " "
  , ppWsSep            = ""
  , ppSep              = ""
  , ppOrder            = \(ws:l:t:_) -> [ws,l,t]
  , ppOutput           = hPutStrLn h
  }

-- Launch bar segments
launchLemonbar1 = "lemonbar -f 'Iosevka:size=9:antialias=true:autohint=false:hintstyle=hintslight' -B '#1e1f29' -g 1222x22+0+0"
launchLemonbar2 = "dwmblocks -p | lemonbar -f 'Iosevka:size=9:antialias=true:autohint=false:hintstyle=hintslight' -B '#1e1f29' -F '#dedede' -g 698x22+1222+0"

-- Config
main = do
  lemonbar <- spawnPipe launchLemonbar1
  spawn launchLemonbar2
  xmonad $ H.ewmh $ withNavigation2DConfig def $ docks def
    { terminal = "st"
    , modMask = mod4Mask 
    , borderWidth = 2
    , XMonad.keys = myKeys
    , XMonad.mouseBindings = myMouseBindings
    , startupHook = setDefaultCursor xC_left_ptr <+> myStartupHook >> addEWMHFullscreen
    , manageHook = insertPosition End Newer <+> myManageHook
    , logHook = myLogHook lemonbar <+> updatePointer (0.5, 0.5) (0,0)
    , layoutHook = myLayoutHook
    , normalBorderColor = "#363949"
    , focusedBorderColor = "#6e5991" 
    }
