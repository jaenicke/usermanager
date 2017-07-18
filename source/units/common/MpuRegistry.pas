(******************************************************************************
 *                                                                            *
 *  Project: -                                                                *
 *  File   : Unicode Registry class                                           *
 *  20xx-xx-xx                                                                *
 *                                                                            *
 *  This Source Code Form is subject to the terms of the Mozilla Public       *
 *  License, v. 2.0. If a copy of the MPL was not distributed with this       *
 *  file, You can obtain one at http://mozilla.org/MPL/2.0/.                  *
 *                                                                            *
 *  Michael Puff  http://www.michael-puff.de                                  *
 *                                                                            *
 ******************************************************************************)

{$I CompilerSwitches.inc}

unit MpuRegistry;

interface

uses
  windows;

type
  TMpuRegistry = class(TObject)
  private
    FHostIs64: Boolean;
    FhkResult: HKEY;
    FMachine: PWideChar;
    FhKey: HKEY;
    function IsHost64Bit: Boolean;
    function GetMachine: WideString;
    function GetHKey: HKEY;
  public
//    constructor Create(const Machine: string; hKey: HKEY);
    constructor CreateW(const Machine: WideString; hKey: HKEY);
    destructor Destroy; override;
    function Connect: LongInt;
    function CreateKey(const SubKey: string): LongInt;
    function CreateKeyW(const SubKey: WideString): LongInt;
    function OpenKey(const SubKey: string; samDesired: REGSAM): LongInt;
    function OpenKeyW(const SubKey: WideString; samDesired: REGSAM): LongInt;
    function ReadInt(const ValueName: string; var Value: Integer): LongInt;
    function ReadIntW(const ValueName: WideString; var Value: Integer): LongInt;
    function ReadByte(const ValueName: string; var Value: Byte; default: Byte = 0):  LongInt;
    function ReadByteW(const ValueName: WideString; var Value: Byte; default: Byte = 0): LongInt;
    function ReadBool(const ValueName: string; var Value: Boolean; default: Boolean = True): LongInt;
    function ReadBoolW(const ValueName: string; var Value: Boolean; default: Boolean = True): LongInt;
    function ReadString(const ValueName: string; var Value: string): LongInt;
    function ReadStringW(const ValueName: WideString; var Value: WideString): LongInt;
    function WriteInt(const ValueName: string; Value: Integer): LongInt;
    function WriteIntW(const ValueName: WideString; Value: Integer): LongInt;
    function WriteByte(const ValueName: string; Value: Byte): LongInt;
    function WriteByteW(const ValueName: WideString; Value: Byte): LongInt;
    function WriteBool(const ValueName: string; Value: Boolean): LongInt;
    function WriteBoolW(const ValueName: WideString; Value: Boolean): LongInt;
    function WriteString(const ValueName: string; Value: string): LongInt;
    function WriteStringW(const ValueName: WideString; const Value: WideString): LongInt;
    function DeleteValueName(const ValueName: string): LongInt;
    function DeleteSubKey(const SubKey: string): LongInt;
    property Machine: WideString read GetMachine;
    property hKey: HKEY read GetHKey;
  end;

const
  KEY_WOW64_64KEY = $0100;

implementation

constructor TMpuRegistry.CreateW(const Machine: WideString; hKey: HKEY);
begin
  inherited Create;
  FMachine := PWideChar(Machine);
  FhKey := hKey;
  FHostIs64 := IsHost64Bit;
end;

destructor TMpuRegistry.Destroy;
begin
  RegCloseKey(FhkResult);
  inherited Destroy;
end;

///// Methods //////////////////////////////////////////////////////////////////

function TMpuRegistry.Connect: LongInt;
begin
  result := RegConnectRegistryW(FMachine, FhKey, FhkResult);
end;

function TMpuRegistry.CreateKey(const SubKey: string): LongInt;
begin
  result := CreateKeyW(SubKey);
end;

function TMpuRegistry.CreateKeyW(const SubKey: WideString): LongInt;
begin
  result := RegCreateKeyExW(FhKey, PWideChar(SubKey), 0, nil,
    REG_OPTION_NON_VOLATILE, KEY_WRITE, nil, FhkResult, nil);
end;

function TMpuRegistry.OpenKey(const SubKey: string; samDesired: REGSAM):
  LongInt;
begin
  if FHostIs64 then
    result := OpenKeyW(SubKey, samDesired or KEY_WOW64_64KEY)
  else
   result := OpenKeyW(SubKey, samDesired);
end;

function TMpuRegistry.OpenKeyW(const SubKey: WideString; samDesired: REGSAM):
  LongInt;
begin
  if FHostIs64 then
    result := RegOpenKeyExW(FhkResult, PWideChar(SubKey), 0, samDesired or KEY_WOW64_64KEY, FhkResult)
  else
    result := RegOpenKeyExW(FhkResult, PWideChar(SubKey), 0, samDesired, FhkResult);
end;

function TMpuRegistry.ReadInt(const ValueName: string; var Value: Integer):
  LongInt;
begin
  result := ReadIntW(ValueName, Value);
end;

function TMpuRegistry.ReadIntW(const ValueName: WideString; var Value: Integer):
  LongInt;
var
  cbData: Integer;
  lpType: DWORD;
begin
  // get size of required data
  result := RegQueryValueExW(FhkResult, PWideChar(ValueName), nil, @lpType, @Value,
    @cbData);
  if cbData <> 0 then
  begin
    result := RegQueryValueExW(FhkResult, PWideChar(ValueName), nil, @lpType,
      @Value, @cbData);
  end;
