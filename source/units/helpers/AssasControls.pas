unit AssasControls;
(******************************************************************************
 ******************************************************************************
 ***                                                                        ***
 ***   Special controls (class registrations)                               ***
 ***   Version [2.00a]                               {Last mod 2005-07-03}  ***
 ***                                                                        ***
 ******************************************************************************
 ******************************************************************************

                                 _\\|//_
                                (` * * ')
 ______________________________ooO_(_)_Ooo_____________________________________
 ******************************************************************************
 ******************************************************************************
 ***                                                                        ***
 ***                Copyright (c) 1995 - 2005 by -=Assarbad=-               ***
 ***                                                                        ***
 ***   CONTACT TO THE AUTHOR(S):                                            ***
 ***    ____________________________________                                ***
 ***   |                                    |                               ***
 ***   | -=Assarbad=- aka Oliver            |                               ***
 ***   |____________________________________|                               ***
 ***   |                                    |                               ***
 ***   | Assarbad@gmx.info|.net|.com|.de    |                               ***
 ***   | ICQ: 281645                        |                               ***
 ***   | AIM: nixlosheute                   |                               ***
 ***   |      nixahnungnicht                |                               ***
 ***   | MSN: Assarbad@ePost.de             |                               ***
 ***   | YIM: sherlock_holmes_and_dr_watson |                               ***
 ***   |____________________________________|                               ***
 ***             ___                                                        ***
 ***            /   |                     ||              ||                ***
 ***           / _  |   ________ ___  ____||__    ___   __||                ***
 ***          / /_\ |  / __/ __//   |/  _/|   \  /   | /   |                ***
 ***         / ___  |__\\__\\  / /\ || |  | /\ \/ /\ |/ /\ | DOT NET        ***
 ***        /_/   \_/___/___/ /_____\|_|  |____/_____\\__/\|                ***
 ***       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~        ***
 ***              [http://assarbad.net | http://assarbad.org]               ***
 ***                                                                        ***
 ***   Notes:                                                               ***
 ***   - my first name is Oliver, you may well use this in your e-mails     ***
 ***   - for questions and/or proposals drop me a mail or instant message   ***
 ***                                                                        ***
 ***~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~***
 ***              May the source be with you, stranger ... ;)               ***
 ***    Snizhok, eto ne tolko fruktovij kefir, snizhok, eto stil zhizn.     ***
 ***                     Vsem Privet iz Germanij                            ***
 ***                                                                        ***
 *** Greets from -=Assarbad=- fly to YOU =)                                 ***
 *** Special greets fly 2 Nico, Casper, SA, Pizza, Navarion, Eugen, Zhenja, ***
 *** Xandros, Melkij, Strelok etc pp.                                       ***
 ***                                                                        ***
 *** Thanks to:                                                             ***
 *** W.A. Mozart, Vivaldi, Beethoven, Poeta Magica, Kurtzweyl, Manowar,     ***
 *** Blind Guardian, Weltenbrand, In Extremo, Wolfsheim, Carl Orff, Zemfira ***
 *** ... most of my work was done with their music in the background ;)     ***
 ***                                                                        ***
 ******************************************************************************
 ******************************************************************************

                                 _\\|//_
                                (` * * ')
 ______________________________ooO_(_)_Ooo_____________________________________
 LEGAL STUFF:
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 Copyright (c) 1995-2005, Oliver Schneider (Assarbad)
 All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:
 1. Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.
 2. Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.
 3. All advertising materials mentioning features or use of this software
    must display the following acknowledgement:
        This product includes software developed by Oliver Schneider
        [ http://assarbad.net ] or other contributors
 4. Neither the name of Oliver Schneider (Assarbad) nor the names of the
    contributors may be used to endorse or promote products derived
    from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
                             .oooO     Oooo.
 ____________________________(   )_____(   )___________________________________
                              \ (       ) /
                               \_)     (_/

 ******************************************************************************)

(******************************************************************************
  Version History:
  ----------------

  v.2.00a [2005-07-03]
  - Mini-Bugfix for WM_SETFONT/WM_GETFONT
  v.2.00 [2005-07-02]
  - Complete rewrite of the scroller control. Button has been kicked for now.
    Will be added back lateron as it functions really perfectly!
  v.1.01 [2003-05-11]
  - Moved the timer stuff into an extra thread ... makes some things easier, e.g.
    changing the scroll duration ;)
  v.1.00 [2003-05-10]
  - Initial release. Just the basic functionality of the TAboutScroller control.
 ******************************************************************************)

(******************************************************************************
  Abstract:
  --------

  The controls contained herein may be used in dialog boxes or windows of any
  kind. For dialog boxes it's even possible to put it into the dialog resource.
  Note, that only the unit needs to be included in this case. The controls try
  to resemble the functionality of certain controls, while extending their
  features.
  The controls register the window classes automatically during initialization
  of the unit. So the controls can be freely used in dialogs and enything else.

  Note: You may define or undefine the different controls just as needed through
        the use of preprocessor definitions.

  Available controls:

  "TAboutScroller"
  I use this one in my About dialogs of my applications. You can't touch it, it
  just behaves like a static. But you can change its fore- and background colors,
  set text using the functions you would use for a normal "Static" ... and it
  will scroll the text inside its window area :) from bottom up.
  Limitations: Scroll direction is always upwards!

 ******************************************************************************)

