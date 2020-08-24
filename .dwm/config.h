/* Function Keysyms */
#include <X11/XF86keysym.h>

/* Border, Gaps */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int gappx     = 0;        /* gaps between windows */
static const unsigned int snap      = 32;        /* snap pixel */

/* Window Swallowing */
static const int swallowfloating    = 0;        

/* Polybar */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 0;        /* 0 means bottom bar */
static const int usealtbar          = 1;        /* Use Other Status Bar */
static const char *altbarclass      = "Polybar"; /* Alternate bar class name */

/* Irrelevant, Not Using Dwm's Bar */
static const char *fonts[]          = { "monospace:size=10" };
static const char dmenufont[]       = "monospace:size=10";

/* Colors */
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char col_focu[]        = "#15a898";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_focu  },
};

/* Tags */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

/* Window Rules */
static const Rule rules[] = {
	/* class     instance  title           tags mask  isfloating  isterminal  noswallow  monitor */
	{ "st-256color",NULL,    NULL,           0,         0,          1,           0,        -1 },
	{ NULL,      NULL,     "Event Tester", 0,         0,          0,           1,        -1 }, /* xev */
  { "2048-qt", NULL,     NULL,           0,         1,          0,           0,        -1 },
  { NULL,      NULL,     "Qalculate!",   0,         1,          0,           0,        -1 },
  { "Nm-connection-editor",NULL,NULL,    0,         1,          0,           0,        -1 },
  { "Rofi",    NULL,     NULL,           0,         1,          0,           1,        -1 },
  { "tabbed",  NULL,     NULL,           0,         0,          0,          1,         -1 },
};

/* Master Size */
static const float mfact     = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

/* Layouts Order */
#include "fibonacci.c"
#include "gaplessgrid.c"
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[*]",      tile },    /* first entry is default */
 	{ "[\\]",     dwindle },
 	{ "[@]",      spiral },
  { "[#]",      gaplessgrid },
	{ "[-]",      bstack },
	{ "[=]",      centeredmaster },
	{ "[!]",      monocle },
	{ "[ ]",      NULL },    /* no layout function means floating behavior */
	{ NULL,       NULL },
};

