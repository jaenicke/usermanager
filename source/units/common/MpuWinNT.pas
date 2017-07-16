(******************************************************************************
 *                                                                            *
 *  MpuWinNT.pas -- Contains header translations from WinNT.h and LM.h and    *
 *                  functions only available on Windows NT and higher         *
 *                                                                            *
 *  Copyright (c) 2006 Michael Puff  http://www.michael-puff.de               *
 *                                                                            *
 ******************************************************************************)

 (*****************************************************************************
 *                                                                            *
 *                         COPYRIGHT NOTICE                                   *
 *                                                                            *
 *  Copyright (c) 2001-2006, Michael Puff ["copyright holder(s)"]             *
 *  All rights reserved.                                                      *
 *                                                                            *
 *  Redistribution and use in source and binary forms, with or without        *
 *  modification, are permitted provided that the following conditions        *
 *  are met:                                                                  *
 *                                                                            *
 *  1. Redistributions of source code must retain the above copyright         *
 *     notice, this list of conditions and the following disclaimer.          *
 *  2. Redistributions in binary form must reproduce the above copyright      *
 *     notice, this list of conditions and the following disclaimer in        *
 *     the documentation and/or other materials provided with the             *
 *     distribution.                                                          *
 *  3. The name(s) of the copyright holder(s) may not be used to endorse      *
 *     or promote products derived from this software without specific        *
 *     prior written permission.                                              *
 *                                                                            *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS       *
 *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT         *
 *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS         *
 *  FORA PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE             *
 *  REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,               *
 *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,      *
 *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;          *
 *  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER          *
 *  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT        *
 *  LIABILITY, OR TORT INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY      *
 *  WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE               *
 *  POSSIBILITY OF SUCH DAMAGE.                                               *
 *                                                                            *
 ******************************************************************************)

{$WARN SYMBOL_PLATFORM OFF}

{$I CompilerSwitches.inc}

unit MpuWinNT;

interface

uses
  windows;

type
  LPBYTE = PBYTE;

///// XP Themes ///////////////////////////////////////////////////////////////////
type
  TEnableThemeDialogTexture = function(wnd: HWND; dwFlags: dword): HRESULT; stdcall;

const
  ETDT_ENABLE       = $00000002;
  ETDT_USETABTEXTURE = $00000004;

///// CreateProcess //////////////////////////////////////////////////////////////

type
  TStartupInfoW = record
    cb: DWORD;
    lpReserved: LPWSTR;
    lpDesktop: LPWSTR;
    lpTitle: LPWSTR;
    dwX: DWORD;
    dwY: DWORD;
    dwXSize: DWORD;
    dwYSize: DWORD;
    dwXCountChars: DWORD;
    dwYCountChars: DWORD;
    dwFillAttribute: DWORD;
    dwFlags: DWORD;
    wShowWindow: WORD;
    cbReserved2: WORD;
    lpReserved2: LPBYTE;
    hStdInput: THANDLE;
    hStdOutput: THANDLE;
    hStdError: THANDLE;
  end;
  PStartupInfoW = ^TStartupInfoW;

  PPROCESS_INFORMATION = ^PROCESS_INFORMATION;
{$EXTERNALSYM PPROCESS_INFORMATION}
  TProcessInformation = record
    hProcess: THandle;
    hThread: THandle;
    dwProcessId: DWORD;
    dwThreadId: DWORD;
  end;
  PProcessInformation = ^TProcessInformation;

const
  STARTF_USESHOWWINDOW = $00000001;
  STARTF_USESIZE    = $00000002;
  STARTF_USEPOSITION = $00000004;
  STARTF_USECOUNTCHARS = $00000008;
  STARTF_USEFILLATTRIBUTE = $00000010;
  STARTF_RUNFULLSCREEN = $00000020;
  STARTF_FORCEONFEEDBACK = $00000040;
  STARTF_FORCEOFFFEEDBACK = $00000080;
  STARTF_USESTDHANDLES = $00000100;
  STARTF_USEHOTKEY  = $00000200;

  LOGON_WITH_PROFILE = $00000001;
  LOGON_NETCREDENTIALS_ONLY = $00000002;
  LOGON_ZERO_PASSWORD_BUFFER = DWORD($80000000);

  CREATE_DEFAULT_ERROR_MODE = $04000000;
  CREATE_NEW_CONSOLE = $00000010;
  CREATE_NEW_PROCESS_GROUP = $00000200;
  CREATE_SEPARATE_WOW_VDM = $00000800;
  CREATE_SUSPENDED  = $00000004;
  CREATE_UNICODE_ENVIRONMENT = $00000400;

