Config { 

   -- Display the icon: <icon=nixos.xpm/> <fc=#3d85c6>|</fc>
   -- appearance
     font =         "xft:FiraCode Nerd Font:size=12:antialias=true"
   , bgColor =      "#1f1f1f"
   , fgColor =      "#dfdfdf"
   , position =     Static { xpos = 0 , ypos = 0, width = 3440, height = 26 }
   , border =       BottomB
   , borderColor =  "#1f1f1f"
   , iconRoot =     "/home/edvin/.xmonad/"

   -- layout
   , sepChar =  "%"   -- delineator between plugin names and straight text
   , alignSep = "}{"  -- separator between left-right alignment
   , template = " %_XMONAD_LOG_1% } %date% { %dynnetwork% <fc=#3d85c6>|</fc> %kbd% <fc=#3d85c6>|</fc> %disku% <fc=#3d85c6>|</fc> Kernel: <fc=#3d85c6>%uname%</fc> <fc=#3d85c6>|</fc> %multicpu% <fc=#3d85c6>|</fc> %memory% "

   -- general behavior
   , lowerOnStart =     True    -- send to bottom of window stack on start
   , hideOnStart =      False   -- start with window unmapped (hidden)
   , allDesktops =      True    -- show on all desktops
   , overrideRedirect = True    -- set the Override Redirect flag (Xlib)
   , pickBroadest =     False   -- choose widest display (multi-monitor)
   , persistent =       True    -- enable/disable hiding (True = disabled)

   -- Modules    
   , commands = 

        -- weather monitor
        [ Run Weather "RJTT" [ "--template", "<skyCondition> | <fc=#4682B4><tempC></fc>°C | <fc=#4682B4><rh></fc>% | <fc=#4682B4><pressure></fc>hPa"
                             ] 36000

        -- network activity monitor (dynamic interface resolution)
        , Run DynNetwork     [ "--template" , "Eth: <tx>kB/s <rx>kB/s"
                             , "--Low"      , "1000"       -- units: B/s
                             , "--High"     , "5000"       -- units: B/s
                             , "--low"      , "#3097f8"
                             , "--normal"   , "#2f71af"
                             , "--high"     , "#004587"
                             ] 10

        -- cpu activity monitor
        , Run MultiCpu       [ "--template" , "Cpu: <total>%"
                             , "--Low"      , "50"         -- units: %
                             , "--High"     , "85"         -- units: %
                             , "--low"      , "#3097f8"
                             , "--normal"   , "#2f71af"
                             , "--high"     , "#004587"
                             ] 10

        -- cpu core temperature monitor
        , Run CoreTemp       [ "--template" , "tmp: <core0>°C|<core1>°C"
                             , "--Low"      , "70"        -- units: °C
                             , "--High"     , "80"        -- units: °C
                             , "--low"      , "darkgreen"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkred"
                             ] 50
                          
        -- memory usage monitor
        , Run Memory         [ "--template" ,"Mem: <usedratio>%"
                             , "--Low"      , "20"        -- units: %
                             , "--High"     , "90"        -- units: %
                             , "--low"      , "#3097f8"
                             , "--normal"   , "#2f71af"
                             , "--high"     , "#004587"
                             ] 10
	
	    -- kernel version
	    , Run Com "uname" ["-r"] "" 1000

        -- disk usage
	    , Run DiskU          [("/", "nvme0n1p3: <fc=#3d85c6><free></fc>")]
	                     ["-L", "20", "-H", "50", "-m", "1", "-p", "3"]
	                     20
        -- battery monitor
        , Run Battery        [ "--template" , "Batt: <acstatus>"
                             , "--Low"      , "10"        -- units: %
                             , "--High"     , "50"        -- units: %
                             , "--low"      , "#3097f8"
                             , "--normal"   , "#2f71af"
                             , "--high"     , "#004587"

                             , "--" -- battery specific options
                                       -- discharging status
                                       , "-o"	, "<left>% (<timeleft>)"
                                       -- AC "on" status
                                       , "-O"	, "<fc=#dAA520>Charging</fc>"
                                       -- charged status
                                       , "-i"	, "<fc=#006000>Charged</fc>"
                             ] 50

        -- time and date indicator 
        --   (%F = y-m-d date, %a = day of week, %T = h:m:s time)
        , Run Date           "%T <fc=#3d85c6>|</fc> %a <fc=#3d85c6>|</fc> %F" "date" 10

        -- keyboard layout indicator
        , Run Kbd            [ ("us(dvorak)"   , "<fc=#3d85c6>DV</fc>")
                             , ("se(svdvorak)" , "<fc=#c13e63>SV</fc>")
                             ]
        
    	-- Workspace indicator/Input Reader
	    , Run XPropertyLog "_XMONAD_LOG_1"

        ]
   }

