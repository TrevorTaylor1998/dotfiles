import XMonad
import XMonad.Config.Desktop
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import XMonad.Util.EZConfig
-- import XMonad.Hooks.Desktop
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run
import System.IO
import System.Directory
import System.Environment
import System.Exit
-- Had to do manual tricks to get this won't update easily
-- import Module Colors
-- import XMonad.Hooks.DynamicLog
-- import XMonad.Hooks.StatusBar
-- import XMonad.Hooks.StatusBar.PP


myKeys baseConfig@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask .|. shiftMask, xK_s), windows (W.shift "1"))]

myWorkSpaces = ["1", "2", "3", "4", "5", "6", "7", "8"]--, "9"]
--qwerty
myWorkSpacesKeys = [xK_a, xK_s, xK_d, xK_f, xK_z, xK_x, xK_c, xK_v]--, xK_r]
--colemak
-- myWorkSpacesKeys = [xK_a, xK_r, xK_s, xK_t, xK_x, xK_c, xK_d, xK_v]--, xK_r]
-- hands down
--myWorkSpacesKeys = [xK_r, xK_s, xK_n, xK_d, xK_x, xK_f, xK_l, xK_c]--, xK_r]


myKey = [ ((mod4Mask .|. shiftMask, xK_b), kill)]
       ++
       [ ((mod4Mask, xK_p), spawn "rofi -show run")]
       ++
       [ ((mod4Mask .|. shiftMask, xK_p), spawn "rofi -show window")]
       ++
       [ ((mod4Mask .|. l, i), windows (j k))
           | (i, k) <- zip myWorkSpacesKeys myWorkspaces
           , (j, l) <- [(W.greedyView, 0), (W.shift, shiftMask)]
       ]
       ++
       [((m .|. mod4Mask, key), screenWorkspace sc >>=
        flip whenJust (windows . f))
       -- qwerty
       -- | (key, sc) <- zip [xK_w, xK_e] [0..]
       -- colemak
       -- | (key, sc) <- zip [xK_w, xK_f] [0..]
       -- , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
       -- colemak
       | (key, sc) <- zip [xK_g, xK_m] [0..]
       , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
       ++
       -- [((m .|. mod4Mask, key), screenWorkspace sc >>=
       --  flip whenJust (windows . f))]
       -- qwerty
       -- | (key, sc) <- zip [xK_j, xK_k] [0..]
       -- colemak
       -- | (key, sc) <- zip [xK_n, xK_e] [0..]
       -- , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
      [((0                     , 0x1008FF11), spawn "amixer -q sset Master 2%-"),
      ((0                     , 0x1008FF13), spawn "amixer -q sset Master 2%+"),
      ((0                     , 0x1008FF12), spawn "amixer set Master toggle")
    ]

getConfigFilePath f =
  getHomeDirectory >>= \hd -> return $ hd ++ "/" ++ f

getWalColors = do
  file <- getConfigFilePath ".cache/wal/colors"
  contents <- readFile file
  let colors = lines contents
  return (colors ++ (replicate (16 - length colors) "#000000"))

xmobarEscape = concatMap doubleLts
  where doubleLts '<' = "<<"
        doubleLts x   = [x]

myWorkspaces :: [String]
myWorkspaces = clickable . (map xmobarEscape) $ ["1","2","3","4","5","6","7","8"]

  where
         clickable l = [ "<action=xdotool key super+" ++ show (n) ++ ">" ++ ws ++ "</action>" |
                             (i,ws) <- zip [1..8] l,
                            let n = i ]
-- main = xmonad xfceConfig
--      { terminal = "xfce4-terminal"
--      , modMask = mod4Mask -- optional: use Win key instead of Alt as MOD key
--      , borderWidth = 0
--      , focusFollowsMouse = False
--      }`additionalKeys` myKey

myConfig = def
    -- xmonad $ desktopConfig
        { manageHook  = manageDocks <+> manageHook defaultConfig
                        -- <+> manageHook desktopConfig
        , logHook     = ewmhDesktopsLogHook
        , layoutHook  = avoidStruts $ layoutHook desktopConfig
        , handleEventHook = ewmhDesktopsEventHook
        , workspaces  = myWorkspaces
        , startupHook = ewmhDesktopsStartup
        , modMask     = mod4Mask
        , focusFollowsMouse = False
        , borderWidth = 0
        -- , logHook = dynamicLogWithPP xmobarPP
        --         -- { ppOutput = hPutStrLn xmproc
        --         { ppCurrent = xmobarColor "yellow" "" . wrap "[" "]"
        --         , ppHiddenNoWindows = xmobarColor "grey" ""
        --         , ppTitle   = xmobarColor "green"  "" . shorten 40
        --         , ppVisible = wrap "(" ")"
        --         , ppUrgent  = xmobarColor "red" "yellow"
        --         }
        }
        `additionalKeys`
        myKey

-- main = do
    -- xmonad =<< xmobar myConfig
-- main = do
--     xmproc <- spawnPipe "xmobar ~/.config/nixpkgs/xmobarrc"
    -- xmonad . ewmh =<< xmobar myConfig
-- main = xmonad . ewmh =<< xmobar myConfig
main = do
    -- xmproc <- spawnPipe "xmobar ~/.config/nixpkgs/xmobarrc"
    --colors <- getWalColors
    -- xmonad $ docks desktopConfg
    xmonad $ docks def
        { manageHook  = manageDocks <+> manageHook defaultConfig
                        -- <+> manageHook desktopConfig
        -- , logHook     = ewmhDesktopsLogHook
        -- , layoutHook  = avoidStruts $ layoutHook desktopConfig
        , layoutHook  = avoidStruts $ layoutHook defaultConfig
        , handleEventHook = ewmhDesktopsEventHook
        , workspaces  = myWorkspaces
        , startupHook = ewmhDesktopsStartup
        , modMask     = mod4Mask
        , focusFollowsMouse = False
        , borderWidth = 0
        -- , logHook = dynamicLogWithPP xmobarPP
        --, logHook = dynamicLogWithPP xmobarPP
        --        { ppOutput = hPutStrLn xmproc
        --       , ppCurrent = xmobarColor (colors!!1) "" . wrap "[" "]"
        --        , ppHiddenNoWindows = xmobarColor "grey" ""
        --        , ppTitle   = xmobarColor (colors!!1)  "" . shorten 40
        --        , ppVisible = wrap "(" ")"
        --        , ppUrgent  = xmobarColor (colors!!3) (colors!!4)
        --        }
        }
        `additionalKeys`
        myKey
