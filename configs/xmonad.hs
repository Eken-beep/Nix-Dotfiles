-- Imports
import XMonad
import Data.Monoid
import System.Exit
import XMonad.Doc.Extending
import Data.List

-- Imports; Utils
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Util.Run(spawnPipe) 

-- Imports; Actions
import XMonad.Actions.SpawnOn
import XMonad.Actions.WorkspaceNames

-- Imports; Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers ( doFullFloat, isFullscreen )
import XMonad.Hooks.EwmhDesktops

-- Imports; Layouts
import XMonad.Layout.Fullscreen
    ( fullscreenEventHook, fullscreenManageHook, fullscreenSupport, fullscreenFull, fullscreenFloat )

import XMonad.Layout.Gaps
  ( Direction2D (D, L, R, U),
    GapMessage (ModifyGaps, ToggleGaps),
    GapSpec,
    Gaps,
    gaps,
  )

import XMonad.Layout.Spiral
import XMonad.Layout.ThreeColumns
import XMonad.Layout.NoBorders
import XMonad.Layout.Grid
import XMonad.Layout.LayoutModifier
import XMonad.Layout.CenteredMaster
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Spacing

import Graphics.X11.ExtraTypes.XF86

-- Imports; Other 
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- Variables
myTerminal      = "kitty"
myBorderWidth   = 4
myModMask       = mod4Mask

-- Colors
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#3d85c6"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = True

-- Workspace list
myWorkspaces    = ["zsh","web","game","r1","r2","r3","chat","music","r4"]

-- Key bindings
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm,               xK_Return), spawn myTerminal)

    -- launch dmenu
    , ((modm,               xK_Escape), spawn "rofi -show run")

    -- Screenshot tool
    , ((modm,               xK_f     ), spawn "flameshot gui")

    -- Keyboard layout switcher
    , ((modm,               xK_i     ), spawn "setxkbmap se svdvorak")
    , ((modm .|. shiftMask, xK_i     ), spawn "setxkbmap dvorak")
    
    -- close focused window
    , ((modm .|. shiftMask, xK_q     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus
    , ((modm,               xK_j     ), windows W.focusDown)
    , ((modm,               xK_k     ), windows W.focusUp  )
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Master area
    , ((modm,               xK_h     ), sendMessage Shrink)
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Edit size of the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Wallpaper thing
    , ((modm .|. shiftMask, xK_w     ), spawn "wpaper")
    
    -- Quit xmonad
    , ((modm .|. shiftMask, xK_x     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_x     ), spawn "killall xmobar; xmonad --recompile; xmonad --restart")
 
    -- Shutdown 
    , ((modm .|. shiftMask, xK_p     ), spawn "poweroff")
    
    -- Reboot
    ,((modm .|. controlMask, xK_p    ), spawn "reboot")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_a, xK_o, xK_e] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

-- Layouts
myLayout = avoidStruts (tiled ||| Mirror tiled ||| Full)
  where
   -- default tiling algorithm partitions the screen into two panes
     tiled    = Tall nmaster delta ratio

   -- The default number of windows in the master pane
     nmaster  = 1

   -- Default proportion of screen occupied by master pane
     ratio    = 1/2

     -- Percent of screen to increment by when resizing panes
     delta    = 3/100

     -- ThreeCol = 1 (3/100) (1/2)
     -- spiral = (6/7)

-- Window rules
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "steam"          --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore 
    , isFullscreen --> doFullFloat 
    ]

-- Layout hook
myLayoutHook = spacing 9 $ smartBorders $ avoidStruts $ myLayout

-- Event handling
myEventHook = mempty

-- Startup hook
myStartupHook = do
  spawnOnce "xrandr --output DP-0 --rate 144 --output DP-2 --right-of DP-0"
  spawnOnce "setxkbmap dvorak"
  spawnOnce "feh --recursive --bg-fill /home/edvin/wallpapers/pexels-eberhard-grossgasteiger-1287145.jpg &"
  spawnOnce "dunst &"
  spawnOnce "kitty"
  spawnOnce "qutebrowser"
  spawnOnce "discord"

-- Main funcion and defaults
main = do
  xmproc0 <- spawnPipe "xmobar /home/edvin/.xmonad/xmobar.hs"
  xmproc1 <- spawnPipe "xmobar /home/edvin/.xmonad/xmobar2.hs"
  xmonad $ docks $ ewmhFullscreen $ ewmh def {
    -- simple stuff
    terminal           = myTerminal,
    focusFollowsMouse  = myFocusFollowsMouse,
    clickJustFocuses   = myClickJustFocuses,
    borderWidth        = myBorderWidth,
    modMask            = myModMask,
    workspaces         = myWorkspaces,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,

    -- key bindings
    keys               = myKeys,
    mouseBindings      = myMouseBindings,

    -- hooks
    layoutHook         = myLayoutHook,
    manageHook         = myManageHook,
    handleEventHook    = myEventHook <+> fullscreenEventHook,
    startupHook        = myStartupHook,
 
    logHook = dynamicLogWithPP $ def { ppOutput = hPutStrLn xmproc0 } 
  }
