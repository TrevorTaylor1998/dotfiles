import XMonad
import XMonad.Config.Xfce
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import XMonad.Util.EZConfig
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops

myKeys baseConfig@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask .|. shiftMask, xK_s), windows (W.shift "1"))]

myWorkSpaces = ["1", "2", "3", "4", "5", "6", "7", "8"]--, "9"]
--qwerty
-- myWorkSpacesKeys = [xK_a, xK_s, xK_d, xK_f, xK_z, xK_x, xK_c, xK_v]--, xK_r]
--colemak
myWorkSpacesKeys = [xK_a, xK_r, xK_s, xK_t, xK_x, xK_c, xK_d, xK_v]--, xK_r]


myKey = [ ((mod4Mask .|. shiftMask, xK_c), kill)]
       ++
       [ ((mod4Mask .|. l, i), windows (j k))
           | (i, k) <- zip myWorkSpacesKeys myWorkSpaces
           , (j, l) <- [(W.greedyView, 0), (W.shift, shiftMask)]
       ]
       ++
       [((m .|. mod4Mask, key), screenWorkspace sc >>=
        flip whenJust (windows . f))
       -- qwerty
       -- | (key, sc) <- zip [xK_w, xK_e] [0..]
       -- colemak
       | (key, sc) <- zip [xK_w, xK_f] [0..]
       , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
       ++
       [((m .|. mod4Mask, key), screenWorkspace sc >>=
        flip whenJust (windows . f))
       -- qwerty
       -- | (key, sc) <- zip [xK_j, xK_k] [0..]
       -- colemak
       | (key, sc) <- zip [xK_n, xK_e] [0..]
       , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

-- main = xmonad xfceConfig
--      { terminal = "xfce4-terminal"
--      , modMask = mod4Mask -- optional: use Win key instead of Alt as MOD key
--      , borderWidth = 0
--      , focusFollowsMouse = False
--      }`additionalKeys` myKey

main = do
    xmonad $ def
        { manageHook  = manageDocks <+> manageHook defaultConfig
        , logHook     = ewmhDesktopsLogHook
        , layoutHook  = avoidStruts $ layoutHook defaultConfig
        , handleEventHook = ewmhDesktopsEventHook
        , startupHook = ewmhDesktopsStartup
        , modMask     = mod4Mask
        , focusFollowsMouse = False
        , borderWidth = 0
        }
        `additionalKeys`
        myKey
