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
Gui, Font, c0x9370DB s14 bold, Arial ; change 'Medium Purple' to the desired color
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
Gui, Add, Text, x40 y380 +BackgroundTrans, On/Off Key
Gui, Add, Edit, x40 y410 w100 h30 vOnOffKey gSetHotkey
Gui, Font, cRed s16 bold, Arial
Gui, Add, Text, x40 y460 vStatus, Disabled
Gui, Add, Button, x220 y440 gResetParameters, Reset Parameters

Gui, Show, w512 h512

Gui, Submit, NoHide
HorizontalParameter := HorizontalParameter ; no adjustment needed
VerticalParameter := VerticalParameter ; no adjustment needed
Hotkey, $*~LButton, DoRecoil, On
return

DoRecoil:
{
    Gui, Submit, NoHide ; Fetch the updated values
    if (WinActive("ahk_exe " . GameProcess) and HorizontalParameter and VerticalParameter)
    {
        while GetKeyState("LButton")
        {
            DllCall("mouse_event", uint, 1, int, HorizontalParameter, int, VerticalParameter, uint, 1, int, 0)
            Sleep, 25
        }
    }
}
return

SetHotkey:
Gui, Submit, NoHide
Hotkey, % "$*" OnOffKey, ToggleRecoil
return

ToggleRecoil:
{
recoilEnabled := !recoilEnabled
if (Mod(counter, 2) = 0)
{
    Gui, Font, cLime s24 bold, Arial
    GuiControl,, Status, Enabled
}
else
{
    Gui, Font, cRed s24 bold, Arial
    GuiControl,, Status, Disabled
}
counter += 1
}
return

ResetParameters:
GuiControl,, HorizontalParameter, ; Clear Horizontal Parameter
GuiControl,, VerticalParameter, ; Clear Vertical Parameter
HorizontalParameter := 0 ; Reset the variable
VerticalParameter := 0 ; Reset the variable
return
