{-# LANGUAGE ImportQualifiedPost #-}

import Data.Map qualified as M
import System.Exit
import System.IO
import XMonad
import XMonad.Actions.GroupNavigation
import XMonad.Actions.PhysicalScreens
import XMonad.Actions.UpdatePointer
import XMonad.Config
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Dwindle
import XMonad.Layout.LayoutCombinators hiding ((|||))
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.SimpleDecoration (shrinkText)
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Layout.TwoPane
import XMonad.Prompt.Pass
import XMonad.StackSet qualified as W
import XMonad.Util.EZConfig (additionalKeys, additionalKeysP, additionalMouseBindings)
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.WorkspaceCompare

myTabConfig =
  def
    { activeColor = "#F01A08",
      inactiveColor = "#FDF6E3",
      urgentColor = "#FDF6E3",
      activeBorderColor = "#454948",
      inactiveBorderColor = "#454948",
      urgentBorderColor = "#268BD2",
      activeTextColor = "#80FFF9",
      inactiveTextColor = "#1ABC9C",
      urgentTextColor = "#1ABC9C",
      fontName = "xft:Noto Sans CJK:size=20:antialias=true"
    }

myLayout =
  avoidStruts $
    Full
      ||| tiled
      ||| Mirror tiled
      ||| twoPane
  where
    -- The last parameter is fraction to multiply the slave window heights
    -- with. Useless here.
    tiled = ResizableTall nmaster delta ratio []
    -- In this layout the second pane will only show the focused window.
    twoPane = TwoPane delta ratio
    -- The default number of windows in the master pane
    nmaster = 1
    -- Default proportion of screen occupied by master pane
    ratio = 1 / 2
    -- Percent of screen to increment by when resizing panes
    delta = 1 / 100

myBorderColors = ("#737373", "green")

myScreens = (screenOne, succ screenOne, succ $ succ screenOne, succ $ succ $ succ screenOne) where screenOne = 0

-- screenMovements screenNumber key = [((mod1Mask, key), viewScreen def (getScreen myScreens screenNumber))]

getscreen (a, b, c, d) x
  | x == 1 = a
  | x == 2 = b
  | x == 3 = c
  | otherwise = d

main = do
  xmonad $
    docks
      def
        { layoutHook = myLayout,
          manageHook = composeAll [className =? "yakuake" --> doFloat, className =? "Guake" --> doFloat, className =? "pinentry-qt" --> doFloat, className =? "ripdrag" --> doFloat],
          terminal = "kitty",
          startupHook = composeAll [setWMName "LG3D"],
          borderWidth = 4,
          normalBorderColor = fst myBorderColors,
          focusedBorderColor = snd myBorderColors,
          logHook = composeAll [updatePointer (0.5, 0.5) (0, 0)]
        }
      `additionalKeys` [ ((mo, xK_b), spawn "brave"),
                         ((mosh, xK_b), spawn "chromium"),
                         ((moc, xK_b), spawn "kitty -e browsh"),
                         ((mosh, xK_b), spawn "librewolf"),
                         ((mod1Mask, xK_c), spawn "kitty"),
                         ((moc, xK_c), spawn "st"),
                         ((moc, xK_r), spawn "kitty -e newsboat"),
                         ((mo, xK_v), spawn "kitty -e pulsemixer"),
                         ((mosh, xK_v), spawn "kitty -e alsamixer"),
                         ((moc, xK_a), spawn "kitty -e asciiquarium"),
                         ((mo, xK_m), spawn "kitty -e alot"),
                         ((moc, xK_m), spawn "kitty -e toxic"),
                         ((mosh, xK_d), spawn "wget $(xsel -b) -P ~/Downloads/"),
                         ((mosh, xK_z), spawn "slock"),
                         ((moc, xK_t), spawn "kitty -e glances"),
                         ((mosh, xK_equal), spawn "kitty -e  tty-clock -f '%A, %Y-%m-%d' -s -c -C 2"),
                         ((mo, xK_p), spawn "rofi -show run"),
                         ((mo, xK_minus), spawn "bwmenu -c 10"),
                         ((mo, xK_y), passPrompt def),
                         ((mo, xK_Print), spawn "emote"),
                         ((mo, xK_minus), spawn "passmenu"),
                         ((mosh, xK_s), spawn "nerd-dictation begin"),
                         ((moc, xK_s), spawn "nerd-dictation end"),
                         ((mosh, xK_minus), spawn "passmenu --type"),
                         ((mosh, xK_l), sendMessage MirrorShrink),
                         ((mosh, xK_h), sendMessage MirrorExpand),
                         ((mo, xK_f), sendMessage $ JumpToLayout "Full"),
                         ((mosh, xK_w), sendToScreen def (getscreen myScreens 1)),
                         ((mosh, xK_e), sendToScreen def (getscreen myScreens 1)),
                         ((mosh, xK_r), sendToScreen def (getscreen myScreens 2)),
                         ((mo, xK_w), viewScreen def (getscreen myScreens 1)),
                         ((mo, xK_e), viewScreen def (getscreen myScreens 1)),
                         ((mo, xK_r), viewScreen def (getscreen myScreens 2)),
                         ((mosh, xK_u), sendToScreen def (getscreen myScreens 1)),
                         ((mosh, xK_i), sendToScreen def (getscreen myScreens 1)),
                         ((mosh, xK_o), sendToScreen def (getscreen myScreens 2)),
                         ((mo, xK_u), viewScreen def (getscreen myScreens 1)),
                         ((mo, xK_i), viewScreen def (getscreen myScreens 1)),
                         ((mo, xK_o), viewScreen def (getscreen myScreens 2))
                       ]
  where
    mo = mod1Mask
    sho = shiftMask
    co = controlMask
    mosh = mo .|. sho
    moc = mo .|. co

-- ((mo, xK_minus), spawn "bwmenu -c 10"),
