(******************************************************************************
 *                                                                            *
 *  Usermanager                                                               *
 *  Exceptions -- Exception classes                                           *
 *                                                                            *
 *  Author: Manuel Pöter                                                      *
 *                                                                            *
 *  Copyright (c) 2006 Michael Puff  http://www.michael-puff.de               *
 *                                                                            *
 ******************************************************************************)

{$I ..\..\CompilerSwitches.inc}

unit Exceptions;

interface

uses
  Windows;

type
  Exception = class
  protected
    FMsg: WideString;
    FCode: DWord;
  public
    constructor Create(const msg: WideString); overload;
    constructor Create(const msg: WideString; Errorcode: DWord); overload;
    constructor CreateFmt(Msg: WideString; const Args: array of TVarRec);
    class function NetErrorStr(dwNetError: DWORD): WideString;
    property Message: WideString read FMsg;
    property Errorcode: DWord read FCode;
  end;

  EArgumentNull = class(Exception)
  public
    constructor Create(const parameter: String);
  end;

  EArgumentOutOfRange = class(Exception)
  public
    constructor Create(const parameter: String; const value);
  end;

  ENetAPIError = class(Exception)
  public
    constructor Create(Errorcode: DWord);
  end;

implementation

uses
  NetAPI,
  MpuTools;

////////////////////////////////////////////////////////////////////////////////
// Procedure : Format
// Comment   : Formats a widestring according to the formatdiscriptors
function FormatW(const S: WideString; const Args: array of const): WideString;
var
  StrBuffer2        : array[0..1023] of WideChar;
  A                 : array[0..15] of LongWord;
  i                 : Integer;
begin
  for i := High(Args) downto 0 do
    A[i] := Args[i].VInteger;
  wvsprintfW(@StrBuffer2, PWideChar(S), @A);
  Result := PWideChar(@StrBuffer2);
end;

function SysErrorMessage(ErrorCode: Integer): WideString;
var
  Len               : Integer;
  Buffer            : array[0..255] of WideChar;
begin
  Len := FormatMessageW(FORMAT_MESSAGE_FROM_SYSTEM or FORMAT_MESSAGE_ARGUMENT_ARRAY,
    nil, ErrorCode, 0, Buffer, SizeOf(Buffer), nil);
  SetString(Result, Buffer, Len);
end;

class function Exception.NetErrorStr(dwNetError: DWORD): WideString;
resourcestring
  rsERROR_ACCESS_DENIED = 'Zugriff verweigert';
  rsERROR_INVALID_PARAMETER = 'Ungültiger Parameter';
  rsNERR_InvalidComputer = 'Ungültiger Computer';
  rsNERR_NotPrimary =
    'Operation darf nur auf dem Domain-Controller ausgeführt werden';
  rsNERR_SpeGroupOp =
    'Operation darf nicht auf diese Gruppe angewandt werden';
  rsNERR_LastAdmin  =
    'Der letzte Administrator Account kann nicht gelöscht werden';
  rsNERR_BadPassword = 'Ungültiges Passwort';
  rsNERR_PasswordTooShort = 'Das Kennwort entspricht nicht den Anforderungen der Kennwortrichtlinien. Überprüfen Sie ' +
    'die Kennwortlänge, die Komplexität des Kennworts und die Anforderungen bezüglich früherer Kennwörter.';
  rsNERR_UserNotFound = 'Ungültiger Benutzer';
  rsNERR_GroupNotFound = 'Gruppe nicht gefunden';
  rsERROR_NO_SUCH_MEMBER = 'Benutzer existiert nicht';
  rsERROR_INVALID_MEMBER = 'Ungültiges Konto';
  rsERROR_MEMBER_IN_ALIAS = 'Benutzer ist schon Mitglied dieser Gruppe';
  rsUnknownError    = 'unbekannter Fehler: ';
begin
  case dwNetError of
    ERROR_ACCESS_DENIED: Result := rsERROR_ACCESS_DENIED;
    ERROR_INVALID_PARAMETER: Result := rsERROR_INVALID_PARAMETER;
    NERR_InvalidComputer: Result := rsNERR_InvalidComputer;
    NERR_NotPrimary: Result := rsNERR_NotPrimary;
    NERR_SpeGroupOp: Result := rsNERR_SpeGroupOp;
    NERR_LastAdmin: Result := rsNERR_LastAdmin;
    NERR_BadPassword: Result := rsNERR_BadPassword;
    NERR_PasswordTooShort: Result := rsNERR_PasswordTooShort;
    NERR_UserNotFound: Result := rsNERR_UserNotFound;
    NERR_GroupNotFound: Result := rsNERR_GroupNotFound;
    ERROR_NO_SUCH_MEMBER: Result := rsERROR_NO_SUCH_MEMBER;
    ERROR_INVALID_MEMBER: Result := rsERROR_INVALID_MEMBER;
    ERROR_MEMBER_IN_ALIAS: Result := rsERROR_MEMBER_IN_ALIAS;
  else
    Result := SysErrorMessage(dwNetError);
  end;
end;

{ Exception }

constructor Exception.Create(const msg: WideString; Errorcode: DWord);
begin
  FMsg := msg;
  FCode := Errorcode;
end;

constructor Exception.Create(const msg: WideString);
begin
  FMsg := msg;
  FCode := DWord(-1);
end;

constructor Exception.CreateFmt(Msg: Widestring; const Args: array of TVarRec);
begin
  Create(FormatW(Msg, Args));
end;

{ EInvalidArgument }

constructor EArgumentNull.Create(const parameter: String);
begin
  inherited Create('Argument null or empty: ' + parameter);
end;

{ ENetAPIError }

constructor ENetAPIError.Create(Errorcode: DWord);
begin
  inherited Create(NetErrorStr(Errorcode), Errorcode);
end;

{ EArgumentOutOfRange }

constructor EArgumentOutOfRange.Create(const parameter: String; const value);
begin
  inherited Create(FormatW('Argument out of range: ' + parameter, [Integer(value)]));
end;

end.