#define STACKKEYS(MOD,ACTION) \
	{ MOD, XK_t,     ACTION##stack, {.i = INC(+1) } }, \
	{ MOD, XK_n,     ACTION##stack, {.i = INC(-1) } }, \
	{ MOD, XK_minus, ACTION##stack, {.i = PREVSEL } }, \
	{ MOD, XK_h,     ACTION##stack, {.i = 0 } }, \
	{ MOD, XK_s,     ACTION##stack, {.i = -1 } }, \
/*	{ MOD, XK_a,     ACTION##stack, {.i = 1 } }, \ */
/*	{ MOD, XK_z,     ACTION##stack, {.i = 2 } }, \ */

/* Declare swaptags */
void swaptags(const Arg *arg);

/* Tag Switching Keys */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} }, \
	{ Mod1Mask,                     KEY,      swaptags,       {.ui = 1 << TAG} },

/* Old Command Launch Method */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* Basic DWM Hardcoded programs */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "/home/rensenware/.config/scripts/rofi-menu-launch.sh", NULL };
static const char *termcmd[]  = { "st", NULL };
static const char *emoji[] = { "/home/rensenware/.config/scripts/emoji.sh", NULL };

/* Application Launchers */
static const char *firefox[] = { "firefox", NULL };
static const char *discord[] = { "discord", NULL };
static const char *spotify[] = { "spotify", "--force-device-scale-factor=1.37", NULL };
static const char *thunar[] = { "thunar", NULL };
static const char *libreoffice[] = { "libreoffice", "--writer", NULL };
static const char *pinta[] = { "pinta", NULL };
static const char *vlc[] = { "vlc", NULL };
static const char *qalculate[] = { "qalculate-gtk", NULL };
static const char *vim[] = { "st", "-e", "nvim", NULL };
static const char *deluge[] = { "deluge-gtk", NULL };
static const char *ksysguard[] = { "ksysguard", NULL };
static const char *krunker[] = { "krunker", NULL };

/* Poweroff, Reboot, And Lock */
static const char *poweroff[] = { "systemctl", "poweroff", NULL };
static const char *reboot[] = { "systemctl", "reboot", NULL };
static const char *lockscreen[] = { "/home/rensenware/.config/scripts/screenlock.sh", NULL };

/* Restart Polybar */
static const char *polybarrestart[] = { "/home/rensenware/.config/polybar/launch.sh", NULL };

/* Spotify Keyboard Shortcuts */
static const char *spotifypause[] = { "playerctl", "-p", "spotify", "play-pause", NULL };
static const char *spotifynext[] = { "playerctl", "-p", "spotify", "next", NULL };
static const char *spotifyprev[] = { "playerctl", "-p", "spotify", "previous", NULL };

/* Function Keys */
static const char *touchpad[] = { "/home/rensenware/.config/scripts/dwmtouchpad.sh", NULL };
static const char *arandr[] = { "arandr", NULL };
static const char *display[] = { "/home/rensenware/.config/scripts/dmenudisplay.sh", NULL };
static const char *bluetooth[] = { "/home/rensenware/.config/scripts/dwmbluetooth.sh", NULL };
static const char *wlan[] = { "/home/rensenware/.config/scripts/dwmwlan.sh", NULL };
static const char *vpn[] = { "/home/rensenware/.config/scripts/expressvpn.sh", NULL };

/* Brightness Keys */
static const char *brightnessup[] = { "/home/rensenware/.config/scripts/changebrightness.sh", "up", NULL };
static const char *brightnessdown[] = { "/home/rensenware/.config/scripts/changebrightness.sh", "down", NULL };

/* Audio Keys */
static const char *volumeup[] = { "/home/rensenware/.config/scripts/volume.sh", "--up", NULL };
static const char *volumedown[] = { "/home/rensenware/.config/scripts/volume.sh", "--down", NULL };
static const char *mute[] = { "/home/rensenware/.config/scripts/volume.sh", "--toggle", NULL };
static const char *mic[] = { "/home/rensenware/.config/scripts/volume.sh", "--mic", NULL };

/* Screenshotting */
static const char *screenshot[] = { "spectacle", NULL };

#include "shiftview.c"

static Key keys[] = {
	/* modifier                     key        function        argument */

/* Basic Hardcoded DWM Programs */
	{ MODKEY,                       XK_a,      spawn,          {.v = dmenucmd } },
  { MODKEY,                       XK_o,      spawn,          {.v = emoji } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },

/* Fullscreen */
	{ MODKEY,                       XK_u,      togglefullscr,  {0} },

/* Navigate Stack */
	STACKKEYS(MODKEY,                          focus)
	STACKKEYS(MODKEY|ShiftMask,                push)

/* Increase NMaster */
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },

/* Resizing Master */
	{ MODKEY,                       XK_x,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_b,      setmfact,       {.f = +0.05} },

/* Move To Top Of Stack */
	{ MODKEY,                       XK_Return, zoom,           {0} },

/* Kill Focused Client */
	{ MODKEY,                       XK_apostrophe,      killclient,     {0} },

/* Layout Hotkeys */
	{ MODKEY,                       XK_y,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_g,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_c,      setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_r,      setlayout,      {.v = &layouts[4]} },
	{ MODKEY,                       XK_l,      setlayout,      {.v = &layouts[5]} },
	{ MODKEY,                       XK_slash,  setlayout,      {.v = &layouts[6]} },
	{ MODKEY,                       XK_equal,  setlayout,      {.v = &layouts[7]} },
	{ MODKEY,		                    XK_comma,  cyclelayout,    {.i = -1 } },
	{ MODKEY,                       XK_period, cyclelayout,    {.i = +1 } },

/* Toggle Floating */
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },

/* Resizing */
	{ MODKEY,                       XK_w,      moveresize,     {.v = "0x 25y 0w 0h" } },
	{ MODKEY,                       XK_v,      moveresize,     {.v = "0x -25y 0w 0h" } },
	{ MODKEY,                       XK_z,      moveresize,     {.v = "25x 0y 0w 0h" } },
	{ MODKEY,                       XK_m,      moveresize,     {.v = "-25x 0y 0w 0h" } },
	{ MODKEY|ShiftMask,             XK_w,      moveresize,     {.v = "0x 0y 0w 25h" } },
	{ MODKEY|ShiftMask,             XK_v,      moveresize,     {.v = "0x 0y 0w -25h" } },
	{ MODKEY|ShiftMask,             XK_z,      moveresize,     {.v = "0x 0y 25w 0h" } },
	{ MODKEY|ShiftMask,             XK_m,      moveresize,     {.v = "0x 0y -25w 0h" } },
	{ MODKEY|ControlMask,           XK_v,      moveresizeedge, {.v = "t"} },
	{ MODKEY|ControlMask,           XK_w,      moveresizeedge, {.v = "b"} },
	{ MODKEY|ControlMask,           XK_m,      moveresizeedge, {.v = "l"} },
	{ MODKEY|ControlMask,           XK_z,      moveresizeedge, {.v = "r"} },

/* View All Tags Simultaneously */
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },

/* Sticky To All Tags */
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },

/* Monitor Hotkeys */
	{ MODKEY,                       XK_Left,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_Right, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_Left,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_Right, tagmon,         {.i = +1 } },

/* Tag Keys */
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)

/* Alt Tab */
  { MODKEY,			                  XK_grave,	shiftview,	    { .i = -1 } },
  { MODKEY,			                  XK_Tab,	shiftview,	      { .i = +1 } },

/* Restart, Poweroff, Reboot, Lock, And Exit */
	{ MODKEY|ControlMask|ShiftMask, XK_Delete, quit,           {0} },
  { MODKEY,                       XK_Delete, spawn,         {.v = poweroff } },
  { MODKEY|ShiftMask,             XK_Delete, spawn,         {.v = reboot } },
  { MODKEY,                       XK_End,    spawn,         {.v = lockscreen } },

