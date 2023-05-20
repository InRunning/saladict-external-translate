;saladict 划译插件[AHK]
;version 0.9
;allor@sian.cn
;2016-01-08
;GUI及其他功能完善有待日后空闲
;========使用说明========
;pause键 启用/停用 脚本
;鼠标拖选、双击选词翻译
;~ http://weibo.com/1928931362/Dcdvnphx7?type=comment
;~ https://0paste.com/8133

SetTitleMatchMode, 2
programs := ["SumatraPDF.exe", "mailmaster.exe"]
If WinActive("沙拉查词-独立查词窗口") || CheckProgramActive(programs) {
    Pause::Suspend

    ^+y::
        If WinActive("沙拉查词-独立查词窗口") {
            WinActivateBottom, A
            Sleep, 800
        }
        oldClipboard := Clipboard
        gosub, Copy
    return

    MButton::
        oldClipboard := Clipboard
        gosub, Copy
    return

    ~LButton::
        ; WinClose, "沙拉查词-独立查词窗口"
        If !CheckProgramActive(programs) {
            return
        }
        oldClipboard := Clipboard
        ; WriteLog("oldClipboard: " . oldClipboard)
        CoordMode, Mouse, Screen
        SetKeyDelay 0, 10

        MouseGetPos, x1, y1
        output := "previous coordinate: " . x1 . " , " . y1
        ; WriteLog(output)
        ; DebugMessage("previous coordinate: ", %x1%, " , ", %y1%)
        KeyWait, LButton
        MouseGetPos, x2, y2
        output := "current coordinate: " . x2 . " , " . y2
        ; WriteLog(output)

        if (x1<>x2 or y1<>y2) {
            gosub, Copy
        }
        else if (A_priorHotKey = "~LButton" and A_TimeSincePriorHotkey < 1000){
            ; WriteLog("enter double click")
            gosub, Copy
        }
    return

    Copy:
        Send ^c
        Send ^+s
        output := "clipboard: " . Clipboard
        Clipboard := oldClipboard
        ; WriteLog(output)
        ; WriteLog("clipboard: " . %Clipboard%)
    return
}

; WriteLog(% "clipboard: ". %Clipboard%)
; If WinActive("ahk_exe notepad++.exe") {
;     ^x::
;     WinGetActiveTitle, Title
;     arr := StrSplit(Title, " ")
;     Run, C:/Users/Administrator/GolandProjects/autocopy/main.exe arr[0]
;     return
; }

CheckProgramActive(programs) {
    flag := False
    for index, ele in programs {
        If WinActive("ahk_exe " ele) {
            flag = True
        }
    }
    return flag
}

WriteLog(text) {
    FileAppend, % A_NowUTC ": " text "`n", logfile.txt ; can provide a full path to write to another directory
}

; #IfWinActive, ahk_exe notepad++.exe
; ^x::
; WinGetActiveTitle, Title
; arr := StrSplit(Title, " ")
; Run, C:/Users/Administrator/GolandProjects/autocopy/main.exe arr[0]
; return

~!Tab::
    ; If CheckProgramActive(programs) {
    ;     Send {Alt+Tab}
    ;     Send {Tab}
    ; } else {
    ;     Send {Alt+Tab}
    ; }
    ; NextWin := WinExist("A", "Next")
    ; MsgBox, nextwin：%NextWin%
    ; MsgBox, fdskfdsf
    ; WriteLog("detect shortcut Alt+Tab")
    ; WinGetTitle, WinTitle, %WinTitle%
    ; MsgBox, 窗口标题为：%WinTitle%
    ; WriteLog("win title: " . WinTitle)
    ; If WinActive("沙拉查词-独立查词窗口") {
    ;     WriteLog("enter saladcit window")
    ;     Send, !TabTab
    ;     ; Send {Alt+Tab}
    ; }
    Sleep, 800
    programs := ["SumatraPDF.exe", "mailmaster.exe"]
    If WinActive("沙拉查词-独立查词窗口") {
        ; WriteLog("enter saladcit window")
        ; MsgBox, "enter saladcit window"
        Send, {Alt Down}{Tab}
        Sleep 300
        Send, {Tab}{Alt Up}
    }
return

; ~^x::
;     If WinActive("沙拉查词-独立查词窗口") || CheckProgramActive(programs) {
;         oldClipboard := Clipboard
;         gosub, Copyon
;         Copyon:
;             Send ^c
;             Send ^+s
;             output := "clipboard: " . Clipboard
;             Clipboard := oldClipboard
;             WriteLog(output)
;             ; WriteLog("clipboard: " . %Clipboard%)
;         return
;     }
; return


SetTimer, CheckWindow, 1000

CheckWindow:
    IfWinExist, "沙拉查词-独立查词窗口"
    {
        WinSet, ExStyle, ^0x80, "沙拉查词-独立查词窗口"
    }
return