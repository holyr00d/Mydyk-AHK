#Include Gdip.ahk
#NoEnv
#SingleInstance, Force
#Persistent
#MaxThreadsPerHotkey, 3
Process, Priority,, High
SetBatchLines, -1
SetWorkingDir %A_ScriptDir%
SetMouseDelay, 5
SetWinDelay,-1
ListLines, Off
recoilEnabled := false
counter := 0

Gui, +LastFound +E0x20
Gui, Margin, 0, 0
Gui, Color, c010105
Gui, Font, c0x9370DB s14 bold, Arial ; 'Medium Purple' color
Gui, Add, Tab, x10 y20 w490 h470 vTabs, Recoil

; Recoil tab
Gui, Tab, Recoil
Gui, Add, Picture, x220 y80, holai2.png
Gui, Add, Text, x40 y60 +BackgroundTrans, Set Profile Name
Gui, Add, Edit, x40 y90 w200 h30 vExeName
Gui, Add, Text, x40 y140 +BackgroundTrans, Horizontal Parameter
Gui, Add, Edit, x40 y170 w100 h30 vHorizontalParameter
Gui, Add, Text, x40 y220 +BackgroundTrans, Vertical Parameter
Gui, Add, Edit, x40 y250 w100 h30 vVerticalParameter
Gui, Add, Text, x40 y300 +BackgroundTrans, Game Process
Gui, Add, Edit, x40 y330 w200 h30 vGameProcess
Gui, Add, Button, x40 y440 w125 h45 gResetParameters, Reset Parameters

Gui, Show, w512 h512

Gui, Submit, NoHide
HorizontalParameter := HorizontalParameter ; no adjustment needed
VerticalParameter := VerticalParameter ; no adjustment needed
Hotkey, $*~LButton, DoRecoil, On
return

DoRecoil:
{
    if (WinActive("ahk_exe " . GameProcess))
    {
        while GetKeyState("LButton")
        {
            DllCall("mouse_event", uint, 1, int, HorizontalParameter, int, VerticalParameter, uint, 1, int, 0)
            Sleep, 25
        }
    }
}
return

ToggleRecoil:
{
    recoilEnabled := !recoilEnabled
    if (Mod(counter, 2) = 0)
    {
        Gui, Font, cLime s24 bold, Arial
    }
    else
    {
        Gui, Font, cRed s24 bold, Arial
    }
    counter += 1
}
return

ResetParameters:
{
    GuiControl,, HorizontalParameter, 0
    GuiControl,, VerticalParameter, 0
    HorizontalParameter := 0
    VerticalParameter := 0
}
return
