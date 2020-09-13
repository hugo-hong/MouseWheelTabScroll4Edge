; Mouse Wheel Tab Scroll 4 Chrome
; -------------------------------
; Scroll though Chrome tabs with your mouse wheel when hovering over the tab bar.
; If the Chrome window is inactive when starting to scroll, it will be activated.

#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn	; Enable warnings to assist with detecting common errors.
#SingleInstance force	; Determines whether a script is allowed to run again when it is already running.
#UseHook Off	; Using the keyboard hook is usually preferred for hotkeys - but here we only need the mouse hook.
#InstallMouseHook
#MaxHotkeysPerInterval 1000	; Avoids warning messages for high speed wheel users.

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
Menu, Tray, Tip, Mousewheel Tab Scroll for Chrome (1.0.4)

TabJumper(psWindowClass, piStripeYStart, piStripeYEnd)
{
    WinGet, idSearchWindow, ID, ahk_class %psWindowClass%
    MouseGetPos, iMouseX, iMouseY, idHoverWindow
    if (idSearchWindow=idHoverWindow
        && iMouseY>=piStripeYStart
        && iMouseY<=piStripeYEnd ) {
        
		IfWinNotActive ahk_id %idHoverWindow%
			WinActivate ahk_id %idHoverWindow%
		ControlFocus,, ahk_id %idHoverWindow%
			
        if RegExMatch(A_ThisHotkey, "i).*wheelup.*")
        {
            ControlSend, ahk_parent, {Control Down}{Shift Down}{Tab Down}, ahk_id %idHoverWindow%
            Sleep, 10
            ControlSend, ahk_parent, {Tab Up}{Shift Up}{Control Up}, ahk_id %idHoverWindow%
        }
        else if RegExMatch(A_ThisHotkey, "i).*wheeldown.*")
        {
            ControlSend, ahk_parent, {Control Down}{Tab Down}, ahk_id %idHoverWindow%
            Sleep, 10
            ControlSend, ahk_parent, {Tab Up}{Control Up}, ahk_id %idHoverWindow%
        }
    }
}

~WheelUp::
~WheelDown::
    TabJumper("Chrome_WidgetWin_1", 1, 45)
return