////////////////////////////////////////////////////////////////////////////////

/// CreateTimerQueueTimer //////////////////////////////////////////////////////

type
  WAITORTIMERCALLBACKFUNC = procedure(P: Pointer; B: ByteBool); stdcall;
  WAITORTIMERCALLBACK = WAITORTIMERCALLBACKFUNC;

function CreateProcessWithLogonW(lpUsername, lpDomain, lpPassword: LPWSTR;
  dwLogonFlags: dword; lpApplicationName, lpCommandLine: LPWSTR;
  dwCreationFlags: dword; lpEnvironment: pointer;
  lpCurrentDirectory: LPWSTR; lpStartupInfo: PStartUpInfoW;
  lpProcessInfo: PProcessInformation): boolean; stdcall; external 'advapi32.dll';
function CreateTimerQueueTimer(var phNewTimer: THandle; TimerQueue: THandle;
  Callback: WAITORTIMERCALLBACK; Parameter: Pointer; DueTime, Period: DWORD;
  Flags: ULONG): BOOL; stdcall;
function DeleteTimerQueueTimer(TimerQueue, Timer, CompletionEvent: THandle): BOOL; stdcall;

/// MessageboxCheck ///////////////////////////////////////////////////////////

function MessageBoxCheck(hWnd: THandle; Text: PChar; Title: PChar; dwType: DWORD; Default: Integer; RegVal: PChar):
  Integer; stdcall;

function LoadThemeDLL(wnd: hWnd; dwFlags: DWord): Boolean;
function EnablePrivilege(const Privilege: string; fEnable: Boolean; out PreviousState: Boolean): DWORD;

implementation

const
  netapi32lib       = 'netapi32.dll';
  advapi32          = 'advapi32.dll';
  shlwapi           = 'shlwapi.dll';
  xptheme           = 'uxtheme.dll';

function LoadThemeDLL(wnd: hWnd; dwFlags: DWord): Boolean;
var
  EnableThemeDlgText: TEnableThemeDialogTexture;
  hThemeDll         : THandle;
  DllResult         : HRESULT;
begin
  Result := False;
  hThemeDll := LoadLibrary(xptheme);
  if hThemeDll <> 0 then
  begin
    @EnableThemeDlgText := GetProcAddress(hThemeDll, 'EnableThemeDialogTexture');
    if @EnableThemeDlgText <> nil then
    begin
      DllResult := EnableThemeDlgText(wnd, dwFlags);
      Result := DllResult = S_OK;
    end;
    FreeLibrary(hThemeDll);
  end;
end;

function MessageBoxCheck; external shlwapi index 185;

function CreateTimerQueueTimer; external 'kernel32.dll' name 'CreateTimerQueueTimer';
function DeleteTimerQueueTimer; external 'kernel32.dll' name 'DeleteTimerQueueTimer';

function EnablePrivilege(const Privilege: string; fEnable: Boolean; out PreviousState: Boolean): DWORD;
var
  Token             : THandle;
  NewState          : TTokenPrivileges;
  Luid              : TLargeInteger;
  PrevState         : TTokenPrivileges;
  Return            : DWORD;
begin
  SetLastError(0); // Clear last system error state
  PreviousState := True;
  if (GetVersion() > $80000000) then // Win9x
    Result := ERROR_SUCCESS
  else // WinNT
  begin
    if OpenProcessToken(GetCurrentProcess(), MAXIMUM_ALLOWED, Token) then
    begin
      try
        if LookupPrivilegeValue(nil, PChar(Privilege), Luid) then
        begin
          NewState.PrivilegeCount := 1;
          NewState.Privileges[0].Luid := Luid;
          if fEnable then
            NewState.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED
          else
            NewState.Privileges[0].Attributes := 0;
          if AdjustTokenPrivileges(Token, False, NewState, SizeOf(TTokenPrivileges), PrevState, Return) then
          begin
            PreviousState := (PrevState.Privileges[0].Attributes and SE_PRIVILEGE_ENABLED <> 0);
          end;
        end;
      finally
        CloseHandle(Token);
      end;
    end;
    Result := GetLastError;
  end;
end;

end.

