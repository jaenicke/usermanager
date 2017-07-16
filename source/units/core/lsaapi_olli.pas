unit lsaapi_olli;

interface

uses
  Windows;

const
  POLICY_CREATE_SECRET = $00000020;

type
  NTSTATUS = LongInt;

  LSA_HANDLE = Pointer;

  PLSA_UNICODE_STRING = ^LSA_UNICODE_STRING;
  _LSA_UNICODE_STRING = record
    Length: Word;
    MaximumLength: Word;
    Buffer: PWideChar;
  end;
  LSA_UNICODE_STRING = _LSA_UNICODE_STRING;
  UNICODE_STRING = LSA_UNICODE_STRING;
  PUNICODE_STRING = PLSA_UNICODE_STRING;

  PLSA_OBJECT_ATTRIBUTES = ^LSA_OBJECT_ATTRIBUTES;
  _LSA_OBJECT_ATTRIBUTES = record
    Length: ULONG;
    RootDirectory: THandle;
    ObjectName: PLSA_UNICODE_STRING;
    Attributes: ULONG;
    SecurityDescriptor: Pointer;
    SecurityQualityOfService: Pointer; // Points to type SECURITY_QUALITY_OF_SERVICE
  end;
  LSA_OBJECT_ATTRIBUTES = _LSA_OBJECT_ATTRIBUTES;

const
  Advapi32          = 'advapi32.dll';

function NT_SUCCESS(Status: NTSTATUS): Boolean;

function LsaOpenPolicy(SystemName: PLSA_UNICODE_STRING; var ObjectAttributes: LSA_OBJECT_ATTRIBUTES; DesiredAccess:
  ACCESS_MASK; var PolicyHandle: LSA_HANDLE): NTSTATUS; stdcall; external Advapi32;
function LsaStorePrivateData(PolicyHandle: LSA_HANDLE; const KeyName: LSA_UNICODE_STRING; PrivateData:
  PLSA_UNICODE_STRING): NTSTATUS; stdcall; external Advapi32;
function LsaClose(ObjectHandle: LSA_HANDLE): NTSTATUS; stdcall; external Advapi32;
procedure RtlInitUnicodeString(DestinationString: PUNICODE_STRING; SourceString: PWideChar); stdcall; external
  'ntdll.dll';

implementation

function NT_SUCCESS(Status: NTSTATUS): Boolean;
begin
  Result := Status >= 0;
end;

end.