{$I ..\..\CompilerSwitches.inc}


interface
{$DEFINE TABOUTSCROLLER} // Scrolls the text one sets to it.
uses
  Windows,
  Messages;

const
  CM_COMMONBASE = 1000;
{$IFDEF TABOUTSCROLLER}
  CM_SCROLLBASE = 1101;
{$ENDIF} // TABOUTSCROLLER

  // Not declared in Delphi 4
  DT_NOFULLWIDTHCHARBREAK = $00080000;
  DT_HIDEPREFIX = $00100000;
  DT_PREFIXONLY = $00200000;

(******************************************************************************
  Public constants

  WINDOW MESSAGES COMMON TO ALL CUSTOM CONTROLS
 ******************************************************************************)

  // Returns the foreground color. Return value should be casted to COLORREF
  WM_ASSAGETFGCOLOR = WM_USER + CM_COMMONBASE + 1;
  // Returns the foreground color. Return value should be casted to COLORREF
  WM_ASSAGETBGCOLOR = WM_USER + CM_COMMONBASE + 2;
  // Sets the foreground color value and causes a reset of the scroller
  // The COLORREF value is to be passed via wParam
  WM_ASSASETFGCOLOR = WM_USER + CM_COMMONBASE + 3;
  // Sets the background color value and causes a reset of the scroller
  // The COLORREF value is to be passed via wParam
  WM_ASSASETBGCOLOR = WM_USER + CM_COMMONBASE + 4;
  // Sets both, background and foreground, colors.
  // wParam holds the foreground and lParam the background color as COLORREF
  WM_ASSASETCOLORS = WM_USER + CM_COMMONBASE + 5;

{$IFDEF TABOUTSCROLLER}
const
(******************************************************************************
  Window class name and more
 ******************************************************************************)
  szTAboutScroller = 'TAboutScroller';
  // Default delay for the scroller control
  ScrollDefaultDelay = 95;
  // Default style for DrawText
  ScrollDefaultDrawstyle = DT_NOPREFIX or DT_WORDBREAK or DT_CENTER;

(******************************************************************************
  Public constants

  WINDOW MESSAGES FOR THE SCROLLER CONTROL
 ******************************************************************************)

  // This is an internal message which is only used by the thread to notify the
  // scroller control to perform an update. Should not be called from outside.
  // It is however, left in the interface part to allow for it!
  WM_ASSAREFRESHSCROLL = WM_USER + CM_SCROLLBASE + 0;
  // Set the delay of the scroller. This will NOT reset the scroller.
  WM_ASSASETSCROLLDELAY = WM_USER + CM_SCROLLBASE + 1;
  // Get the delay of the scroller as result (cast to DWORD).
  WM_ASSAGETSCROLLDELAY = WM_USER + CM_SCROLLBASE + 2;
  // Set the draw style of the text in the scroller. This should be any
  // combination of the following DrawText() flags:
  // DT_CENTER
  // DT_EDITCONTROL
  // DT_EXPANDTABS
  // DT_HIDEPREFIX
  // DT_LEFT
  // DT_NOFULLWIDTHCHARBREAK
  // DT_NOPREFIX
  // DT_PREFIXONLY
  // DT_RIGHT
  // DT_RTLREADING
  // DT_WORDBREAK
  WM_ASSASETDRAWSTYLE = WM_USER + CM_SCROLLBASE + 3;
  WM_ASSAGETDRAWSTYLE = WM_USER + CM_SCROLLBASE + 4;

  // Use WM_SETFONT to change the text font in the scroller!!!
{$ENDIF} // TABOUTSCROLLER

implementation

var
  IsNT: Boolean = False;
  MaxTextLen: Integer = 8192;

