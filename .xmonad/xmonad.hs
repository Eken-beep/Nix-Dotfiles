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
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers ( doFullFloat, isFullscreen )
import XMonad.Hooks.EwmhDesktops

-- Imports; Layouts
import XMonad.Layout.LayoutModifier
import XMonad.Layout.CenteredMaster
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders

import Graphics.X11.ExtraTypes.XF86

-- Imports; Other 
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- Variables
myTerminal      = "kitty"
myBorderWidth   = 4
myModMask       = mod4Mask

-- Colors
colorBG :: String
colorBG = "#1f1f1f"

colorFG :: String
colorFG = "#dfdfdf"

colorInactive :: String
colorInactive = "#878787"

colorPrimary :: String
colorPrimary = "#3d85c6"

colorSecondary :: String
colorSecondary = "#c13e63"

myNormalBorderColor  = "#dfdfdf"
myFocusedBorderColor = "#3d85c6"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = True

-- Window count module for the xmobar PP
windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

-- Workspace list
myWorkspaces    = ["I","II","III","IV","V","VI","VII","VIII","IX"]

main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB mySB defToggleStrutsKey
     . docks
     $ myConfig

mySB = statusBarProp "xmobar /home/edvin/.xmonad/xmobar.hs" (pure myPP)

myPP = xmobarPP 
      -- Properties of current workspace
    { ppCurrent = xmobarColor colorPrimary "" . wrap "<box type=Bottom width=2> " " </box>"

      -- Properties of workspace on other monitor
    , ppVisible = xmobarColor colorSecondary "" . wrap "<box type=Bottom width=2> " " </box>"

      -- Properties of hidden workspaces without windows
    , ppHiddenNoWindows = xmobarColor colorInactive ""

      -- Title of active window
    , ppTitle = xmobarColor colorFG "" . shorten 80
      
      -- Separator character
    , ppSep =  "<fc=#3d85c6> <fn=1>|</fn> </fc>"

      -- Number of windows on workspace
    , ppExtras = [windowCount]

      -- Order of things
    , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
    
    }

-- Key bindings
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- Simple keys
    [ ((modm,               xK_Return), spawn myTerminal                                            )
    , ((modm,               xK_Escape), spawn "rofi -show drun"                                     )
    , ((modm,               xK_f     ), spawn "flameshot gui"                                       )
    , ((modm,               xK_i     ), spawn "sh /home/edvin/.xmonad/kbd.sh"                       )
    , ((modm .|. shiftMask, xK_q     ), kill                                                        )

    -- Navigation
    , ((modm,               xK_space ), sendMessage NextLayout                                      )
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf                          ) -- Set the layout to the default
    , ((modm,               xK_n     ), refresh                                                     )
    , ((modm,               xK_Tab   ), windows W.focusDown                                         )
    , ((modm,               xK_j     ), windows W.focusDown                                         )
    , ((modm,               xK_k     ), windows W.focusUp                                           )
    , ((modm,               xK_m     ), windows W.focusMaster                                       )
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster                                        )
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown                                          ) -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp                                            ) -- Swap the focused window with the previous window
    , ((modm,               xK_h     ), sendMessage Shrink                                          ) -- Master area
    , ((modm,               xK_l     ), sendMessage Expand                                          )
    , ((modm,               xK_t     ), withFocused $ windows . W.sink                              ) -- Push window back into tiling
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1)                                  )
    , ((modm              , xK_period), sendMessage (IncMasterN (-1))                               )
    , ((modm              , xK_b     ), sendMessage ToggleStruts                                    )
    , ((modm .|. shiftMask, xK_x     ), io (exitWith ExitSuccess)                                   )

    -- Powerkeys
    , ((modm              , xK_x     ), spawn "killall xmobar; xmonad --recompile; xmonad --restart")
    , ((modm .|. shiftMask, xK_p     ), spawn "poweroff"                                            )
    , ((modm .|. controlMask, xK_p   ), spawn "reboot"                                              )

    -- Media keys
    , ((0, xF86XK_AudioPlay          ), spawn "playerctl play-pause"                                )
    , ((0, xF86XK_AudioNext          ), spawn "playerctl next"                                      )
    , ((0, xF86XK_AudioPrev          ), spawn "playerctl previous"                                  )
    , ((0, xF86XK_AudioStop          ), spawn "playerctl stop"                                      )
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
  spawnOnce "kitty"
  spawnOnce "qutebrowser"
  spawnOnce "firefox"
  spawnOnce "discord"

-- Configuration to set the defaults
myConfig = def {
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
    handleEventHook    = myEventHook,
    startupHook        = myStartupHook
}