/* Polybar Restart */
  { MODKEY|ShiftMask,             XK_End,    spawn,         {.v = polybarrestart } },

/* Launchers */
  { MODKEY|ControlMask|ShiftMask, XK_x,      spawn,         {.v = firefox } },
  { MODKEY|ControlMask|ShiftMask, XK_e,      spawn,         {.v = discord } },
  { MODKEY|ControlMask|ShiftMask, XK_o,      spawn,         {.v = spotify } },
  { MODKEY|ControlMask|ShiftMask, XK_u,      spawn,         {.v = thunar } },
  { MODKEY|ControlMask|ShiftMask, XK_n,      spawn,         {.v = libreoffice } },
  { MODKEY|ControlMask|ShiftMask, XK_l,      spawn,         {.v = pinta } },
  { MODKEY|ControlMask|ShiftMask, XK_m,      spawn,         {.v = vlc } },
  { MODKEY|ControlMask|ShiftMask, XK_j,      spawn,         {.v = qalculate } },
  { MODKEY|ControlMask|ShiftMask, XK_y,      spawn,         {.v = deluge } },
  { MODKEY|ControlMask|ShiftMask, XK_q,      spawn,         {.v = ksysguard } },
  { MODKEY|ControlMask|ShiftMask, XK_t,      spawn,         {.v = krunker } },
  { MODKEY|ControlMask|ShiftMask, XK_k,      spawn,         {.v = vim } },

/* Spotify Controls */
  { ControlMask|ShiftMask,        XK_space,  spawn,         {.v = spotifypause } },
  { ControlMask|ShiftMask,        XK_Right,  spawn,         {.v = spotifynext } },
  { ControlMask|ShiftMask,        XK_Left,   spawn,         {.v = spotifyprev } },

/* Function Keys */
  { MODKEY,                       XF86XK_Tools,spawn,       {.v = vpn } },
  { 0,                            XF86XK_Tools,spawn,       {.v = touchpad } },
  { MODKEY,                       XF86XK_Display,spawn,     {.v = arandr } },
  { 0,                            XF86XK_Display,spawn,     {.v = display } },
  { 0,                            XF86XK_Bluetooth,spawn,   {.v = bluetooth } },
  { 0,                            XF86XK_WLAN,spawn,        {.v = wlan } },

/* Brightness Keys */
  { 0,                            XF86XK_MonBrightnessUp,spawn,{.v = brightnessup } },
  { 0,                            XF86XK_MonBrightnessDown,spawn,{.v = brightnessdown } },

/* Audio Keys */
  { 0,                            XF86XK_AudioRaiseVolume,spawn,{.v = volumeup } },
  { 0,                            XF86XK_AudioLowerVolume,spawn,{.v = volumedown } },
  { 0,                            XF86XK_AudioMute,spawn,   {.v = mute } },
  { 0,                            XF86XK_AudioMicMute,spawn,{.v = mic } },

/* Screenshot */
  { 0,                            XK_Print,  spawn,         {.v = screenshot } }, 

/* Scratchpad */
	{ 0,                            XF86XK_Favorites,scratchpad_show,{0} },
	{ MODKEY,                       XF86XK_Favorites,scratchpad_hide,{0} },
	{ MODKEY|ShiftMask,             XF86XK_Favorites,scratchpad_remove,{0} },


};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

void
swaptags(const Arg *arg)
{
	unsigned int newtag = arg->ui & TAGMASK;
	unsigned int curtag = selmon->tagset[selmon->seltags];

	if (newtag == curtag || !curtag || (curtag & (curtag-1)))
		return;

	for (Client *c = selmon->clients; c != NULL; c = c->next) {
		if((c->tags & newtag) || (c->tags & curtag))
			c->tags ^= curtag ^ newtag;

		if(!c->tags) c->tags = newtag;
	}

	selmon->tagset[selmon->seltags] = newtag;

	focus(NULL);
	arrange(selmon);
}

static const char *ipcsockpath = "/tmp/dwm.sock";
static IPCCommand ipccommands[] = {
  IPCCOMMAND(  view,                1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  toggleview,          1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  tag,                 1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  toggletag,           1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  tagmon,              1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  focusmon,            1,      {ARG_TYPE_SINT}   ),
  IPCCOMMAND(  focusstack,          1,      {ARG_TYPE_SINT}   ),
  IPCCOMMAND(  zoom,                1,      {ARG_TYPE_NONE}   ),
  IPCCOMMAND(  spawn,               1,      {ARG_TYPE_PTR}    ),
  IPCCOMMAND(  incnmaster,          1,      {ARG_TYPE_SINT}   ),
  IPCCOMMAND(  killclient,          1,      {ARG_TYPE_SINT}   ),
  IPCCOMMAND(  togglefloating,      1,      {ARG_TYPE_NONE}   ),
  IPCCOMMAND(  setmfact,            1,      {ARG_TYPE_FLOAT}  ),
  IPCCOMMAND(  setlayoutsafe,       1,      {ARG_TYPE_PTR}    ),
  IPCCOMMAND(  quit,                1,      {ARG_TYPE_NONE}   )
};