{$IFDEF TABOUTSCROLLER}
type
(******************************************************************************
  This structure contains configuration information about the scroller control
 ******************************************************************************)
  PScrollConfig = ^TScrollConfig;
  TScrollConfig = record
    Position: Integer;
    FgCol,
      BgCol: COLORREF;
    ScrollDuration: DWORD;
    MainWnd: HWND;
    Bmp: HBITMAP;
    BgBrush: HBRUSH;
    Font: HFONT;
    IsDirty: Boolean; // For more sophisticated WM_ERASEBACKGROUND handling (not used)
    ClientRC: TRect;
    BitmapRC: TRect;
    DrawStyle: DWORD;
    TextHeight: Integer;
    TextBuffer: PChar;
    Thread: THandle;
    ThreadID: DWORD;
  end;

(******************************************************************************
  This thread function exists to keep CPU usage low and still keep the scroll
  control scrolling.
 ******************************************************************************)

function ScrollThread(psc: PScrollConfig): DWORD; stdcall;
begin
  // As long as a main window is assigned
  while (psc^.MainWnd <> 0) do
  begin
    // Increment position
    InterlockedIncrement(psc^.Position);
    // Send the change request to the window
    SendMessage(psc^.MainWnd, WM_ASSAREFRESHSCROLL, 0, 0);
    // Sleep until next refresh cycle
    Sleep(psc^.ScrollDuration);
  end;
  // Make sure no one else will use the pointer
  SetWindowLong(psc^.MainWnd, GWL_USERDATA, Integer(0));
  // Finally free the text buffer
  GlobalFree(THandle(psc^.TextBuffer));
  // Delete GDI objects
  DeleteObject(psc^.Bmp);
  DeleteObject(psc^.BgBrush);
  // And the config struct itself
  GlobalFree(THandle(psc));
  result := Ord(True);
end;

(******************************************************************************
  This function cares to initialize the contents of the intermediate bitmap.
 ******************************************************************************)

function InitializeBitmap(psc: PScrollConfig): Boolean;
var
  MemDC, hDC: THandle;
  oldBmp: HBITMAP;
  oldTop: Integer;
begin
  // Delete any old bitmap (if exists)
  if (psc^.Bmp <> 0) then
    DeleteObject(psc^.Bmp);
  hDC := GetDC(psc^.MainWnd);
  MemDC := CreateCompatibleDC(hDC);
  CopyMemory(@psc^.BitmapRC, @psc^.ClientRC, SizeOf(TRect));
  SelectObject(MemDC, psc^.Font);
  // Font background color is not drawn
  SetBkMode(MemDC, TRANSPARENT);
  // Set text color as expected
  SetTextColor(MemDC, psc^.FgCol);
  // Actually draw the text onto the DC, trying to determine the required rect!
  DrawText(MemDC, psc^.TextBuffer, lstrlen(psc^.TextBuffer), psc^.BitmapRC, psc^.DrawStyle or DT_CALCRECT);
  // Adjust rect
  psc^.BitmapRC.Left := psc^.ClientRC.Left;
  psc^.BitmapRC.Right := psc^.ClientRC.Right;
  // We need enough space for two times the window height + the calculated text height
  psc^.TextHeight := (psc^.BitmapRC.Bottom - psc^.BitmapRC.Top);
  psc^.BitmapRC.Bottom := psc^.TextHeight + (2 * (psc^.ClientRC.Bottom - psc^.ClientRC.Top));
  psc^.BitmapRC.Top := 0;
  // Create compatible bitmap
  psc^.Bmp := CreateCompatibleBitmap(hDC, psc^.BitmapRC.Right - psc^.BitmapRC.Left, psc^.BitmapRC.Bottom - psc^.BitmapRC.Top);
  // Release original DC
  ReleaseDC(psc^.MainWnd, hDC);
  // Select our nely created bitmap into the DC
  oldBmp := SelectObject(MemDC, psc^.Bmp);
  // Fill with background color
  FillRect(MemDC, psc^.BitmapRC, psc^.BgBrush);
  // Draw real text
  oldTop := psc^.BitmapRC.Top; // Save top value
  psc^.BitmapRC.Top := (psc^.ClientRC.Bottom - psc^.ClientRC.Top);
  result := (DrawText(MemDC, psc^.TextBuffer, lstrlen(psc^.TextBuffer), psc^.BitmapRC, psc^.DrawStyle or DT_NOCLIP) <> 0);
  psc^.BitmapRC.Top := oldTop;
  // Select old back into the DC
  // -> SelectObject(MemDC, oldFont); // obsolete, the DC is deleted anyway
  SelectObject(MemDC, oldBmp); // required to unselect our bitmap!!!
  // Delete DC
  DeleteDC(MemDC);
  // Reset position
  psc^.Position := 0;
  // It is dirty now
  psc^.IsDirty := result;
