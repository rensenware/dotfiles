-- Imports
import XMonad
import XMonad.Util.SpawnOnce
import XMonad.Hooks.InsertPosition
import XMonad.Actions.UpdatePointer
import XMonad.Actions.CycleWS
import XMonad.Layout.WindowArranger
import XMonad.Layout.ResizableTile
import System.Exit
import Data.Map as M
import XMonad.StackSet as W
import Graphics.X11.ExtraTypes.XF86


-- Keybinds
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

-- Basic applications
  [ ((modm, xK_Return), spawn $ XMonad.terminal conf)
  , ((modm, xK_a ), spawn "j4-dmenu-desktop")
  , ((modm .|. shiftMask, xK_a ), spawn "dmenu_run")
  , ((modm .|. controlMask, xK_a), spawn "/home/rensenware/.config/scripts/dmenuconfig.sh")

-- Session controls
  , ((modm .|. controlMask .|. shiftMask, xK_Delete), io (exitWith ExitSuccess))   
  , ((modm .|. shiftMask, xK_End), spawn "xmonad --recompile; xmonad --restart")
  , ((modm, xK_Delete), spawn "poweroff")
  , ((modm .|. shiftMask, xK_Delete), spawn "reboot")
  , ((modm, xK_End), spawn "betterlockscreen --lock")

-- Program launchers
  , ((modm .|. controlMask .|. shiftMask, xK_b), spawn "firefox")
  , ((modm .|. controlMask .|. shiftMask, xK_d), spawn "discord")
  , ((modm .|. controlMask .|. shiftMask, xK_s), spawn "spotify --force-device-scale-factor=1.32")
  , ((modm .|. controlMask .|. shiftMask, xK_f), spawn "thunar")
  , ((modm .|. controlMask .|. shiftMask, xK_l), spawn "libreoffice --writer")
  , ((modm .|. controlMask .|. shiftMask, xK_p), spawn "pinta")
  , ((modm .|. controlMask .|. shiftMask, xK_m), spawn "vlc")
  , ((modm .|. controlMask .|. shiftMask, xK_t), spawn "deluge-gtk")
  , ((modm .|. controlMask .|. shiftMask, xK_x), spawn "ksysguard")

-- Thinkpad special keys
  , ((0, xF86XK_Tools), spawn "/home/rensenware/.config/scripts/dwmtouchpad.sh")
  , ((0, xF86XK_Bluetooth), spawn "/home/rensenware/.config/scripts/dwmbluetooth.sh")
  , ((0, xF86XK_WLAN), spawn "/home/rensenware/.config/scripts/dwmwlan.sh")
  , ((0, xF86XK_Display), spawn "/home/rensenware/.config/scripts/dmenudisplay.sh none")
  , ((modm, xF86XK_Display), spawn "arandr")

-- Spotify controls
  , ((modm, xK_Up), spawn "playerctl -p spotify play-pause")
  , ((modm, xK_Down), spawn "playerctl -p spotify play-pause")
  , ((modm, xK_Right), spawn "playerctl -p spotify next")
  , ((modm, xK_Left), spawn "playerctl -p spotify previous")

-- Kill focused window
  , ((modm, xK_q ), kill)

-- Toggle floating
  , ((modm, xK_space ), withFocused $ windows . W.sink)

-- Focusing
  , ((modm, xK_j), windows W.focusDown)
  , ((modm, xK_k), windows W.focusUp)
  , ((modm, xK_h), windows W.focusMaster)

-- Stack control
  , ((modm .|. shiftMask, xK_j), windows W.swapDown)
  , ((modm .|. shiftMask, xK_k), windows W.swapUp)
  , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)

-- Resizing
  , ((modm, xK_t), sendMessage Shrink)
  , ((modm, xK_y), sendMessage Expand)
  , ((modm .|. shiftMask, xK_t), sendMessage MirrorShrink)
  , ((modm .|. shiftMask, xK_y), sendMessage MirrorExpand)

-- Floating window control
  , ((modm, xK_m), sendMessage (MoveDown 27))
  , ((modm, xK_comma), sendMessage (MoveUp 27))
  , ((modm, xK_n), sendMessage (MoveLeft 48))
  , ((modm, xK_period), sendMessage (MoveRight 48))
  , ((modm .|. shiftMask, xK_m), sendMessage (IncreaseDown 27))
  , ((modm .|. shiftMask, xK_comma), sendMessage (DecreaseDown 27))
  , ((modm .|. shiftMask, xK_n), sendMessage (DecreaseRight 48))
  , ((modm .|. shiftMask, xK_period), sendMessage (IncreaseUp 48))

-- Increase number of windows in master area
  , ((modm, xK_minus), sendMessage (IncMasterN (-1)))
  , ((modm, xK_equal), sendMessage (IncMasterN 1))

-- Audio controls
  , ((0, xF86XK_AudioMute), spawn "/home/rensenware/.config/scripts/volume.sh --toggle")
  , ((0 ,xF86XK_AudioLowerVolume), spawn "/home/rensenware/.config/scripts/volume.sh --down")
  , ((0, xF86XK_AudioRaiseVolume), spawn "/home/rensenware/.config/scripts/volume.sh --up")
  , ((0, xF86XK_AudioMicMute), spawn "/home/rensenware/.config/scripts/volume.sh --mic")

-- Workspace switching
  , ((modm, xK_Tab), nextWS)
  , ((modm, xK_grave), prevWS)
  ]
  ++
  [((m .|. modm, k), windows $ f i)
    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]


-- Autostart
myStartupHook = do
  spawnOnce "xsetroot -cursor_name left_ptr &"
  spawnOnce "xrandr --output \"eDP1\" --auto && xrandr --output \"HDMI2\" --off &"
  spawnOnce "picom --config /home/rensenware/.config/picom/config --experimental-backends &"
  spawnOnce "/home/rensenware/.fehbg &"
  spawnOnce "dunst &"
  spawnOnce "xset r rate 300 50 &"
  spawnOnce "/usr/lib/xfce-polkit/xfce-polkit &"
  spawnOnce "kglobalaccel5 &"


-- Layouts
myLayoutHook = tiled ||| Full
  where
    tiled = ResizableTall nmaster delta ratio [5/4]
    nmaster = 1
    delta = 5/100
    ratio = 1/2


-- Window Management
myManageHook = composeAll
  [ className =? "Pavucontrol" --> doFloat ]


-- Main configuration
main = xmonad def
  --{ terminal    = "sh -c 'SHELL=/bin/zsh st'"
  { terminal    = "SHELL=/bin/zsh st"
  , modMask     = mod4Mask
  , borderWidth = 2
  , XMonad.keys = myKeys
  , startupHook = myStartupHook
  , manageHook = insertPosition End Newer <+> myManageHook
  , logHook = updatePointer (0.5, 0.5) (0, 0)
  , layoutHook = windowArrange myLayoutHook
  , normalBorderColor = "#444444"
  , focusedBorderColor = "#3f51b5"
  }
