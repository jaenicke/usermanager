(******************************************************************************
 *                                                                            *
 *  Network -- Some network routines                                          *
 *                                                                            *
 *  This Source Code Form is subject to the terms of the Mozilla Public       *
 *  License, v. 2.0. If a copy of the MPL was not distributed with this       *
 *  file, You can obtain one at http://mozilla.org/MPL/2.0/.                  *
 *                                                                            *
 *  Copyright (c) 2006 Michael Puff  http://www.michael-puff.de               *
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