end;

(******************************************************************************
  This is the WndProc of the scroller control
 ******************************************************************************)

function TAboutScroller_WindowProc(hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  ps: TPaintStruct;
  DC, MemDC: HDC;
  oldbmp: HBITMAP;
  temprect: TRect;
  psc: PScrollConfig;
begin
  result := 0;
  // Retrieve pointer to window config
  psc := PScrollConfig(GetWindowLong(hwnd, GWL_USERDATA));
  // Check whether memory has been allocated
  if (not Assigned(psc)) then
    psc := PScrollConfig(GlobalAlloc(GPTR, sizeof(TScrollConfig)));
  // If memory could not be allocated we'll simply do default-handling
  if (not Assigned(psc)) then
  begin
    result := DefWindowProc(hwnd, uMsg, wParam, lParam);
    Exit;
  end;
  // Handle window messages
  case uMsg of
    WM_CREATE:
      begin
        // Set up the structure that holds control specific data
        SetWindowLong(hwnd, GWL_USERDATA, Integer(psc));
        // Initialise the scroll position and the scroller thread
        psc^.FgCol := COLOR_BTNTEXT;
        psc^.BgCol := GetSysColor(COLOR_BTNFACE);
        psc^.BgBrush := CreateSolidBrush(psc^.BgCol);
        psc^.ScrollDuration := ScrollDefaultDelay; // default scroll duration
        psc^.MainWnd := hwnd; // This is our own handle
        psc^.IsDirty := True;
        psc^.DrawStyle := ScrollDefaultDrawstyle;
        psc^.TextBuffer := PChar(GlobalAlloc(GPTR, MaxTextLen));
        // After the thread was created it owns the structure!
        psc^.Thread := CreateThread(
          nil,
          0,
          @ScrollThread,
          psc,
          0,
          psc^.ThreadID);
      end;
    WM_DESTROY:
      begin
        // Terminate the scroller thread, friendly method to do this
        // From this value the thread knows it should terminate and free the
        // config struct.
        psc^.MainWnd := 0;
      end;
    WM_ERASEBKGND:
      begin
        // Prevent flickering
        result := Ord(True);
      end;
    WM_NCHITTEST:
      begin
        // Untouchable control ;) ... this guarantees that the click handling of
        // the owning window will be used (for example to drag the owning window)
        result := HTTRANSPARENT;
      end;
    WM_GETTEXT:
      begin
        // Check pointer and copy then
        if (not IsBadWritePtr(PChar(lParam), wParam)) then
          lstrcpyn(PChar(lParam), psc^.TextBuffer, wParam);
      end;
    WM_SETTEXT:
      begin
        // Check pointer and copy then
        if (not IsBadWritePtr(psc^.TextBuffer, MaxTextLen)) then
        begin
          lstrcpyn(psc^.TextBuffer, PChar(lParam), MaxTextLen - 1);
          // New text requires refresh of the whole control
          InitializeBitmap(psc);
        end;
      end;
    WM_SIZE:
      begin
        // Default handling
        result := DefWindowProc(hwnd, uMsg, wParam, lParam);
        GetClientRect(hwnd, psc^.ClientRC);
        // New size requires refresh of the whole control
        InitializeBitmap(psc);
      end;
    WM_SETFONT:
      begin
        // Default handling
        psc^.Font := HFONT(wParam);
        // New font requires refresh of the whole control
        InitializeBitmap(psc);
        if(lParam <> 0)then
          SendMessage(hwnd, WM_ASSAREFRESHSCROLL, 0, 0);
      end;
    WM_GETFONT:
      begin
        result := psc^.Font;
      end;
    WM_PAINT:
      begin
        // Get extent of this window ...
        CopyMemory(@temprect, @psc^.ClientRC, SizeOf(TRect));
        // Start painting ...
        DC := BeginPaint(hwnd, ps);
        // Create memory DC
        MemDC := CreateCompatibleDC(DC);
        // Select our bitmap into DC
        oldBMP := SelectObject(MemDC, psc^.Bmp);
        // Select font into DC ...
        SelectObject(memDC, SendMessage(hwnd, WM_GETFONT, 0, 0));
        // Copy the memory DC contents onto the "real" window DC
        BitBlt(ps.hDC, psc^.ClientRC.Left, psc^.ClientRC.Top, psc^.ClientRC.Right - psc^.ClientRC.Left,
          psc^.ClientRC.Bottom - psc^.ClientRC.Top, MemDC,
          temprect.Left, psc^.Position, SRCCOPY);
        // Cleanup bitmap, release our bitmap from DC
        SelectObject(MemDC, oldbmp);
        // Cleanup memory DC
        DeleteDC(MemDC);
        // Finish this ...
        EndPaint(hwnd, ps);
      end;
    WM_ASSAGETFGCOLOR:
      begin
        // Return foreground color
        result := psc^.FgCol;
      end;
    WM_ASSAGETBGCOLOR:
      begin
        // Return background color
        result := psc^.BgCol;
      end;
    WM_ASSASETFGCOLOR:
      begin
        // Set foreground color
        psc^.FgCol := COLORREF(wParam);
        // New foreground color requires refresh of the whole control
        InitializeBitmap(psc);
      end;
    WM_ASSASETBGCOLOR:
      begin
        // Set background color
        psc^.BgCol := COLORREF(wParam);
        // Delete old GDI brush
        DeleteObject(psc^.BgBrush);
        // Create new one from the given color
        psc^.BgBrush := CreateSolidBrush(psc^.BgCol);
        // New background color (and brush) requires refresh of the whole control
        InitializeBitmap(psc);
      end;
    WM_ASSASETCOLORS:
      begin
        // Set foreground and background color
        psc^.FgCol := COLORREF(wParam);
        psc^.BgCol := COLORREF(lParam);
        // Delete old GDI brush
        DeleteObject(psc^.BgBrush);
        // Create new one from the given color
        psc^.BgBrush := CreateSolidBrush(psc^.BgCol);
        // New colors requires refresh of the whole control
        InitializeBitmap(psc);
      end;
    WM_ASSAREFRESHSCROLL:
      begin
        psc^.IsDirty := True;
        // Reset to start of text
        if (psc^.Position > (psc^.ClientRC.Bottom - psc^.ClientRC.Top) + psc^.TextHeight) then
          psc^.Position := 0;
        // Invalidate and force refresh
        InvalidateRect(hwnd, nil, True);
      end;
    WM_ASSASETSCROLLDELAY: // in DWORD(wParam)
      begin
        // Set new scroll delay
        psc^.ScrollDuration := DWORD(wParam);
      end;
    WM_ASSAGETSCROLLDELAY:
      begin
        // Get current scroll delay
        result := psc^.ScrollDuration;
      end;
    WM_ASSASETDRAWSTYLE: // in DWORD(wParam)
      begin
        // Set new draw style
        psc^.DrawStyle := DWORD(wParam) and (DT_CENTER or
          DT_EDITCONTROL or
          DT_EXPANDTABS or
          DT_HIDEPREFIX or
          DT_LEFT or
          DT_NOFULLWIDTHCHARBREAK or
          DT_NOPREFIX or
          DT_PREFIXONLY or
          DT_RIGHT or
          DT_RTLREADING or
          DT_WORDBREAK);
        // New draw style requires refresh of the whole control
        InitializeBitmap(psc);
      end;
    WM_ASSAGETDRAWSTYLE:
      begin
        // Get current draw style
        result := psc^.DrawStyle;
      end;
  else
    // Default handling for everything else
    result := DefWindowProc(hwnd, uMsg, wParam, lParam);
  end;
end;
{$ENDIF}

var
  // Already initialised values
  scr_class: WNDCLASSEX = (
    cbSize: sizeof(WNDCLASSEX);
    style: CS_OWNDC;
    lpfnWndProc: @TAboutScroller_WindowProc;
    cbClsExtra: 0;
    cbWndExtra: 0;
    hInstance: 0;
    hIcon: 0;
    hCursor: 0;
    hbrBackground: COLOR_BTNFACE + 1;
    hIconSm: 0;
    );

initialization
  // On NT we allow more than the default 8192 characters of text
  IsNt := (GetVersion() and $80000000) = 1;
  if (IsNt) then
    MaxTextLen := 64 * 1024;
{$IFDEF TABOUTSCROLLER}
  // Register a new window class for the scroller control
  scr_class.lpszMenuName := nil;
  scr_class.lpszClassName := szTAboutScroller;
  RegisterClassEx(scr_class);
{$ENDIF}
finalization
{$IFDEF TABOUTSCROLLER}
  UnRegisterClass(szTAboutScroller, 0);
{$ENDIF}
end.

