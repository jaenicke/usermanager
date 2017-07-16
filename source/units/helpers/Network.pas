(******************************************************************************
 *                                                                            *
 *  Network -- Some network routines                                          *
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

{$I ..\..\CompilerSwitches.inc}

unit Network;

interface

uses
  Windows;

function ConnectToNetworkDriveW(LocalName: WideString; RemoteName: wideString; Username: WideString; Password: WideString;
  RestoreAtLogon: boolean): DWORD;
function DisconnectNetworkDrivew(Name: WideString): DWORD;

implementation

function ConnectToNetworkDriveW(LocalName: WideString; RemoteName: wideString; Username: WideString; Password: WideString;
  RestoreAtLogon: boolean): DWORD;
var
  NetResource       : TNetResourceW;
  dwFlags           : DWORD;
begin
  dwFlags := 0;
  ZeroMemory(@NetResource, sizeof(TNetResource));
  with NetResource do
  begin
    dwType := RESOURCETYPE_ANY;
    lpLocalName := PWideChar(LocalName);
    lpRemoteName := PwideChar(RemoteName);
    lpProvider := nil;
  end;

  if (RestoreAtLogon) then
    dwFlags := dwFlags or CONNECT_UPDATE_PROFILE;

  Result := WNetAddConnection2W(NetResource, PWideChar(Password), PWideChar(Username), dwFlags);
end;

function DisconnectNetworkDrivew(Name: WideString): DWORD;
begin
  result := WNetCancelConnection2W(PWideChar(Name), CONNECT_UPDATE_PROFILE, True);
end;

end.
