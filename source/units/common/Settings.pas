(******************************************************************************
 *                                                                            *
 *  Settings.pas -- TSettings class, class for saving and loading program     *
 *                  settings from the registry                                *
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
