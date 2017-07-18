(******************************************************************************
 *                                                                            *
 *  Settings.pas -- TSettings class, class for saving and loading program     *
 *                  settings from the registry                                *
 *                                                                            *
 *  This Source Code Form is subject to the terms of the Mozilla Public       *
 *  License, v. 2.0. If a copy of the MPL was not distributed with this       *
 *  file, You can obtain one at http://mozilla.org/MPL/2.0/.                  *
 *                                                                            *
 *  Copyright (c) 2006 Michael Puff  http://www.michael-puff.de               *
 *                                                                            *
 ******************************************************************************)

{$I CompilerSwitches.inc}

unit Settings;

interface

uses
  Windows, MpuRegistry, MpuTools, Exceptions;

type
  TSettings = class(TObject)
  private
    FReg: TMpuRegistry;
    function GetShowUsers: Boolean;
    procedure SetShowUsers(ShowUsers: Boolean);
    function GetExpandAll: Boolean;
    procedure SetExpandAll(ExpandAll: Boolean);
  public
    constructor Create(const Machine: WideString; hKey: HKEY);
    destructor Destroy; override;
    property ShowUsers: Boolean read GetShowUsers write SetShowUsers;
    property ExpandAll: Boolean read GetExpandAll write SetExpandAll;
  end;

const
  REGKEY = 'Software\MichaelPuff\XPUsermanager';
  REGEXPANDALL = 'Expand';
  REGSHOWTYPE = 'ShowType';

implementation

{ TSettings }

constructor TSettings.Create(const Machine: WideString; hKey: HKEY);
begin
  FReg := TMpuRegistry.CreateW(Machine, hKey);
end;

destructor TSettings.Destroy;
begin
  FReg.Free;
end;

function TSettings.GetExpandAll: Boolean;
var
  err: DWORD;
begin
  result := False;

  err := FReg.Connect;
  if err <> 0 then
    raise Exception.Create(SysErrorMessage(err), err);

  err := FReg.OpenKeyW(REGKEY, KEY_READ);
  if err = 0 then
    FReg.ReadBoolW(REGEXPANDALL, result, False);
end;

function TSettings.GetShowUsers: Boolean;
var
  err: DWORD;
begin
  result := True;
  err := FReg.Connect;
  if err <> 0 then
    raise Exception.Create(SysErrorMessage(err), err);

  err := FReg.OpenKeyW(REGKEY, KEY_READ);
  if err = 0 then
    FReg.ReadBoolW(REGSHOWTYPE, result, True);
end;

procedure TSettings.SetExpandAll(ExpandAll: Boolean);
var
  err: DWORD;
begin
  err := FReg.Connect;
  if err <> 0 then
    raise Exception.Create(SysErrorMessage(err), err);

  err := FReg.CreateKeyW(REGKEY);
  if err = 0 then
    FReg.WriteBoolW(REGEXPANDALL, ExpandAll)
  else
    raise Exception.Create(SysErrorMessage(err), err);
end;

procedure TSettings.SetShowUsers(ShowUsers: Boolean);
var
  err: DWORD;
begin
  err := FReg.Connect;
  if err <> 0 then
    raise Exception.Create(SysErrorMessage(err), err);

  err := FReg.CreateKeyW(REGKEY);
  if err = 0 then
    FReg.WriteBoolW(REGSHOWTYPE, ShowUsers)
  else
    raise Exception.Create(SysErrorMessage(err), err);
end;

end.