end;

function TMpuRegistry.ReadByte(const ValueName: string; var Value: Byte;
  default: Byte = 0): LongInt;
begin
  result := ReadByteW(ValueName, Value, default);
end;

function TMpuRegistry.ReadByteW(const ValueName: WideString; var Value: Byte;
  default: Byte = 0): LongInt;
var
  temp: Integer;
begin
  result := ReadIntW(ValueName, temp);
  if Result = ERROR_SUCCESS then
    Value := Byte(temp)
  else
    Value := default;
end;

function TMpuRegistry.ReadBool(const ValueName: string; var Value: Boolean;
  default: Boolean = True): LongInt;
begin
  Result := ReadBoolW(ValueName, Value, default);
end;

function TMpuRegistry.ReadBoolW(const ValueName: string; var Value: Boolean;
  default: Boolean = True): LongInt;
var
  temp: Integer;
begin
  Result := ReadIntW(ValueName, temp);
  if Result = ERROR_SUCCESS then
    Value := Boolean(temp)
  else
    Value := default;
end;

function TMpuRegistry.ReadString(const ValueName: string; var Value: string):
  LongInt;
var
  cbData: Integer;
  lpType: DWORD;
  Buffer: PChar;
begin
  // get size of required data
  result := RegQueryValueEx(FhkResult, PChar(ValueName), nil, @lpType, nil,
    @cbData);
  if cbData <> 0 then
  begin
    GetMem(Buffer, cbData);
    try
      result := RegQueryValueEx(FhkResult, PChar(ValueName), nil, @lpType,
        Pointer(Buffer), @cbData);
      Value := Buffer; // <- hier AccessViolation
    finally
      FreeMem(Buffer);
    end;
  end;
end;

function TMpuRegistry.ReadStringW(const ValueName: WideString;
  var Value: WideString): LongInt;
var
  cbData: Integer;
  lpType: DWORD;
  Buffer: PWideChar;
begin
  // get size of required data
  result := RegQueryValueExW(FhkResult, PWideChar(ValueName), nil, @lpType, nil,
    @cbData);
  if cbData <> 0 then
  begin
    GetMem(Buffer, cbData);
    try
      result := RegQueryValueExW(FhkResult, PWideChar(ValueName), nil, @lpType,
        Pointer(Buffer), @cbData);
      Value := Buffer;
    finally
      FreeMem(Buffer);
    end;
  end;
end;

function TMpuRegistry.WriteInt(const ValueName: string; Value: Integer): LongInt;
begin
  result := WriteIntW(ValueName, Value);
end;

function TMpuRegistry.WriteIntW(const ValueName: WideString; Value: Integer): LongInt;
begin
  result := RegSetValueExW(FhkResult, PWideChar(ValueName), 0, REG_DWORD, @Value,
    sizeof(Integer));
end;

function TMpuRegistry.WriteByte(const ValueName: string; Value: Byte): LongInt;
begin
  result := WriteIntW(ValueName, Value);
end;

function TMpuRegistry.WriteByteW(const ValueName: WideString; Value: Byte): LongInt;
begin
  result := WriteIntW(ValueName, Value);
end;

function TMpuRegistry.WriteBool(const ValueName: string; Value: Boolean): LongInt;
begin
  result := WriteInt(ValueName, ord(Value));
end;

function TMpuRegistry.WriteBoolW(const ValueName: WideString; Value: Boolean): LongInt;
begin
  result := WriteIntW(ValueName, ord(Value));
end;

function TMpuRegistry.WriteString(const ValueName: string; Value: string):
  LongInt;
begin
  result := RegSetValueEx(FhkResult, PChar(ValueName), 0, REG_SZ,
    PChar(Value), length(Value));
end;

function TMpuRegistry.WriteStringW(const ValueName: WideString; const Value: WideString):
  LongInt;
begin
  result := RegSetValueExW(FhkResult, PWideChar(ValueName), 0, REG_SZ,
    PWideChar(Value), (Length(Value) + 1) * SizeOf(WideChar));
end;

function TMpuRegistry.DeleteValueName(const ValueName: string): LongInt;
begin
  result := RegDeleteValue(FhkResult, PChar(ValueName));
end;

function TMpuRegistry.DeleteSubKey(const SubKey: string): LongInt;
begin
  result := RegDeleteKey(FhkResult, PChar(SubKey));
end;

//// Propterties ///////////////////////////////////////////////////////////////

function TMpuRegistry.GetMachine: WideString;
begin
  result := FMachine;
end;

function TMpuRegistry.GetHKey: HKEY;
begin
  result := FhKey;
end;

////////////////////////////////////////////////////////////////////////////////

function TMpuRegistry.IsHost64Bit: Boolean;
type
  TIsWow64Process = function(Handle: THandle; var Res: BOOL): BOOL; stdcall;
var
  IsWow64Result: BOOL;
  IsWow64Process: TIsWow64Process;
begin
  IsWow64Process := GetProcAddress(GetModuleHandle('kernel32'), 'IsWow64Process');
  if Assigned(IsWow64Process) then
  begin
    IsWow64Process(GetCurrentProcess, IsWow64Result);
    Result := IsWow64Result;
  end
  else
    // Function not implemented: can't be running on Wow64
    Result := False;
end;

end.
