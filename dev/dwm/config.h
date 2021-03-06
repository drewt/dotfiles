/* See LICENSE file for copyright and license details. */

/* appearance */
static const char font[]            = "-*-terminus-medium-r-*-*-12-*-*-*-*-*-*-*";
static const char normbordercolor[] = "#444444";
static const char normbgcolor[]     = "#37312c"; //"#222222";
static const char normfgcolor[]     = "#bbbbbb";
static const char selbordercolor[]  = "#537189"; //"#005577";
static const char selbgcolor[]      = "#537189"; //"#005577";
static const char selfgcolor[]      = "#eeeeee";
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const Bool showbar           = True;     /* False means no bar */
static const Bool topbar            = True;     /* False means bottom bar */

/* tagging */
static const char *tags[] = { "web", "prog", "doc", "media", "word", "mail", "p2p", "term", "misc" };

static const Rule rules[] = {
        /* class              instance    title       tags mask     isfloating   monitor */
        { "Gimp",             NULL,       NULL,       0,            True,        -1 },
        { "Firefox",          NULL,       NULL,       0,            False,       -1 },
};

/* layout(s) */
static const float mfact      = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster      = 1;    /* number of clients in master area */
static const Bool resizehints = True; /* True means respect size hints in tiled resizals */

static const Layout layouts[] = {
        /* symbol     arrange function */
        { "[]=",      tile },    /* first entry is default */
        { "><>",      NULL },    /* no layout function means floating behavior */
        { "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
        { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
        { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
        { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
        { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* definitions/helper for spawning curses programs */
#define TERM_PROG       "urxvt"
#define TERM_EXEC_OPT   "-e"
#define TERM_EXEC(prog) { TERM_PROG, TERM_EXEC_OPT, prog, NULL }

#define MPC(cmd) { "mpc", cmd, NULL }

/* commands */
static const char *dmenucmd[] = { "dmenu_run", "-fn", font, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *scrotcmd[] = { "scrot", "/home/drew/Pictures/Screenshot-%F-%T.png", NULL };

/* mpd */
static const char *scmuscmd[] = TERM_EXEC("scmus");
static const char *prevcmd[]  = MPC("prev");
static const char *playcmd[]  = MPC("play");
static const char *pausecmd[] = MPC("toggle");
static const char *stopcmd[]  = MPC("stop");
static const char *nextcmd[]  = MPC("next");
static const char *fwdcmd[]   = { "mpc", "seek", "+60", NULL };
static const char *backcmd[]  = { "mpc", "seek", "-60", NULL };

/* other programs */
static const char *termcmd[] = { TERM_PROG, NULL };
static const char *wicdcmd[] = TERM_EXEC("wicd-curses");
static const char *ffoxcmd[] = { "firefox", NULL };
static const char *torrentcmd[] = { "transmission-gtk", NULL };

static Key keys[] = {
        /* modifier                     key        function        argument */
        { MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
        { MODKEY,                       XK_Print,  spawn,          {.v = scrotcmd } },
        { MODKEY|ShiftMask,             XK_m,      spawn,          {.v = scmuscmd } },
        { MODKEY|ControlMask,           XK_z,      spawn,          {.v = prevcmd } },
        { MODKEY|ControlMask,           XK_x,      spawn,          {.v = playcmd } },
        { MODKEY|ControlMask,           XK_c,      spawn,          {.v = pausecmd } },
        { MODKEY|ControlMask,           XK_v,      spawn,          {.v = stopcmd } },
        { MODKEY|ControlMask,           XK_b,      spawn,          {.v = nextcmd } },
        { MODKEY|ControlMask,           XK_period, spawn,          {.v = fwdcmd  } },
        { MODKEY|ControlMask,           XK_comma,  spawn,          {.v = backcmd } },
        { MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
        { MODKEY|ShiftMask,             XK_f,      spawn,          {.v = ffoxcmd } },
        { MODKEY|ShiftMask,             XK_n,      spawn,          {.v = wicdcmd } },
	{ MODKEY|ShiftMask,             XK_t,      spawn,          {.v = torrentcmd } },

        { MODKEY,                       XK_b,      togglebar,      {0} },
        { MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
        { MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
        { MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
        { MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
        { MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
        { MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
        { MODKEY,                       XK_Return, zoom,           {0} },
        { MODKEY,                       XK_Tab,    view,           {0} },
        { MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
        { MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
        { MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
        { MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
        { MODKEY,                       XK_space,  setlayout,      {0} },
        { MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
        { MODKEY,                       XK_0,      view,           {.ui = ~0 } },
        { MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
        { MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
        { MODKEY,                       XK_period, focusmon,       {.i = +1 } },
        { MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
        { MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
        TAGKEYS(                        XK_1,                      0)
        TAGKEYS(                        XK_2,                      1)
        TAGKEYS(                        XK_3,                      2)
        TAGKEYS(                        XK_4,                      3)
        TAGKEYS(                        XK_5,                      4)
        TAGKEYS(                        XK_6,                      5)
        TAGKEYS(                        XK_7,                      6)
        TAGKEYS(                        XK_8,                      7)
        TAGKEYS(                        XK_9,                      8)
        { MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
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
