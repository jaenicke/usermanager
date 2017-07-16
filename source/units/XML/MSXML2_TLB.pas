{$I ..\..\CompilerSwitches.inc}

unit MSXML2_TLB;

{$TYPEDADDRESS OFF} // Unit muss ohne Typueberpruefung fuer Zeiger compiliert werden.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses ActiveX, Classes, OleServer, Variants,
  MSXML2_TLB_Light;

type
// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TmsDOMDocument
// Hilfe-String      : W3C-DOM XML Document (Apartment)
// Standard-Interface: IXMLDOMDocument2
// Def. Intf. DISP? : No
// Ereignis-Interface: XMLDOMDocumentEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TmsDOMDocumentProperties= class;
{$ENDIF}
  TmsDOMDocument = class(TOleServer)
  private
    FOnondataavailable: TNotifyEvent;
    FOnonreadystatechange: TNotifyEvent;
    FIntf: IXMLDOMDocument2;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TmsDOMDocumentProperties;
    function GetServerProperties: TmsDOMDocumentProperties;
{$ENDIF}
    function GetDefaultInterface: IXMLDOMDocument2;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_namespaces: IXMLDOMSchemaCollection;
    function Get_schemas: OleVariant;
    procedure _Set_schemas(otherCollection: OleVariant);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXMLDOMDocument2);
    procedure Disconnect; override;
    function validate: IXMLDOMParseError;
    procedure setProperty(const name: WideString; value: OleVariant);
    function getProperty(const name: WideString): OleVariant;
    property DefaultInterface: IXMLDOMDocument2 read GetDefaultInterface;
    property namespaces: IXMLDOMSchemaCollection read Get_namespaces;
    property schemas: OleVariant read Get_schemas write _Set_schemas;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TmsDOMDocumentProperties read GetServerProperties;
{$ENDIF}
    property Onondataavailable: TNotifyEvent read FOnondataavailable write FOnondataavailable;
    property Ononreadystatechange: TNotifyEvent read FOnonreadystatechange write FOnonreadystatechange;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TmsDOMDocument
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TmsDOMDocumentProperties = class(TPersistent)
  private
    FServer:    TmsDOMDocument;
    function    GetDefaultInterface: IXMLDOMDocument2;
    constructor Create(AServer: TmsDOMDocument);
  protected
    function Get_namespaces: IXMLDOMSchemaCollection;
    function Get_schemas: OleVariant;
    procedure _Set_schemas(otherCollection: OleVariant);
  public
    property DefaultInterface: IXMLDOMDocument2 read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TmsDOMDocument26
// Hilfe-String      : W3C-DOM XML Document (Apartment)
// Standard-Interface: IXMLDOMDocument2
// Def. Intf. DISP? : No
// Ereignis-Interface: XMLDOMDocumentEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TmsDOMDocument26Properties= class;
{$ENDIF}
  TmsDOMDocument26 = class(TOleServer)
  private
    FOnondataavailable: TNotifyEvent;
    FOnonreadystatechange: TNotifyEvent;
    FIntf: IXMLDOMDocument2;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TmsDOMDocument26Properties;
    function GetServerProperties: TmsDOMDocument26Properties;
{$ENDIF}
    function GetDefaultInterface: IXMLDOMDocument2;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_namespaces: IXMLDOMSchemaCollection;
    function Get_schemas: OleVariant;
    procedure _Set_schemas(otherCollection: OleVariant);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXMLDOMDocument2);
    procedure Disconnect; override;
    function validate: IXMLDOMParseError;
    procedure setProperty(const name: WideString; value: OleVariant);
    function getProperty(const name: WideString): OleVariant;
    property DefaultInterface: IXMLDOMDocument2 read GetDefaultInterface;
    property namespaces: IXMLDOMSchemaCollection read Get_namespaces;
    property schemas: OleVariant read Get_schemas write _Set_schemas;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TmsDOMDocument26Properties read GetServerProperties;
{$ENDIF}
    property Onondataavailable: TNotifyEvent read FOnondataavailable write FOnondataavailable;
    property Ononreadystatechange: TNotifyEvent read FOnonreadystatechange write FOnonreadystatechange;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TmsDOMDocument26
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TmsDOMDocument26Properties = class(TPersistent)
  private
    FServer:    TmsDOMDocument26;
    function    GetDefaultInterface: IXMLDOMDocument2;
    constructor Create(AServer: TmsDOMDocument26);
  protected
    function Get_namespaces: IXMLDOMSchemaCollection;
    function Get_schemas: OleVariant;
    procedure _Set_schemas(otherCollection: OleVariant);
  public
    property DefaultInterface: IXMLDOMDocument2 read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TmsDOMDocument30
// Hilfe-String      : W3C-DOM XML Document (Apartment)
// Standard-Interface: IXMLDOMDocument2
// Def. Intf. DISP? : No
// Ereignis-Interface: XMLDOMDocumentEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TmsDOMDocument30Properties= class;
{$ENDIF}
  TmsDOMDocument30 = class(TOleServer)
  private
    FOnondataavailable: TNotifyEvent;
    FOnonreadystatechange: TNotifyEvent;
    FIntf: IXMLDOMDocument2;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TmsDOMDocument30Properties;
    function GetServerProperties: TmsDOMDocument30Properties;
{$ENDIF}
    function GetDefaultInterface: IXMLDOMDocument2;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_namespaces: IXMLDOMSchemaCollection;
    function Get_schemas: OleVariant;
    procedure _Set_schemas(otherCollection: OleVariant);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXMLDOMDocument2);
    procedure Disconnect; override;
    function validate: IXMLDOMParseError;
    procedure setProperty(const name: WideString; value: OleVariant);
    function getProperty(const name: WideString): OleVariant;
    property DefaultInterface: IXMLDOMDocument2 read GetDefaultInterface;
    property namespaces: IXMLDOMSchemaCollection read Get_namespaces;
    property schemas: OleVariant read Get_schemas write _Set_schemas;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TmsDOMDocument30Properties read GetServerProperties;
{$ENDIF}
    property Onondataavailable: TNotifyEvent read FOnondataavailable write FOnondataavailable;
    property Ononreadystatechange: TNotifyEvent read FOnonreadystatechange write FOnonreadystatechange;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TmsDOMDocument30
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TmsDOMDocument30Properties = class(TPersistent)
  private
    FServer:    TmsDOMDocument30;
    function    GetDefaultInterface: IXMLDOMDocument2;
    constructor Create(AServer: TmsDOMDocument30);
  protected
    function Get_namespaces: IXMLDOMSchemaCollection;
    function Get_schemas: OleVariant;
    procedure _Set_schemas(otherCollection: OleVariant);
  public
    property DefaultInterface: IXMLDOMDocument2 read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TDOMDocument40
// Hilfe-String      : W3C-DOM XML Document (Apartment)
// Standard-Interface: IXMLDOMDocument2
// Def. Intf. DISP? : No
// Ereignis-Interface: XMLDOMDocumentEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TDOMDocument40Properties= class;
{$ENDIF}
  TDOMDocument40 = class(TOleServer)
  private
    FOnondataavailable: TNotifyEvent;
    FOnonreadystatechange: TNotifyEvent;
    FIntf: IXMLDOMDocument2;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TDOMDocument40Properties;
    function GetServerProperties: TDOMDocument40Properties;
{$ENDIF}
    function GetDefaultInterface: IXMLDOMDocument2;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_namespaces: IXMLDOMSchemaCollection;
    function Get_schemas: OleVariant;
    procedure _Set_schemas(otherCollection: OleVariant);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXMLDOMDocument2);
    procedure Disconnect; override;
    function validate: IXMLDOMParseError;
    procedure setProperty(const name: WideString; value: OleVariant);
    function getProperty(const name: WideString): OleVariant;
    property DefaultInterface: IXMLDOMDocument2 read GetDefaultInterface;
    property namespaces: IXMLDOMSchemaCollection read Get_namespaces;
    property schemas: OleVariant read Get_schemas write _Set_schemas;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TDOMDocument40Properties read GetServerProperties;
{$ENDIF}
    property Onondataavailable: TNotifyEvent read FOnondataavailable write FOnondataavailable;
    property Ononreadystatechange: TNotifyEvent read FOnonreadystatechange write FOnonreadystatechange;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TDOMDocument40
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TDOMDocument40Properties = class(TPersistent)
  private
    FServer:    TDOMDocument40;
    function    GetDefaultInterface: IXMLDOMDocument2;
    constructor Create(AServer: TDOMDocument40);
  protected
    function Get_namespaces: IXMLDOMSchemaCollection;
    function Get_schemas: OleVariant;
    procedure _Set_schemas(otherCollection: OleVariant);
  public
    property DefaultInterface: IXMLDOMDocument2 read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TDOMDocument60
// Hilfe-String      : W3C-DOM XML Document 6.0 (Apartment)
// Standard-Interface: IXMLDOMDocument3
// Def. Intf. DISP? : No
// Ereignis-Interface: XMLDOMDocumentEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TDOMDocument60Properties= class;
{$ENDIF}
  TDOMDocument60 = class(TOleServer)
  private
    FOnondataavailable: TNotifyEvent;
    FOnonreadystatechange: TNotifyEvent;
    FIntf: IXMLDOMDocument3;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TDOMDocument60Properties;
    function GetServerProperties: TDOMDocument60Properties;
{$ENDIF}
    function GetDefaultInterface: IXMLDOMDocument3;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXMLDOMDocument3);
    procedure Disconnect; override;
    function validateNode(const node: IXMLDOMNode): IXMLDOMParseError;
    function importNode(const node: IXMLDOMNode; deep: WordBool): IXMLDOMNode;
    property DefaultInterface: IXMLDOMDocument3 read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TDOMDocument60Properties read GetServerProperties;
{$ENDIF}
    property Onondataavailable: TNotifyEvent read FOnondataavailable write FOnondataavailable;
    property Ononreadystatechange: TNotifyEvent read FOnonreadystatechange write FOnonreadystatechange;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TDOMDocument60
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TDOMDocument60Properties = class(TPersistent)
  private
    FServer:    TDOMDocument60;
    function    GetDefaultInterface: IXMLDOMDocument3;
    constructor Create(AServer: TDOMDocument60);
  protected
  public
    property DefaultInterface: IXMLDOMDocument3 read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TmsFreeThreadedDOMDocument
// Hilfe-String      : W3C-DOM XML Document (Free threaded)
// Standard-Interface: IXMLDOMDocument2
// Def. Intf. DISP? : No
// Ereignis-Interface: XMLDOMDocumentEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TmsFreeThreadedDOMDocumentProperties= class;
{$ENDIF}
  TmsFreeThreadedDOMDocument = class(TOleServer)
  private
    FOnondataavailable: TNotifyEvent;
    FOnonreadystatechange: TNotifyEvent;
    FIntf: IXMLDOMDocument2;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TmsFreeThreadedDOMDocumentProperties;
    function GetServerProperties: TmsFreeThreadedDOMDocumentProperties;
{$ENDIF}
    function GetDefaultInterface: IXMLDOMDocument2;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_namespaces: IXMLDOMSchemaCollection;
    function Get_schemas: OleVariant;
    procedure _Set_schemas(otherCollection: OleVariant);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXMLDOMDocument2);
    procedure Disconnect; override;
    function validate: IXMLDOMParseError;
    procedure setProperty(const name: WideString; value: OleVariant);
    function getProperty(const name: WideString): OleVariant;
    property DefaultInterface: IXMLDOMDocument2 read GetDefaultInterface;
    property namespaces: IXMLDOMSchemaCollection read Get_namespaces;
    property schemas: OleVariant read Get_schemas write _Set_schemas;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TmsFreeThreadedDOMDocumentProperties read GetServerProperties;
{$ENDIF}
    property Onondataavailable: TNotifyEvent read FOnondataavailable write FOnondataavailable;
    property Ononreadystatechange: TNotifyEvent read FOnonreadystatechange write FOnonreadystatechange;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TmsFreeThreadedDOMDocument
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TmsFreeThreadedDOMDocumentProperties = class(TPersistent)
  private
    FServer:    TmsFreeThreadedDOMDocument;
    function    GetDefaultInterface: IXMLDOMDocument2;
    constructor Create(AServer: TmsFreeThreadedDOMDocument);
  protected
    function Get_namespaces: IXMLDOMSchemaCollection;
    function Get_schemas: OleVariant;
    procedure _Set_schemas(otherCollection: OleVariant);
  public
    property DefaultInterface: IXMLDOMDocument2 read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TmsFreeThreadedDOMDocument26
// Hilfe-String      : W3C-DOM XML Document (Free threaded)
// Standard-Interface: IXMLDOMDocument2
// Def. Intf. DISP? : No
// Ereignis-Interface: XMLDOMDocumentEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TmsFreeThreadedDOMDocument26Properties= class;
{$ENDIF}
  TmsFreeThreadedDOMDocument26 = class(TOleServer)
  private
    FOnondataavailable: TNotifyEvent;
    FOnonreadystatechange: TNotifyEvent;
    FIntf: IXMLDOMDocument2;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TmsFreeThreadedDOMDocument26Properties;
    function GetServerProperties: TmsFreeThreadedDOMDocument26Properties;
{$ENDIF}
    function GetDefaultInterface: IXMLDOMDocument2;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_namespaces: IXMLDOMSchemaCollection;
    function Get_schemas: OleVariant;
    procedure _Set_schemas(otherCollection: OleVariant);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXMLDOMDocument2);
    procedure Disconnect; override;
    function validate: IXMLDOMParseError;
    procedure setProperty(const name: WideString; value: OleVariant);
    function getProperty(const name: WideString): OleVariant;
    property DefaultInterface: IXMLDOMDocument2 read GetDefaultInterface;
    property namespaces: IXMLDOMSchemaCollection read Get_namespaces;
    property schemas: OleVariant read Get_schemas write _Set_schemas;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TmsFreeThreadedDOMDocument26Properties read GetServerProperties;
{$ENDIF}
    property Onondataavailable: TNotifyEvent read FOnondataavailable write FOnondataavailable;
    property Ononreadystatechange: TNotifyEvent read FOnonreadystatechange write FOnonreadystatechange;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TmsFreeThreadedDOMDocument26
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TmsFreeThreadedDOMDocument26Properties = class(TPersistent)
  private
    FServer:    TmsFreeThreadedDOMDocument26;
    function    GetDefaultInterface: IXMLDOMDocument2;
    constructor Create(AServer: TmsFreeThreadedDOMDocument26);
  protected
    function Get_namespaces: IXMLDOMSchemaCollection;
    function Get_schemas: OleVariant;
    procedure _Set_schemas(otherCollection: OleVariant);
  public
    property DefaultInterface: IXMLDOMDocument2 read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TmsFreeThreadedDOMDocument30
// Hilfe-String      : W3C-DOM XML Document (Free threaded)
// Standard-Interface: IXMLDOMDocument2
// Def. Intf. DISP? : No
// Ereignis-Interface: XMLDOMDocumentEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TmsFreeThreadedDOMDocument30Properties= class;
{$ENDIF}
  TmsFreeThreadedDOMDocument30 = class(TOleServer)
  private
    FOnondataavailable: TNotifyEvent;
    FOnonreadystatechange: TNotifyEvent;
    FIntf: IXMLDOMDocument2;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TmsFreeThreadedDOMDocument30Properties;
    function GetServerProperties: TmsFreeThreadedDOMDocument30Properties;
{$ENDIF}
    function GetDefaultInterface: IXMLDOMDocument2;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_namespaces: IXMLDOMSchemaCollection;
    function Get_schemas: OleVariant;
    procedure _Set_schemas(otherCollection: OleVariant);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXMLDOMDocument2);
    procedure Disconnect; override;
    function validate: IXMLDOMParseError;
    procedure setProperty(const name: WideString; value: OleVariant);
    function getProperty(const name: WideString): OleVariant;
    property DefaultInterface: IXMLDOMDocument2 read GetDefaultInterface;
    property namespaces: IXMLDOMSchemaCollection read Get_namespaces;
    property schemas: OleVariant read Get_schemas write _Set_schemas;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TmsFreeThreadedDOMDocument30Properties read GetServerProperties;
{$ENDIF}
    property Onondataavailable: TNotifyEvent read FOnondataavailable write FOnondataavailable;
    property Ononreadystatechange: TNotifyEvent read FOnonreadystatechange write FOnonreadystatechange;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TmsFreeThreadedDOMDocument30
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TmsFreeThreadedDOMDocument30Properties = class(TPersistent)
  private
    FServer:    TmsFreeThreadedDOMDocument30;
    function    GetDefaultInterface: IXMLDOMDocument2;
    constructor Create(AServer: TmsFreeThreadedDOMDocument30);
  protected
    function Get_namespaces: IXMLDOMSchemaCollection;
    function Get_schemas: OleVariant;
    procedure _Set_schemas(otherCollection: OleVariant);
  public
    property DefaultInterface: IXMLDOMDocument2 read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TFreeThreadedDOMDocument40
// Hilfe-String      : W3C-DOM XML Document (Free threaded)
// Standard-Interface: IXMLDOMDocument2
// Def. Intf. DISP? : No
// Ereignis-Interface: XMLDOMDocumentEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TFreeThreadedDOMDocument40Properties= class;
{$ENDIF}
  TFreeThreadedDOMDocument40 = class(TOleServer)
  private
    FOnondataavailable: TNotifyEvent;
    FOnonreadystatechange: TNotifyEvent;
    FIntf: IXMLDOMDocument2;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TFreeThreadedDOMDocument40Properties;
    function GetServerProperties: TFreeThreadedDOMDocument40Properties;
{$ENDIF}
    function GetDefaultInterface: IXMLDOMDocument2;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_namespaces: IXMLDOMSchemaCollection;
    function Get_schemas: OleVariant;
    procedure _Set_schemas(otherCollection: OleVariant);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXMLDOMDocument2);
    procedure Disconnect; override;
    function validate: IXMLDOMParseError;
    procedure setProperty(const name: WideString; value: OleVariant);
    function getProperty(const name: WideString): OleVariant;
    property DefaultInterface: IXMLDOMDocument2 read GetDefaultInterface;
    property namespaces: IXMLDOMSchemaCollection read Get_namespaces;
    property schemas: OleVariant read Get_schemas write _Set_schemas;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TFreeThreadedDOMDocument40Properties read GetServerProperties;
{$ENDIF}
    property Onondataavailable: TNotifyEvent read FOnondataavailable write FOnondataavailable;
    property Ononreadystatechange: TNotifyEvent read FOnonreadystatechange write FOnonreadystatechange;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TFreeThreadedDOMDocument40
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TFreeThreadedDOMDocument40Properties = class(TPersistent)
  private
    FServer:    TFreeThreadedDOMDocument40;
    function    GetDefaultInterface: IXMLDOMDocument2;
    constructor Create(AServer: TFreeThreadedDOMDocument40);
  protected
    function Get_namespaces: IXMLDOMSchemaCollection;
    function Get_schemas: OleVariant;
    procedure _Set_schemas(otherCollection: OleVariant);
  public
    property DefaultInterface: IXMLDOMDocument2 read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TFreeThreadedDOMDocument60
// Hilfe-String      : W3C-DOM XML Document 6.0 (Free threaded)
// Standard-Interface: IXMLDOMDocument3
// Def. Intf. DISP? : No
// Ereignis-Interface: XMLDOMDocumentEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TFreeThreadedDOMDocument60Properties= class;
{$ENDIF}
  TFreeThreadedDOMDocument60 = class(TOleServer)
  private
    FOnondataavailable: TNotifyEvent;
    FOnonreadystatechange: TNotifyEvent;
    FIntf: IXMLDOMDocument3;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TFreeThreadedDOMDocument60Properties;
    function GetServerProperties: TFreeThreadedDOMDocument60Properties;
{$ENDIF}
    function GetDefaultInterface: IXMLDOMDocument3;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXMLDOMDocument3);
    procedure Disconnect; override;
    function validateNode(const node: IXMLDOMNode): IXMLDOMParseError;
    function importNode(const node: IXMLDOMNode; deep: WordBool): IXMLDOMNode;
    property DefaultInterface: IXMLDOMDocument3 read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TFreeThreadedDOMDocument60Properties read GetServerProperties;
{$ENDIF}
    property Onondataavailable: TNotifyEvent read FOnondataavailable write FOnondataavailable;
    property Ononreadystatechange: TNotifyEvent read FOnonreadystatechange write FOnonreadystatechange;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TFreeThreadedDOMDocument60
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TFreeThreadedDOMDocument60Properties = class(TPersistent)
  private
    FServer:    TFreeThreadedDOMDocument60;
    function    GetDefaultInterface: IXMLDOMDocument3;
    constructor Create(AServer: TFreeThreadedDOMDocument60);
  protected
  public
    property DefaultInterface: IXMLDOMDocument3 read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TmsXMLSchemaCache
// Hilfe-String      : XML Schema Cache
// Standard-Interface: IXMLDOMSchemaCollection
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TmsXMLSchemaCacheProperties= class;
{$ENDIF}
  TmsXMLSchemaCache = class(TOleServer)
  private
    FIntf: IXMLDOMSchemaCollection;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TmsXMLSchemaCacheProperties;
    function GetServerProperties: TmsXMLSchemaCacheProperties;
{$ENDIF}
    function GetDefaultInterface: IXMLDOMSchemaCollection;
  protected
    procedure InitServerData; override;
    function Get_length: Integer;
    function Get_namespaceURI(index: Integer): WideString;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXMLDOMSchemaCollection);
    procedure Disconnect; override;
    procedure add(const namespaceURI: WideString; var_: OleVariant);
    function get(const namespaceURI: WideString): IXMLDOMNode;
    procedure remove(const namespaceURI: WideString);
    procedure addCollection(const otherCollection: IXMLDOMSchemaCollection);
    property DefaultInterface: IXMLDOMSchemaCollection read GetDefaultInterface;
    property length: Integer read Get_length;
    property namespaceURI[index: Integer]: WideString read Get_namespaceURI; default;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TmsXMLSchemaCacheProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TmsXMLSchemaCache
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TmsXMLSchemaCacheProperties = class(TPersistent)
  private
    FServer:    TmsXMLSchemaCache;
    function    GetDefaultInterface: IXMLDOMSchemaCollection;
    constructor Create(AServer: TmsXMLSchemaCache);
  protected
    function Get_length: Integer;
    function Get_namespaceURI(index: Integer): WideString;
  public
    property DefaultInterface: IXMLDOMSchemaCollection read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TmsXMLSchemaCache26
// Hilfe-String      : XML Schema Cache 2.6
// Standard-Interface: IXMLDOMSchemaCollection
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TmsXMLSchemaCache26Properties= class;
{$ENDIF}
  TmsXMLSchemaCache26 = class(TOleServer)
  private
    FIntf: IXMLDOMSchemaCollection;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TmsXMLSchemaCache26Properties;
    function GetServerProperties: TmsXMLSchemaCache26Properties;
{$ENDIF}
    function GetDefaultInterface: IXMLDOMSchemaCollection;
  protected
    procedure InitServerData; override;
    function Get_length: Integer;
    function Get_namespaceURI(index: Integer): WideString;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXMLDOMSchemaCollection);
    procedure Disconnect; override;
    procedure add(const namespaceURI: WideString; var_: OleVariant);
    function get(const namespaceURI: WideString): IXMLDOMNode;
    procedure remove(const namespaceURI: WideString);
    procedure addCollection(const otherCollection: IXMLDOMSchemaCollection);
    property DefaultInterface: IXMLDOMSchemaCollection read GetDefaultInterface;
    property length: Integer read Get_length;
    property namespaceURI[index: Integer]: WideString read Get_namespaceURI; default;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TmsXMLSchemaCache26Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TmsXMLSchemaCache26
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TmsXMLSchemaCache26Properties = class(TPersistent)
  private
    FServer:    TmsXMLSchemaCache26;
    function    GetDefaultInterface: IXMLDOMSchemaCollection;
    constructor Create(AServer: TmsXMLSchemaCache26);
  protected
    function Get_length: Integer;
    function Get_namespaceURI(index: Integer): WideString;
  public
    property DefaultInterface: IXMLDOMSchemaCollection read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TmsXMLSchemaCache30
// Hilfe-String      : XML Schema Cache 3.0
// Standard-Interface: IXMLDOMSchemaCollection
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TmsXMLSchemaCache30Properties= class;
{$ENDIF}
  TmsXMLSchemaCache30 = class(TOleServer)
  private
    FIntf: IXMLDOMSchemaCollection;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TmsXMLSchemaCache30Properties;
    function GetServerProperties: TmsXMLSchemaCache30Properties;
{$ENDIF}
    function GetDefaultInterface: IXMLDOMSchemaCollection;
  protected
    procedure InitServerData; override;
    function Get_length: Integer;
    function Get_namespaceURI(index: Integer): WideString;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXMLDOMSchemaCollection);
    procedure Disconnect; override;
    procedure add(const namespaceURI: WideString; var_: OleVariant);
    function get(const namespaceURI: WideString): IXMLDOMNode;
    procedure remove(const namespaceURI: WideString);
    procedure addCollection(const otherCollection: IXMLDOMSchemaCollection);
    property DefaultInterface: IXMLDOMSchemaCollection read GetDefaultInterface;
    property length: Integer read Get_length;
    property namespaceURI[index: Integer]: WideString read Get_namespaceURI; default;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TmsXMLSchemaCache30Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TmsXMLSchemaCache30
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TmsXMLSchemaCache30Properties = class(TPersistent)
  private
    FServer:    TmsXMLSchemaCache30;
    function    GetDefaultInterface: IXMLDOMSchemaCollection;
    constructor Create(AServer: TmsXMLSchemaCache30);
  protected
    function Get_length: Integer;
    function Get_namespaceURI(index: Integer): WideString;
  public
    property DefaultInterface: IXMLDOMSchemaCollection read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TXMLSchemaCache40
// Hilfe-String      : XML Schema Cache 4.0
// Standard-Interface: IXMLDOMSchemaCollection2
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TXMLSchemaCache40Properties= class;
{$ENDIF}
  TXMLSchemaCache40 = class(TOleServer)
  private
    FIntf: IXMLDOMSchemaCollection2;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TXMLSchemaCache40Properties;
    function GetServerProperties: TXMLSchemaCache40Properties;
{$ENDIF}
    function GetDefaultInterface: IXMLDOMSchemaCollection2;
  protected
    procedure InitServerData; override;
    procedure Set_validateOnLoad(validateOnLoad: WordBool);
    function Get_validateOnLoad: WordBool;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXMLDOMSchemaCollection2);
    procedure Disconnect; override;
    procedure validate;
    function getSchema(const namespaceURI: WideString): ISchema;
    function getDeclaration(const node: IXMLDOMNode): ISchemaItem;
    property DefaultInterface: IXMLDOMSchemaCollection2 read GetDefaultInterface;
    property validateOnLoad: WordBool read Get_validateOnLoad write Set_validateOnLoad;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TXMLSchemaCache40Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TXMLSchemaCache40
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TXMLSchemaCache40Properties = class(TPersistent)
  private
    FServer:    TXMLSchemaCache40;
    function    GetDefaultInterface: IXMLDOMSchemaCollection2;
    constructor Create(AServer: TXMLSchemaCache40);
  protected
    procedure Set_validateOnLoad(validateOnLoad: WordBool);
    function Get_validateOnLoad: WordBool;
  public
    property DefaultInterface: IXMLDOMSchemaCollection2 read GetDefaultInterface;
  published
    property validateOnLoad: WordBool read Get_validateOnLoad write Set_validateOnLoad;
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TXMLSchemaCache60
// Hilfe-String      : XML Schema Cache 6.0
// Standard-Interface: IXMLDOMSchemaCollection2
// Def. Intf. DISP? : No
// Ereignis-Interface:
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TXMLSchemaCache60Properties= class;
{$ENDIF}
  TXMLSchemaCache60 = class(TOleServer)
  private
    FIntf: IXMLDOMSchemaCollection2;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TXMLSchemaCache60Properties;
    function GetServerProperties: TXMLSchemaCache60Properties;
{$ENDIF}
    function GetDefaultInterface: IXMLDOMSchemaCollection2;
  protected
    procedure InitServerData; override;
    procedure Set_validateOnLoad(validateOnLoad: WordBool);
    function Get_validateOnLoad: WordBool;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXMLDOMSchemaCollection2);
    procedure Disconnect; override;
    procedure validate;
    function getSchema(const namespaceURI: WideString): ISchema;
    function getDeclaration(const node: IXMLDOMNode): ISchemaItem;
    property DefaultInterface: IXMLDOMSchemaCollection2 read GetDefaultInterface;
    property validateOnLoad: WordBool read Get_validateOnLoad write Set_validateOnLoad;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TXMLSchemaCache60Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TXMLSchemaCache60
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TXMLSchemaCache60Properties = class(TPersistent)
  private
    FServer:    TXMLSchemaCache60;
    function    GetDefaultInterface: IXMLDOMSchemaCollection2;
    constructor Create(AServer: TXMLSchemaCache60);
  protected
    procedure Set_validateOnLoad(validateOnLoad: WordBool);
    function Get_validateOnLoad: WordBool;
  public
    property DefaultInterface: IXMLDOMSchemaCollection2 read GetDefaultInterface;
  published
    property validateOnLoad: WordBool read Get_validateOnLoad write Set_validateOnLoad;
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TmsXSLTemplate
// Hilfe-String      : Compiled XSL Stylesheet Cache
// Standard-Interface: IXSLTemplate
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TmsXSLTemplateProperties= class;
{$ENDIF}
  TmsXSLTemplate = class(TOleServer)
  private
    FIntf: IXSLTemplate;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TmsXSLTemplateProperties;
    function GetServerProperties: TmsXSLTemplateProperties;
{$ENDIF}
    function GetDefaultInterface: IXSLTemplate;
  protected
    procedure InitServerData; override;
    procedure _Set_stylesheet(const stylesheet: IXMLDOMNode);
    function Get_stylesheet: IXMLDOMNode;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXSLTemplate);
    procedure Disconnect; override;
    function createProcessor: IXSLProcessor;
    property DefaultInterface: IXSLTemplate read GetDefaultInterface;
    property stylesheet: IXMLDOMNode read Get_stylesheet write _Set_stylesheet;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TmsXSLTemplateProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TmsXSLTemplate
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TmsXSLTemplateProperties = class(TPersistent)
  private
    FServer:    TmsXSLTemplate;
    function    GetDefaultInterface: IXSLTemplate;
    constructor Create(AServer: TmsXSLTemplate);
  protected
    procedure _Set_stylesheet(const stylesheet: IXMLDOMNode);
    function Get_stylesheet: IXMLDOMNode;
  public
    property DefaultInterface: IXSLTemplate read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TmsXSLTemplate26
// Hilfe-String      : Compiled XSL Stylesheet Cache 2.6
// Standard-Interface: IXSLTemplate
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TmsXSLTemplate26Properties= class;
{$ENDIF}
  TmsXSLTemplate26 = class(TOleServer)
  private
    FIntf: IXSLTemplate;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TmsXSLTemplate26Properties;
    function GetServerProperties: TmsXSLTemplate26Properties;
{$ENDIF}
    function GetDefaultInterface: IXSLTemplate;
  protected
    procedure InitServerData; override;
    procedure _Set_stylesheet(const stylesheet: IXMLDOMNode);
    function Get_stylesheet: IXMLDOMNode;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXSLTemplate);
    procedure Disconnect; override;
    function createProcessor: IXSLProcessor;
    property DefaultInterface: IXSLTemplate read GetDefaultInterface;
    property stylesheet: IXMLDOMNode read Get_stylesheet write _Set_stylesheet;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TmsXSLTemplate26Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TmsXSLTemplate26
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TmsXSLTemplate26Properties = class(TPersistent)
  private
    FServer:    TmsXSLTemplate26;
    function    GetDefaultInterface: IXSLTemplate;
    constructor Create(AServer: TmsXSLTemplate26);
  protected
    procedure _Set_stylesheet(const stylesheet: IXMLDOMNode);
    function Get_stylesheet: IXMLDOMNode;
  public
    property DefaultInterface: IXSLTemplate read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TmsXSLTemplate30
// Hilfe-String      : Compiled XSL Stylesheet Cache 3.0
// Standard-Interface: IXSLTemplate
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TmsXSLTemplate30Properties= class;
{$ENDIF}
  TmsXSLTemplate30 = class(TOleServer)
  private
    FIntf: IXSLTemplate;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TmsXSLTemplate30Properties;
    function GetServerProperties: TmsXSLTemplate30Properties;
{$ENDIF}
    function GetDefaultInterface: IXSLTemplate;
  protected
    procedure InitServerData; override;
    procedure _Set_stylesheet(const stylesheet: IXMLDOMNode);
    function Get_stylesheet: IXMLDOMNode;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXSLTemplate);
    procedure Disconnect; override;
    function createProcessor: IXSLProcessor;
    property DefaultInterface: IXSLTemplate read GetDefaultInterface;
    property stylesheet: IXMLDOMNode read Get_stylesheet write _Set_stylesheet;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TmsXSLTemplate30Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TmsXSLTemplate30
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TmsXSLTemplate30Properties = class(TPersistent)
  private
    FServer:    TmsXSLTemplate30;
    function    GetDefaultInterface: IXSLTemplate;
    constructor Create(AServer: TmsXSLTemplate30);
  protected
    procedure _Set_stylesheet(const stylesheet: IXMLDOMNode);
    function Get_stylesheet: IXMLDOMNode;
  public
    property DefaultInterface: IXSLTemplate read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TXSLTemplate40
// Hilfe-String      : Compiled XSL Stylesheet Cache 4.0
// Standard-Interface: IXSLTemplate
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TXSLTemplate40Properties= class;
{$ENDIF}
  TXSLTemplate40 = class(TOleServer)
  private
    FIntf: IXSLTemplate;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TXSLTemplate40Properties;
    function GetServerProperties: TXSLTemplate40Properties;
{$ENDIF}
    function GetDefaultInterface: IXSLTemplate;
  protected
    procedure InitServerData; override;
    procedure _Set_stylesheet(const stylesheet: IXMLDOMNode);
    function Get_stylesheet: IXMLDOMNode;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXSLTemplate);
    procedure Disconnect; override;
    function createProcessor: IXSLProcessor;
    property DefaultInterface: IXSLTemplate read GetDefaultInterface;
    property stylesheet: IXMLDOMNode read Get_stylesheet write _Set_stylesheet;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TXSLTemplate40Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TXSLTemplate40
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TXSLTemplate40Properties = class(TPersistent)
  private
    FServer:    TXSLTemplate40;
    function    GetDefaultInterface: IXSLTemplate;
    constructor Create(AServer: TXSLTemplate40);
  protected
    procedure _Set_stylesheet(const stylesheet: IXMLDOMNode);
    function Get_stylesheet: IXMLDOMNode;
  public
    property DefaultInterface: IXSLTemplate read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TXSLTemplate60
// Hilfe-String      : XSL Stylesheet Cache 6.0
// Standard-Interface: IXSLTemplate
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TXSLTemplate60Properties= class;
{$ENDIF}
  TXSLTemplate60 = class(TOleServer)
  private
    FIntf: IXSLTemplate;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TXSLTemplate60Properties;
    function GetServerProperties: TXSLTemplate60Properties;
{$ENDIF}
    function GetDefaultInterface: IXSLTemplate;
  protected
    procedure InitServerData; override;
    procedure _Set_stylesheet(const stylesheet: IXMLDOMNode);
    function Get_stylesheet: IXMLDOMNode;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXSLTemplate);
    procedure Disconnect; override;
    function createProcessor: IXSLProcessor;
    property DefaultInterface: IXSLTemplate read GetDefaultInterface;
    property stylesheet: IXMLDOMNode read Get_stylesheet write _Set_stylesheet;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TXSLTemplate60Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TXSLTemplate60
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TXSLTemplate60Properties = class(TPersistent)
  private
    FServer:    TXSLTemplate60;
    function    GetDefaultInterface: IXSLTemplate;
    constructor Create(AServer: TXSLTemplate60);
  protected
    procedure _Set_stylesheet(const stylesheet: IXMLDOMNode);
    function Get_stylesheet: IXMLDOMNode;
  public
    property DefaultInterface: IXSLTemplate read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TmsXMLHTTP
// Hilfe-String      : XML HTTP Request class.
// Standard-Interface: IXMLHTTPRequest
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TmsXMLHTTPProperties= class;
{$ENDIF}
  TmsXMLHTTP = class(TOleServer)
  private
    FIntf: IXMLHTTPRequest;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TmsXMLHTTPProperties;
    function GetServerProperties: TmsXMLHTTPProperties;
{$ENDIF}
    function GetDefaultInterface: IXMLHTTPRequest;
  protected
    procedure InitServerData; override;
    function Get_status: Integer;
    function Get_statusText: WideString;
    function Get_responseXML: IDispatch;
    function Get_responseText: WideString;
    function Get_responseBody: OleVariant;
    function Get_responseStream: OleVariant;
    function Get_readyState: Integer;
    procedure Set_onreadystatechange(const Param1: IDispatch);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXMLHTTPRequest);
    procedure Disconnect; override;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant; 
                   bstrUser: OleVariant); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant; 
                   bstrUser: OleVariant; bstrPassword: OleVariant); overload;
    procedure setRequestHeader(const bstrHeader: WideString; const bstrValue: WideString);
    function getResponseHeader(const bstrHeader: WideString): WideString;
    function getAllResponseHeaders: WideString;
    procedure send; overload;
    procedure send(varBody: OleVariant); overload;
    procedure abort;
    property DefaultInterface: IXMLHTTPRequest read GetDefaultInterface;
    property status: Integer read Get_status;
    property statusText: WideString read Get_statusText;
    property responseXML: IDispatch read Get_responseXML;
    property responseText: WideString read Get_responseText;
    property responseBody: OleVariant read Get_responseBody;
    property responseStream: OleVariant read Get_responseStream;
    property readyState: Integer read Get_readyState;
    property onreadystatechange: IDispatch write Set_onreadystatechange;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TmsXMLHTTPProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TmsXMLHTTP
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TmsXMLHTTPProperties = class(TPersistent)
  private
    FServer:    TmsXMLHTTP;
    function    GetDefaultInterface: IXMLHTTPRequest;
    constructor Create(AServer: TmsXMLHTTP);
  protected
    function Get_status: Integer;
    function Get_statusText: WideString;
    function Get_responseXML: IDispatch;
    function Get_responseText: WideString;
    function Get_responseBody: OleVariant;
    function Get_responseStream: OleVariant;
    function Get_readyState: Integer;
    procedure Set_onreadystatechange(const Param1: IDispatch);
  public
    property DefaultInterface: IXMLHTTPRequest read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TmsXMLHTTP26
// Hilfe-String      : XML HTTP Request class.
// Standard-Interface: IXMLHTTPRequest
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TmsXMLHTTP26Properties= class;
{$ENDIF}
  TmsXMLHTTP26 = class(TOleServer)
  private
    FIntf: IXMLHTTPRequest;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TmsXMLHTTP26Properties;
    function GetServerProperties: TmsXMLHTTP26Properties;
{$ENDIF}
    function GetDefaultInterface: IXMLHTTPRequest;
  protected
    procedure InitServerData; override;
    function Get_status: Integer;
    function Get_statusText: WideString;
    function Get_responseXML: IDispatch;
    function Get_responseText: WideString;
    function Get_responseBody: OleVariant;
    function Get_responseStream: OleVariant;
    function Get_readyState: Integer;
    procedure Set_onreadystatechange(const Param1: IDispatch);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXMLHTTPRequest);
    procedure Disconnect; override;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant; 
                   bstrUser: OleVariant); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant; 
                   bstrUser: OleVariant; bstrPassword: OleVariant); overload;
    procedure setRequestHeader(const bstrHeader: WideString; const bstrValue: WideString);
    function getResponseHeader(const bstrHeader: WideString): WideString;
    function getAllResponseHeaders: WideString;
    procedure send; overload;
    procedure send(varBody: OleVariant); overload;
    procedure abort;
    property DefaultInterface: IXMLHTTPRequest read GetDefaultInterface;
    property status: Integer read Get_status;
    property statusText: WideString read Get_statusText;
    property responseXML: IDispatch read Get_responseXML;
    property responseText: WideString read Get_responseText;
    property responseBody: OleVariant read Get_responseBody;
    property responseStream: OleVariant read Get_responseStream;
    property readyState: Integer read Get_readyState;
    property onreadystatechange: IDispatch write Set_onreadystatechange;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TmsXMLHTTP26Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TmsXMLHTTP26
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TmsXMLHTTP26Properties = class(TPersistent)
  private
    FServer:    TmsXMLHTTP26;
    function    GetDefaultInterface: IXMLHTTPRequest;
    constructor Create(AServer: TmsXMLHTTP26);
  protected
    function Get_status: Integer;
    function Get_statusText: WideString;
    function Get_responseXML: IDispatch;
    function Get_responseText: WideString;
    function Get_responseBody: OleVariant;
    function Get_responseStream: OleVariant;
    function Get_readyState: Integer;
    procedure Set_onreadystatechange(const Param1: IDispatch);
  public
    property DefaultInterface: IXMLHTTPRequest read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TmsXMLHTTP30
// Hilfe-String      : XML HTTP Request class.
// Standard-Interface: IXMLHTTPRequest
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TmsXMLHTTP30Properties= class;
{$ENDIF}
  TmsXMLHTTP30 = class(TOleServer)
  private
    FIntf: IXMLHTTPRequest;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TmsXMLHTTP30Properties;
    function GetServerProperties: TmsXMLHTTP30Properties;
{$ENDIF}
    function GetDefaultInterface: IXMLHTTPRequest;
  protected
    procedure InitServerData; override;
    function Get_status: Integer;
    function Get_statusText: WideString;
    function Get_responseXML: IDispatch;
    function Get_responseText: WideString;
    function Get_responseBody: OleVariant;
    function Get_responseStream: OleVariant;
    function Get_readyState: Integer;
    procedure Set_onreadystatechange(const Param1: IDispatch);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXMLHTTPRequest);
    procedure Disconnect; override;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant; 
                   bstrUser: OleVariant); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant; 
                   bstrUser: OleVariant; bstrPassword: OleVariant); overload;
    procedure setRequestHeader(const bstrHeader: WideString; const bstrValue: WideString);
    function getResponseHeader(const bstrHeader: WideString): WideString;
    function getAllResponseHeaders: WideString;
    procedure send; overload;
    procedure send(varBody: OleVariant); overload;
    procedure abort;
    property DefaultInterface: IXMLHTTPRequest read GetDefaultInterface;
    property status: Integer read Get_status;
    property statusText: WideString read Get_statusText;
    property responseXML: IDispatch read Get_responseXML;
    property responseText: WideString read Get_responseText;
    property responseBody: OleVariant read Get_responseBody;
    property responseStream: OleVariant read Get_responseStream;
    property readyState: Integer read Get_readyState;
    property onreadystatechange: IDispatch write Set_onreadystatechange;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TmsXMLHTTP30Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TmsXMLHTTP30
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TmsXMLHTTP30Properties = class(TPersistent)
  private
    FServer:    TmsXMLHTTP30;
    function    GetDefaultInterface: IXMLHTTPRequest;
    constructor Create(AServer: TmsXMLHTTP30);
  protected
    function Get_status: Integer;
    function Get_statusText: WideString;
    function Get_responseXML: IDispatch;
    function Get_responseText: WideString;
    function Get_responseBody: OleVariant;
    function Get_responseStream: OleVariant;
    function Get_readyState: Integer;
    procedure Set_onreadystatechange(const Param1: IDispatch);
  public
    property DefaultInterface: IXMLHTTPRequest read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TXMLHTTP40
// Hilfe-String      : XML HTTP Request class.
// Standard-Interface: IXMLHTTPRequest
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TXMLHTTP40Properties= class;
{$ENDIF}
  TXMLHTTP40 = class(TOleServer)
  private
    FIntf: IXMLHTTPRequest;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TXMLHTTP40Properties;
    function GetServerProperties: TXMLHTTP40Properties;
{$ENDIF}
    function GetDefaultInterface: IXMLHTTPRequest;
  protected
    procedure InitServerData; override;
    function Get_status: Integer;
    function Get_statusText: WideString;
    function Get_responseXML: IDispatch;
    function Get_responseText: WideString;
    function Get_responseBody: OleVariant;
    function Get_responseStream: OleVariant;
    function Get_readyState: Integer;
    procedure Set_onreadystatechange(const Param1: IDispatch);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXMLHTTPRequest);
    procedure Disconnect; override;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant; 
                   bstrUser: OleVariant); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant; 
                   bstrUser: OleVariant; bstrPassword: OleVariant); overload;
    procedure setRequestHeader(const bstrHeader: WideString; const bstrValue: WideString);
    function getResponseHeader(const bstrHeader: WideString): WideString;
    function getAllResponseHeaders: WideString;
    procedure send; overload;
    procedure send(varBody: OleVariant); overload;
    procedure abort;
    property DefaultInterface: IXMLHTTPRequest read GetDefaultInterface;
    property status: Integer read Get_status;
    property statusText: WideString read Get_statusText;
    property responseXML: IDispatch read Get_responseXML;
    property responseText: WideString read Get_responseText;
    property responseBody: OleVariant read Get_responseBody;
    property responseStream: OleVariant read Get_responseStream;
    property readyState: Integer read Get_readyState;
    property onreadystatechange: IDispatch write Set_onreadystatechange;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TXMLHTTP40Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TXMLHTTP40
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TXMLHTTP40Properties = class(TPersistent)
  private
    FServer:    TXMLHTTP40;
    function    GetDefaultInterface: IXMLHTTPRequest;
    constructor Create(AServer: TXMLHTTP40);
  protected
    function Get_status: Integer;
    function Get_statusText: WideString;
    function Get_responseXML: IDispatch;
    function Get_responseText: WideString;
    function Get_responseBody: OleVariant;
    function Get_responseStream: OleVariant;
    function Get_readyState: Integer;
    procedure Set_onreadystatechange(const Param1: IDispatch);
  public
    property DefaultInterface: IXMLHTTPRequest read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TXMLHTTP60
// Hilfe-String      : XML HTTP Request class 6.0
// Standard-Interface: IXMLHTTPRequest
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TXMLHTTP60Properties= class;
{$ENDIF}
  TXMLHTTP60 = class(TOleServer)
  private
    FIntf: IXMLHTTPRequest;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TXMLHTTP60Properties;
    function GetServerProperties: TXMLHTTP60Properties;
{$ENDIF}
    function GetDefaultInterface: IXMLHTTPRequest;
  protected
    procedure InitServerData; override;
    function Get_status: Integer;
    function Get_statusText: WideString;
    function Get_responseXML: IDispatch;
    function Get_responseText: WideString;
    function Get_responseBody: OleVariant;
    function Get_responseStream: OleVariant;
    function Get_readyState: Integer;
    procedure Set_onreadystatechange(const Param1: IDispatch);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IXMLHTTPRequest);
    procedure Disconnect; override;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant; 
                   bstrUser: OleVariant); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant; 
                   bstrUser: OleVariant; bstrPassword: OleVariant); overload;
    procedure setRequestHeader(const bstrHeader: WideString; const bstrValue: WideString);
    function getResponseHeader(const bstrHeader: WideString): WideString;
    function getAllResponseHeaders: WideString;
    procedure send; overload;
    procedure send(varBody: OleVariant); overload;
    procedure abort;
    property DefaultInterface: IXMLHTTPRequest read GetDefaultInterface;
    property status: Integer read Get_status;
    property statusText: WideString read Get_statusText;
    property responseXML: IDispatch read Get_responseXML;
    property responseText: WideString read Get_responseText;
    property responseBody: OleVariant read Get_responseBody;
    property responseStream: OleVariant read Get_responseStream;
    property readyState: Integer read Get_readyState;
    property onreadystatechange: IDispatch write Set_onreadystatechange;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TXMLHTTP60Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TXMLHTTP60
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TXMLHTTP60Properties = class(TPersistent)
  private
    FServer:    TXMLHTTP60;
    function    GetDefaultInterface: IXMLHTTPRequest;
    constructor Create(AServer: TXMLHTTP60);
  protected
    function Get_status: Integer;
    function Get_statusText: WideString;
    function Get_responseXML: IDispatch;
    function Get_responseText: WideString;
    function Get_responseBody: OleVariant;
    function Get_responseStream: OleVariant;
    function Get_readyState: Integer;
    procedure Set_onreadystatechange(const Param1: IDispatch);
  public
    property DefaultInterface: IXMLHTTPRequest read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TmsServerXMLHTTP
// Hilfe-String      : Server XML HTTP Request class.
// Standard-Interface: IServerXMLHTTPRequest
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TmsServerXMLHTTPProperties= class;
{$ENDIF}
  TmsServerXMLHTTP = class(TOleServer)
  private
    FIntf: IServerXMLHTTPRequest;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TmsServerXMLHTTPProperties;
    function GetServerProperties: TmsServerXMLHTTPProperties;
{$ENDIF}
    function GetDefaultInterface: IServerXMLHTTPRequest;
  protected
    procedure InitServerData; override;
    function Get_status: Integer;
    function Get_statusText: WideString;
    function Get_responseXML: IDispatch;
    function Get_responseText: WideString;
    function Get_responseBody: OleVariant;
    function Get_responseStream: OleVariant;
    function Get_readyState: Integer;
    procedure Set_onreadystatechange(const Param1: IDispatch);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IServerXMLHTTPRequest);
    procedure Disconnect; override;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant; 
                   bstrUser: OleVariant); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant; 
                   bstrUser: OleVariant; bstrPassword: OleVariant); overload;
    procedure setRequestHeader(const bstrHeader: WideString; const bstrValue: WideString);
    function getResponseHeader(const bstrHeader: WideString): WideString;
    function getAllResponseHeaders: WideString;
    procedure send; overload;
    procedure send(varBody: OleVariant); overload;
    procedure abort;
    procedure setTimeouts(resolveTimeout: Integer; connectTimeout: Integer; sendTimeout: Integer; 
                          receiveTimeout: Integer);
    function waitForResponse: WordBool; overload;
    function waitForResponse(timeoutInSeconds: OleVariant): WordBool; overload;
    function getOption(option: SERVERXMLHTTP_OPTION): OleVariant;
    procedure setOption(option: SERVERXMLHTTP_OPTION; value: OleVariant);
    property DefaultInterface: IServerXMLHTTPRequest read GetDefaultInterface;
    property status: Integer read Get_status;
    property statusText: WideString read Get_statusText;
    property responseXML: IDispatch read Get_responseXML;
    property responseText: WideString read Get_responseText;
    property responseBody: OleVariant read Get_responseBody;
    property responseStream: OleVariant read Get_responseStream;
    property readyState: Integer read Get_readyState;
    property onreadystatechange: IDispatch write Set_onreadystatechange;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TmsServerXMLHTTPProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TmsServerXMLHTTP
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TmsServerXMLHTTPProperties = class(TPersistent)
  private
    FServer:    TmsServerXMLHTTP;
    function    GetDefaultInterface: IServerXMLHTTPRequest;
    constructor Create(AServer: TmsServerXMLHTTP);
  protected
    function Get_status: Integer;
    function Get_statusText: WideString;
    function Get_responseXML: IDispatch;
    function Get_responseText: WideString;
    function Get_responseBody: OleVariant;
    function Get_responseStream: OleVariant;
    function Get_readyState: Integer;
    procedure Set_onreadystatechange(const Param1: IDispatch);
  public
    property DefaultInterface: IServerXMLHTTPRequest read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TmsServerXMLHTTP30
// Hilfe-String      : Server XML HTTP Request class.
// Standard-Interface: IServerXMLHTTPRequest
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TmsServerXMLHTTP30Properties= class;
{$ENDIF}
  TmsServerXMLHTTP30 = class(TOleServer)
  private
    FIntf: IServerXMLHTTPRequest;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TmsServerXMLHTTP30Properties;
    function GetServerProperties: TmsServerXMLHTTP30Properties;
{$ENDIF}
    function GetDefaultInterface: IServerXMLHTTPRequest;
  protected
    procedure InitServerData; override;
    function Get_status: Integer;
    function Get_statusText: WideString;
    function Get_responseXML: IDispatch;
    function Get_responseText: WideString;
    function Get_responseBody: OleVariant;
    function Get_responseStream: OleVariant;
    function Get_readyState: Integer;
    procedure Set_onreadystatechange(const Param1: IDispatch);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IServerXMLHTTPRequest);
    procedure Disconnect; override;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant; 
                   bstrUser: OleVariant); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant; 
                   bstrUser: OleVariant; bstrPassword: OleVariant); overload;
    procedure setRequestHeader(const bstrHeader: WideString; const bstrValue: WideString);
    function getResponseHeader(const bstrHeader: WideString): WideString;
    function getAllResponseHeaders: WideString;
    procedure send; overload;
    procedure send(varBody: OleVariant); overload;
    procedure abort;
    procedure setTimeouts(resolveTimeout: Integer; connectTimeout: Integer; sendTimeout: Integer; 
                          receiveTimeout: Integer);
    function waitForResponse: WordBool; overload;
    function waitForResponse(timeoutInSeconds: OleVariant): WordBool; overload;
    function getOption(option: SERVERXMLHTTP_OPTION): OleVariant;
    procedure setOption(option: SERVERXMLHTTP_OPTION; value: OleVariant);
    property DefaultInterface: IServerXMLHTTPRequest read GetDefaultInterface;
    property status: Integer read Get_status;
    property statusText: WideString read Get_statusText;
    property responseXML: IDispatch read Get_responseXML;
    property responseText: WideString read Get_responseText;
    property responseBody: OleVariant read Get_responseBody;
    property responseStream: OleVariant read Get_responseStream;
    property readyState: Integer read Get_readyState;
    property onreadystatechange: IDispatch write Set_onreadystatechange;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TmsServerXMLHTTP30Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TmsServerXMLHTTP30
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TmsServerXMLHTTP30Properties = class(TPersistent)
  private
    FServer:    TmsServerXMLHTTP30;
    function    GetDefaultInterface: IServerXMLHTTPRequest;
    constructor Create(AServer: TmsServerXMLHTTP30);
  protected
    function Get_status: Integer;
    function Get_statusText: WideString;
    function Get_responseXML: IDispatch;
    function Get_responseText: WideString;
    function Get_responseBody: OleVariant;
    function Get_responseStream: OleVariant;
    function Get_readyState: Integer;
    procedure Set_onreadystatechange(const Param1: IDispatch);
  public
    property DefaultInterface: IServerXMLHTTPRequest read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TServerXMLHTTP40
// Hilfe-String      : Server XML HTTP Request class.
// Standard-Interface: IServerXMLHTTPRequest2
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TServerXMLHTTP40Properties= class;
{$ENDIF}
  TServerXMLHTTP40 = class(TOleServer)
  private
    FIntf: IServerXMLHTTPRequest2;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TServerXMLHTTP40Properties;
    function GetServerProperties: TServerXMLHTTP40Properties;
{$ENDIF}
    function GetDefaultInterface: IServerXMLHTTPRequest2;
  protected
    procedure InitServerData; override;
    function Get_status: Integer;
    function Get_statusText: WideString;
    function Get_responseXML: IDispatch;
    function Get_responseText: WideString;
    function Get_responseBody: OleVariant;
    function Get_responseStream: OleVariant;
    function Get_readyState: Integer;
    procedure Set_onreadystatechange(const Param1: IDispatch);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IServerXMLHTTPRequest2);
    procedure Disconnect; override;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant; 
                   bstrUser: OleVariant); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant; 
                   bstrUser: OleVariant; bstrPassword: OleVariant); overload;
    procedure setRequestHeader(const bstrHeader: WideString; const bstrValue: WideString);
    function getResponseHeader(const bstrHeader: WideString): WideString;
    function getAllResponseHeaders: WideString;
    procedure send; overload;
    procedure send(varBody: OleVariant); overload;
    procedure abort;
    procedure setTimeouts(resolveTimeout: Integer; connectTimeout: Integer; sendTimeout: Integer; 
                          receiveTimeout: Integer);
    function waitForResponse: WordBool; overload;
    function waitForResponse(timeoutInSeconds: OleVariant): WordBool; overload;
    function getOption(option: SERVERXMLHTTP_OPTION): OleVariant;
    procedure setOption(option: SERVERXMLHTTP_OPTION; value: OleVariant);
    procedure setProxy(proxySetting: SXH_PROXY_SETTING); overload;
    procedure setProxy(proxySetting: SXH_PROXY_SETTING; varProxyServer: OleVariant); overload;
    procedure setProxy(proxySetting: SXH_PROXY_SETTING; varProxyServer: OleVariant; 
                       varBypassList: OleVariant); overload;
    procedure setProxyCredentials(const bstrUserName: WideString; const bstrPassword: WideString);
    property DefaultInterface: IServerXMLHTTPRequest2 read GetDefaultInterface;
    property status: Integer read Get_status;
    property statusText: WideString read Get_statusText;
    property responseXML: IDispatch read Get_responseXML;
    property responseText: WideString read Get_responseText;
    property responseBody: OleVariant read Get_responseBody;
    property responseStream: OleVariant read Get_responseStream;
    property readyState: Integer read Get_readyState;
    property onreadystatechange: IDispatch write Set_onreadystatechange;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TServerXMLHTTP40Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TServerXMLHTTP40
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TServerXMLHTTP40Properties = class(TPersistent)
  private
    FServer:    TServerXMLHTTP40;
    function    GetDefaultInterface: IServerXMLHTTPRequest2;
    constructor Create(AServer: TServerXMLHTTP40);
  protected
    function Get_status: Integer;
    function Get_statusText: WideString;
    function Get_responseXML: IDispatch;
    function Get_responseText: WideString;
    function Get_responseBody: OleVariant;
    function Get_responseStream: OleVariant;
    function Get_readyState: Integer;
    procedure Set_onreadystatechange(const Param1: IDispatch);
  public
    property DefaultInterface: IServerXMLHTTPRequest2 read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TServerXMLHTTP60
// Hilfe-String      : Server XML HTTP Request 6.0 
// Standard-Interface: IServerXMLHTTPRequest2
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TServerXMLHTTP60Properties= class;
{$ENDIF}
  TServerXMLHTTP60 = class(TOleServer)
  private
    FIntf: IServerXMLHTTPRequest2;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TServerXMLHTTP60Properties;
    function GetServerProperties: TServerXMLHTTP60Properties;
{$ENDIF}
    function GetDefaultInterface: IServerXMLHTTPRequest2;
  protected
    procedure InitServerData; override;
    function Get_status: Integer;
    function Get_statusText: WideString;
    function Get_responseXML: IDispatch;
    function Get_responseText: WideString;
    function Get_responseBody: OleVariant;
    function Get_responseStream: OleVariant;
    function Get_readyState: Integer;
    procedure Set_onreadystatechange(const Param1: IDispatch);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IServerXMLHTTPRequest2);
    procedure Disconnect; override;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant; 
                   bstrUser: OleVariant); overload;
    procedure open(const bstrMethod: WideString; const bstrUrl: WideString; varAsync: OleVariant; 
                   bstrUser: OleVariant; bstrPassword: OleVariant); overload;
    procedure setRequestHeader(const bstrHeader: WideString; const bstrValue: WideString);
    function getResponseHeader(const bstrHeader: WideString): WideString;
    function getAllResponseHeaders: WideString;
    procedure send; overload;
    procedure send(varBody: OleVariant); overload;
    procedure abort;
    procedure setTimeouts(resolveTimeout: Integer; connectTimeout: Integer; sendTimeout: Integer; 
                          receiveTimeout: Integer);
    function waitForResponse: WordBool; overload;
    function waitForResponse(timeoutInSeconds: OleVariant): WordBool; overload;
    function getOption(option: SERVERXMLHTTP_OPTION): OleVariant;
    procedure setOption(option: SERVERXMLHTTP_OPTION; value: OleVariant);
    procedure setProxy(proxySetting: SXH_PROXY_SETTING); overload;
    procedure setProxy(proxySetting: SXH_PROXY_SETTING; varProxyServer: OleVariant); overload;
    procedure setProxy(proxySetting: SXH_PROXY_SETTING; varProxyServer: OleVariant; 
                       varBypassList: OleVariant); overload;
    procedure setProxyCredentials(const bstrUserName: WideString; const bstrPassword: WideString);
    property DefaultInterface: IServerXMLHTTPRequest2 read GetDefaultInterface;
    property status: Integer read Get_status;
    property statusText: WideString read Get_statusText;
    property responseXML: IDispatch read Get_responseXML;
    property responseText: WideString read Get_responseText;
    property responseBody: OleVariant read Get_responseBody;
    property responseStream: OleVariant read Get_responseStream;
    property readyState: Integer read Get_readyState;
    property onreadystatechange: IDispatch write Set_onreadystatechange;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TServerXMLHTTP60Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TServerXMLHTTP60
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TServerXMLHTTP60Properties = class(TPersistent)
  private
    FServer:    TServerXMLHTTP60;
    function    GetDefaultInterface: IServerXMLHTTPRequest2;
    constructor Create(AServer: TServerXMLHTTP60);
  protected
    function Get_status: Integer;
    function Get_statusText: WideString;
    function Get_responseXML: IDispatch;
    function Get_responseText: WideString;
    function Get_responseBody: OleVariant;
    function Get_responseStream: OleVariant;
    function Get_readyState: Integer;
    procedure Set_onreadystatechange(const Param1: IDispatch);
  public
    property DefaultInterface: IServerXMLHTTPRequest2 read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TmsSAXXMLReader
// Hilfe-String      : SAX XML Reader (version independent) coclass
// Standard-Interface: IVBSAXXMLReader
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TmsSAXXMLReaderProperties= class;
{$ENDIF}
  TmsSAXXMLReader = class(TOleServer)
  private
    FIntf: IVBSAXXMLReader;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TmsSAXXMLReaderProperties;
    function GetServerProperties: TmsSAXXMLReaderProperties;
{$ENDIF}
    function GetDefaultInterface: IVBSAXXMLReader;
  protected
    procedure InitServerData; override;
    function Get_entityResolver: IVBSAXEntityResolver;
    procedure _Set_entityResolver(const oResolver: IVBSAXEntityResolver);
    function Get_contentHandler: IVBSAXContentHandler;
    procedure _Set_contentHandler(const oHandler: IVBSAXContentHandler);
    function Get_dtdHandler: IVBSAXDTDHandler;
    procedure _Set_dtdHandler(const oHandler: IVBSAXDTDHandler);
    function Get_errorHandler: IVBSAXErrorHandler;
    procedure _Set_errorHandler(const oHandler: IVBSAXErrorHandler);
    function Get_baseURL: WideString;
    procedure Set_baseURL(const strBaseURL: WideString);
    function Get_secureBaseURL: WideString;
    procedure Set_secureBaseURL(const strSecureBaseURL: WideString);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IVBSAXXMLReader);
    procedure Disconnect; override;
    function getFeature(const strName: WideString): WordBool;
    procedure putFeature(const strName: WideString; fValue: WordBool);
    function getProperty(const strName: WideString): OleVariant;
    procedure putProperty(const strName: WideString; varValue: OleVariant);
    procedure parse; overload;
    procedure parse(varInput: OleVariant); overload;
    procedure parseURL(const strURL: WideString);
    property DefaultInterface: IVBSAXXMLReader read GetDefaultInterface;
    property entityResolver: IVBSAXEntityResolver read Get_entityResolver write _Set_entityResolver;
    property contentHandler: IVBSAXContentHandler read Get_contentHandler write _Set_contentHandler;
    property dtdHandler: IVBSAXDTDHandler read Get_dtdHandler write _Set_dtdHandler;
    property errorHandler: IVBSAXErrorHandler read Get_errorHandler write _Set_errorHandler;
    property baseURL: WideString read Get_baseURL write Set_baseURL;
    property secureBaseURL: WideString read Get_secureBaseURL write Set_secureBaseURL;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TmsSAXXMLReaderProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TmsSAXXMLReader
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TmsSAXXMLReaderProperties = class(TPersistent)
  private
    FServer:    TmsSAXXMLReader;
    function    GetDefaultInterface: IVBSAXXMLReader;
    constructor Create(AServer: TmsSAXXMLReader);
  protected
    function Get_entityResolver: IVBSAXEntityResolver;
    procedure _Set_entityResolver(const oResolver: IVBSAXEntityResolver);
    function Get_contentHandler: IVBSAXContentHandler;
    procedure _Set_contentHandler(const oHandler: IVBSAXContentHandler);
    function Get_dtdHandler: IVBSAXDTDHandler;
    procedure _Set_dtdHandler(const oHandler: IVBSAXDTDHandler);
    function Get_errorHandler: IVBSAXErrorHandler;
    procedure _Set_errorHandler(const oHandler: IVBSAXErrorHandler);
    function Get_baseURL: WideString;
    procedure Set_baseURL(const strBaseURL: WideString);
    function Get_secureBaseURL: WideString;
    procedure Set_secureBaseURL(const strSecureBaseURL: WideString);
  public
    property DefaultInterface: IVBSAXXMLReader read GetDefaultInterface;
  published
    property baseURL: WideString read Get_baseURL write Set_baseURL;
    property secureBaseURL: WideString read Get_secureBaseURL write Set_secureBaseURL;
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TmsSAXXMLReader30
// Hilfe-String      : SAX XML Reader 3.0 coclass
// Standard-Interface: IVBSAXXMLReader
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TmsSAXXMLReader30Properties= class;
{$ENDIF}
  TmsSAXXMLReader30 = class(TOleServer)
  private
    FIntf: IVBSAXXMLReader;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TmsSAXXMLReader30Properties;
    function GetServerProperties: TmsSAXXMLReader30Properties;
{$ENDIF}
    function GetDefaultInterface: IVBSAXXMLReader;
  protected
    procedure InitServerData; override;
    function Get_entityResolver: IVBSAXEntityResolver;
    procedure _Set_entityResolver(const oResolver: IVBSAXEntityResolver);
    function Get_contentHandler: IVBSAXContentHandler;
    procedure _Set_contentHandler(const oHandler: IVBSAXContentHandler);
    function Get_dtdHandler: IVBSAXDTDHandler;
    procedure _Set_dtdHandler(const oHandler: IVBSAXDTDHandler);
    function Get_errorHandler: IVBSAXErrorHandler;
    procedure _Set_errorHandler(const oHandler: IVBSAXErrorHandler);
    function Get_baseURL: WideString;
    procedure Set_baseURL(const strBaseURL: WideString);
    function Get_secureBaseURL: WideString;
    procedure Set_secureBaseURL(const strSecureBaseURL: WideString);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IVBSAXXMLReader);
    procedure Disconnect; override;
    function getFeature(const strName: WideString): WordBool;
    procedure putFeature(const strName: WideString; fValue: WordBool);
    function getProperty(const strName: WideString): OleVariant;
    procedure putProperty(const strName: WideString; varValue: OleVariant);
    procedure parse; overload;
    procedure parse(varInput: OleVariant); overload;
    procedure parseURL(const strURL: WideString);
    property DefaultInterface: IVBSAXXMLReader read GetDefaultInterface;
    property entityResolver: IVBSAXEntityResolver read Get_entityResolver write _Set_entityResolver;
    property contentHandler: IVBSAXContentHandler read Get_contentHandler write _Set_contentHandler;
    property dtdHandler: IVBSAXDTDHandler read Get_dtdHandler write _Set_dtdHandler;
    property errorHandler: IVBSAXErrorHandler read Get_errorHandler write _Set_errorHandler;
    property baseURL: WideString read Get_baseURL write Set_baseURL;
    property secureBaseURL: WideString read Get_secureBaseURL write Set_secureBaseURL;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TmsSAXXMLReader30Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TmsSAXXMLReader30
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TmsSAXXMLReader30Properties = class(TPersistent)
  private
    FServer:    TmsSAXXMLReader30;
    function    GetDefaultInterface: IVBSAXXMLReader;
    constructor Create(AServer: TmsSAXXMLReader30);
  protected
    function Get_entityResolver: IVBSAXEntityResolver;
    procedure _Set_entityResolver(const oResolver: IVBSAXEntityResolver);
    function Get_contentHandler: IVBSAXContentHandler;
    procedure _Set_contentHandler(const oHandler: IVBSAXContentHandler);
    function Get_dtdHandler: IVBSAXDTDHandler;
    procedure _Set_dtdHandler(const oHandler: IVBSAXDTDHandler);
    function Get_errorHandler: IVBSAXErrorHandler;
    procedure _Set_errorHandler(const oHandler: IVBSAXErrorHandler);
    function Get_baseURL: WideString;
    procedure Set_baseURL(const strBaseURL: WideString);
    function Get_secureBaseURL: WideString;
    procedure Set_secureBaseURL(const strSecureBaseURL: WideString);
  public
    property DefaultInterface: IVBSAXXMLReader read GetDefaultInterface;
  published
    property baseURL: WideString read Get_baseURL write Set_baseURL;
    property secureBaseURL: WideString read Get_secureBaseURL write Set_secureBaseURL;
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TSAXXMLReader40
// Hilfe-String      : SAX XML Reader 4.0 coclass
// Standard-Interface: IVBSAXXMLReader
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TSAXXMLReader40Properties= class;
{$ENDIF}
  TSAXXMLReader40 = class(TOleServer)
  private
    FIntf: IVBSAXXMLReader;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TSAXXMLReader40Properties;
    function GetServerProperties: TSAXXMLReader40Properties;
{$ENDIF}
    function GetDefaultInterface: IVBSAXXMLReader;
  protected
    procedure InitServerData; override;
    function Get_entityResolver: IVBSAXEntityResolver;
    procedure _Set_entityResolver(const oResolver: IVBSAXEntityResolver);
    function Get_contentHandler: IVBSAXContentHandler;
    procedure _Set_contentHandler(const oHandler: IVBSAXContentHandler);
    function Get_dtdHandler: IVBSAXDTDHandler;
    procedure _Set_dtdHandler(const oHandler: IVBSAXDTDHandler);
    function Get_errorHandler: IVBSAXErrorHandler;
    procedure _Set_errorHandler(const oHandler: IVBSAXErrorHandler);
    function Get_baseURL: WideString;
    procedure Set_baseURL(const strBaseURL: WideString);
    function Get_secureBaseURL: WideString;
    procedure Set_secureBaseURL(const strSecureBaseURL: WideString);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IVBSAXXMLReader);
    procedure Disconnect; override;
    function getFeature(const strName: WideString): WordBool;
    procedure putFeature(const strName: WideString; fValue: WordBool);
    function getProperty(const strName: WideString): OleVariant;
    procedure putProperty(const strName: WideString; varValue: OleVariant);
    procedure parse; overload;
    procedure parse(varInput: OleVariant); overload;
    procedure parseURL(const strURL: WideString);
    property DefaultInterface: IVBSAXXMLReader read GetDefaultInterface;
    property entityResolver: IVBSAXEntityResolver read Get_entityResolver write _Set_entityResolver;
    property contentHandler: IVBSAXContentHandler read Get_contentHandler write _Set_contentHandler;
    property dtdHandler: IVBSAXDTDHandler read Get_dtdHandler write _Set_dtdHandler;
    property errorHandler: IVBSAXErrorHandler read Get_errorHandler write _Set_errorHandler;
    property baseURL: WideString read Get_baseURL write Set_baseURL;
    property secureBaseURL: WideString read Get_secureBaseURL write Set_secureBaseURL;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TSAXXMLReader40Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TSAXXMLReader40
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TSAXXMLReader40Properties = class(TPersistent)
  private
    FServer:    TSAXXMLReader40;
    function    GetDefaultInterface: IVBSAXXMLReader;
    constructor Create(AServer: TSAXXMLReader40);
  protected
    function Get_entityResolver: IVBSAXEntityResolver;
    procedure _Set_entityResolver(const oResolver: IVBSAXEntityResolver);
    function Get_contentHandler: IVBSAXContentHandler;
    procedure _Set_contentHandler(const oHandler: IVBSAXContentHandler);
    function Get_dtdHandler: IVBSAXDTDHandler;
    procedure _Set_dtdHandler(const oHandler: IVBSAXDTDHandler);
    function Get_errorHandler: IVBSAXErrorHandler;
    procedure _Set_errorHandler(const oHandler: IVBSAXErrorHandler);
    function Get_baseURL: WideString;
    procedure Set_baseURL(const strBaseURL: WideString);
    function Get_secureBaseURL: WideString;
    procedure Set_secureBaseURL(const strSecureBaseURL: WideString);
  public
    property DefaultInterface: IVBSAXXMLReader read GetDefaultInterface;
  published
    property baseURL: WideString read Get_baseURL write Set_baseURL;
    property secureBaseURL: WideString read Get_secureBaseURL write Set_secureBaseURL;
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TSAXXMLReader60
// Hilfe-String      : SAX XML Reader 6.0
// Standard-Interface: IVBSAXXMLReader
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TSAXXMLReader60Properties= class;
{$ENDIF}
  TSAXXMLReader60 = class(TOleServer)
  private
    FIntf: IVBSAXXMLReader;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TSAXXMLReader60Properties;
    function GetServerProperties: TSAXXMLReader60Properties;
{$ENDIF}
    function GetDefaultInterface: IVBSAXXMLReader;
  protected
    procedure InitServerData; override;
    function Get_entityResolver: IVBSAXEntityResolver;
    procedure _Set_entityResolver(const oResolver: IVBSAXEntityResolver);
    function Get_contentHandler: IVBSAXContentHandler;
    procedure _Set_contentHandler(const oHandler: IVBSAXContentHandler);
    function Get_dtdHandler: IVBSAXDTDHandler;
    procedure _Set_dtdHandler(const oHandler: IVBSAXDTDHandler);
    function Get_errorHandler: IVBSAXErrorHandler;
    procedure _Set_errorHandler(const oHandler: IVBSAXErrorHandler);
    function Get_baseURL: WideString;
    procedure Set_baseURL(const strBaseURL: WideString);
    function Get_secureBaseURL: WideString;
    procedure Set_secureBaseURL(const strSecureBaseURL: WideString);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IVBSAXXMLReader);
    procedure Disconnect; override;
    function getFeature(const strName: WideString): WordBool;
    procedure putFeature(const strName: WideString; fValue: WordBool);
    function getProperty(const strName: WideString): OleVariant;
    procedure putProperty(const strName: WideString; varValue: OleVariant);
    procedure parse; overload;
    procedure parse(varInput: OleVariant); overload;
    procedure parseURL(const strURL: WideString);
    property DefaultInterface: IVBSAXXMLReader read GetDefaultInterface;
    property entityResolver: IVBSAXEntityResolver read Get_entityResolver write _Set_entityResolver;
    property contentHandler: IVBSAXContentHandler read Get_contentHandler write _Set_contentHandler;
    property dtdHandler: IVBSAXDTDHandler read Get_dtdHandler write _Set_dtdHandler;
    property errorHandler: IVBSAXErrorHandler read Get_errorHandler write _Set_errorHandler;
    property baseURL: WideString read Get_baseURL write Set_baseURL;
    property secureBaseURL: WideString read Get_secureBaseURL write Set_secureBaseURL;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TSAXXMLReader60Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TSAXXMLReader60
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TSAXXMLReader60Properties = class(TPersistent)
  private
    FServer:    TSAXXMLReader60;
    function    GetDefaultInterface: IVBSAXXMLReader;
    constructor Create(AServer: TSAXXMLReader60);
  protected
    function Get_entityResolver: IVBSAXEntityResolver;
    procedure _Set_entityResolver(const oResolver: IVBSAXEntityResolver);
    function Get_contentHandler: IVBSAXContentHandler;
    procedure _Set_contentHandler(const oHandler: IVBSAXContentHandler);
    function Get_dtdHandler: IVBSAXDTDHandler;
    procedure _Set_dtdHandler(const oHandler: IVBSAXDTDHandler);
    function Get_errorHandler: IVBSAXErrorHandler;
    procedure _Set_errorHandler(const oHandler: IVBSAXErrorHandler);
    function Get_baseURL: WideString;
    procedure Set_baseURL(const strBaseURL: WideString);
    function Get_secureBaseURL: WideString;
    procedure Set_secureBaseURL(const strSecureBaseURL: WideString);
  public
    property DefaultInterface: IVBSAXXMLReader read GetDefaultInterface;
  published
    property baseURL: WideString read Get_baseURL write Set_baseURL;
    property secureBaseURL: WideString read Get_secureBaseURL write Set_secureBaseURL;
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TmsMXXMLWriter
// Hilfe-String      : Microsoft XML Writer (version independent) coclass
// Standard-Interface: IMXWriter
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TmsMXXMLWriterProperties= class;
{$ENDIF}
  TmsMXXMLWriter = class(TOleServer)
  private
    FIntf: IMXWriter;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TmsMXXMLWriterProperties;
    function GetServerProperties: TmsMXXMLWriterProperties;
{$ENDIF}
    function GetDefaultInterface: IMXWriter;
  protected
    procedure InitServerData; override;
    procedure Set_output(varDestination: OleVariant);
    function Get_output: OleVariant;
    procedure Set_encoding(const strEncoding: WideString);
    function Get_encoding: WideString;
    procedure Set_byteOrderMark(fWriteByteOrderMark: WordBool);
    function Get_byteOrderMark: WordBool;
    procedure Set_indent(fIndentMode: WordBool);
    function Get_indent: WordBool;
    procedure Set_standalone(fValue: WordBool);
    function Get_standalone: WordBool;
    procedure Set_omitXMLDeclaration(fValue: WordBool);
    function Get_omitXMLDeclaration: WordBool;
    procedure Set_version(const strVersion: WideString);
    function Get_version: WideString;
    procedure Set_disableOutputEscaping(fValue: WordBool);
    function Get_disableOutputEscaping: WordBool;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IMXWriter);
    procedure Disconnect; override;
    procedure flush;
    property DefaultInterface: IMXWriter read GetDefaultInterface;
    property output: OleVariant read Get_output write Set_output;
    property encoding: WideString read Get_encoding write Set_encoding;
    property byteOrderMark: WordBool read Get_byteOrderMark write Set_byteOrderMark;
    property indent: WordBool read Get_indent write Set_indent;
    property standalone: WordBool read Get_standalone write Set_standalone;
    property omitXMLDeclaration: WordBool read Get_omitXMLDeclaration write Set_omitXMLDeclaration;
    property version: WideString read Get_version write Set_version;
    property disableOutputEscaping: WordBool read Get_disableOutputEscaping write Set_disableOutputEscaping;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TmsMXXMLWriterProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TmsMXXMLWriter
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TmsMXXMLWriterProperties = class(TPersistent)
  private
    FServer:    TmsMXXMLWriter;
    function    GetDefaultInterface: IMXWriter;
    constructor Create(AServer: TmsMXXMLWriter);
  protected
    procedure Set_output(varDestination: OleVariant);
    function Get_output: OleVariant;
    procedure Set_encoding(const strEncoding: WideString);
    function Get_encoding: WideString;
    procedure Set_byteOrderMark(fWriteByteOrderMark: WordBool);
    function Get_byteOrderMark: WordBool;
    procedure Set_indent(fIndentMode: WordBool);
    function Get_indent: WordBool;
    procedure Set_standalone(fValue: WordBool);
    function Get_standalone: WordBool;
    procedure Set_omitXMLDeclaration(fValue: WordBool);
    function Get_omitXMLDeclaration: WordBool;
    procedure Set_version(const strVersion: WideString);
    function Get_version: WideString;
    procedure Set_disableOutputEscaping(fValue: WordBool);
    function Get_disableOutputEscaping: WordBool;
  public
    property DefaultInterface: IMXWriter read GetDefaultInterface;
  published
    property encoding: WideString read Get_encoding write Set_encoding;
    property byteOrderMark: WordBool read Get_byteOrderMark write Set_byteOrderMark;
    property indent: WordBool read Get_indent write Set_indent;
    property standalone: WordBool read Get_standalone write Set_standalone;
    property omitXMLDeclaration: WordBool read Get_omitXMLDeclaration write Set_omitXMLDeclaration;
    property version: WideString read Get_version write Set_version;
    property disableOutputEscaping: WordBool read Get_disableOutputEscaping write Set_disableOutputEscaping;
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TmsMXXMLWriter30
// Hilfe-String      : Microsoft XML Writer 3.0 coclass
// Standard-Interface: IMXWriter
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TmsMXXMLWriter30Properties= class;
{$ENDIF}
  TmsMXXMLWriter30 = class(TOleServer)
  private
    FIntf: IMXWriter;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TmsMXXMLWriter30Properties;
    function GetServerProperties: TmsMXXMLWriter30Properties;
{$ENDIF}
    function GetDefaultInterface: IMXWriter;
  protected
    procedure InitServerData; override;
    procedure Set_output(varDestination: OleVariant);
    function Get_output: OleVariant;
    procedure Set_encoding(const strEncoding: WideString);
    function Get_encoding: WideString;
    procedure Set_byteOrderMark(fWriteByteOrderMark: WordBool);
    function Get_byteOrderMark: WordBool;
    procedure Set_indent(fIndentMode: WordBool);
    function Get_indent: WordBool;
    procedure Set_standalone(fValue: WordBool);
    function Get_standalone: WordBool;
    procedure Set_omitXMLDeclaration(fValue: WordBool);
    function Get_omitXMLDeclaration: WordBool;
    procedure Set_version(const strVersion: WideString);
    function Get_version: WideString;
    procedure Set_disableOutputEscaping(fValue: WordBool);
    function Get_disableOutputEscaping: WordBool;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IMXWriter);
    procedure Disconnect; override;
    procedure flush;
    property DefaultInterface: IMXWriter read GetDefaultInterface;
    property output: OleVariant read Get_output write Set_output;
    property encoding: WideString read Get_encoding write Set_encoding;
    property byteOrderMark: WordBool read Get_byteOrderMark write Set_byteOrderMark;
    property indent: WordBool read Get_indent write Set_indent;
    property standalone: WordBool read Get_standalone write Set_standalone;
    property omitXMLDeclaration: WordBool read Get_omitXMLDeclaration write Set_omitXMLDeclaration;
    property version: WideString read Get_version write Set_version;
    property disableOutputEscaping: WordBool read Get_disableOutputEscaping write Set_disableOutputEscaping;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TmsMXXMLWriter30Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TmsMXXMLWriter30
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TmsMXXMLWriter30Properties = class(TPersistent)
  private
    FServer:    TmsMXXMLWriter30;
    function    GetDefaultInterface: IMXWriter;
    constructor Create(AServer: TmsMXXMLWriter30);
  protected
    procedure Set_output(varDestination: OleVariant);
    function Get_output: OleVariant;
    procedure Set_encoding(const strEncoding: WideString);
    function Get_encoding: WideString;
    procedure Set_byteOrderMark(fWriteByteOrderMark: WordBool);
    function Get_byteOrderMark: WordBool;
    procedure Set_indent(fIndentMode: WordBool);
    function Get_indent: WordBool;
    procedure Set_standalone(fValue: WordBool);
    function Get_standalone: WordBool;
    procedure Set_omitXMLDeclaration(fValue: WordBool);
    function Get_omitXMLDeclaration: WordBool;
    procedure Set_version(const strVersion: WideString);
    function Get_version: WideString;
    procedure Set_disableOutputEscaping(fValue: WordBool);
    function Get_disableOutputEscaping: WordBool;
  public
    property DefaultInterface: IMXWriter read GetDefaultInterface;
  published
    property encoding: WideString read Get_encoding write Set_encoding;
    property byteOrderMark: WordBool read Get_byteOrderMark write Set_byteOrderMark;
    property indent: WordBool read Get_indent write Set_indent;
    property standalone: WordBool read Get_standalone write Set_standalone;
    property omitXMLDeclaration: WordBool read Get_omitXMLDeclaration write Set_omitXMLDeclaration;
    property version: WideString read Get_version write Set_version;
    property disableOutputEscaping: WordBool read Get_disableOutputEscaping write Set_disableOutputEscaping;
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TMXXMLWriter40
// Hilfe-String      : Microsoft XML Writer 4.0 coclass
// Standard-Interface: IMXWriter
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMXXMLWriter40Properties= class;
{$ENDIF}
  TMXXMLWriter40 = class(TOleServer)
  private
    FIntf: IMXWriter;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TMXXMLWriter40Properties;
    function GetServerProperties: TMXXMLWriter40Properties;
{$ENDIF}
    function GetDefaultInterface: IMXWriter;
  protected
    procedure InitServerData; override;
    procedure Set_output(varDestination: OleVariant);
    function Get_output: OleVariant;
    procedure Set_encoding(const strEncoding: WideString);
    function Get_encoding: WideString;
    procedure Set_byteOrderMark(fWriteByteOrderMark: WordBool);
    function Get_byteOrderMark: WordBool;
    procedure Set_indent(fIndentMode: WordBool);
    function Get_indent: WordBool;
    procedure Set_standalone(fValue: WordBool);
    function Get_standalone: WordBool;
    procedure Set_omitXMLDeclaration(fValue: WordBool);
    function Get_omitXMLDeclaration: WordBool;
    procedure Set_version(const strVersion: WideString);
    function Get_version: WideString;
    procedure Set_disableOutputEscaping(fValue: WordBool);
    function Get_disableOutputEscaping: WordBool;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IMXWriter);
    procedure Disconnect; override;
    procedure flush;
    property DefaultInterface: IMXWriter read GetDefaultInterface;
    property output: OleVariant read Get_output write Set_output;
    property encoding: WideString read Get_encoding write Set_encoding;
    property byteOrderMark: WordBool read Get_byteOrderMark write Set_byteOrderMark;
    property indent: WordBool read Get_indent write Set_indent;
    property standalone: WordBool read Get_standalone write Set_standalone;
    property omitXMLDeclaration: WordBool read Get_omitXMLDeclaration write Set_omitXMLDeclaration;
    property version: WideString read Get_version write Set_version;
    property disableOutputEscaping: WordBool read Get_disableOutputEscaping write Set_disableOutputEscaping;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMXXMLWriter40Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TMXXMLWriter40
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TMXXMLWriter40Properties = class(TPersistent)
  private
    FServer:    TMXXMLWriter40;
    function    GetDefaultInterface: IMXWriter;
    constructor Create(AServer: TMXXMLWriter40);
  protected
    procedure Set_output(varDestination: OleVariant);
    function Get_output: OleVariant;
    procedure Set_encoding(const strEncoding: WideString);
    function Get_encoding: WideString;
    procedure Set_byteOrderMark(fWriteByteOrderMark: WordBool);
    function Get_byteOrderMark: WordBool;
    procedure Set_indent(fIndentMode: WordBool);
    function Get_indent: WordBool;
    procedure Set_standalone(fValue: WordBool);
    function Get_standalone: WordBool;
    procedure Set_omitXMLDeclaration(fValue: WordBool);
    function Get_omitXMLDeclaration: WordBool;
    procedure Set_version(const strVersion: WideString);
    function Get_version: WideString;
    procedure Set_disableOutputEscaping(fValue: WordBool);
    function Get_disableOutputEscaping: WordBool;
  public
    property DefaultInterface: IMXWriter read GetDefaultInterface;
  published
    property encoding: WideString read Get_encoding write Set_encoding;
    property byteOrderMark: WordBool read Get_byteOrderMark write Set_byteOrderMark;
    property indent: WordBool read Get_indent write Set_indent;
    property standalone: WordBool read Get_standalone write Set_standalone;
    property omitXMLDeclaration: WordBool read Get_omitXMLDeclaration write Set_omitXMLDeclaration;
    property version: WideString read Get_version write Set_version;
    property disableOutputEscaping: WordBool read Get_disableOutputEscaping write Set_disableOutputEscaping;
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TMXXMLWriter60
// Hilfe-String      : Microsoft XML Writer 6.0
// Standard-Interface: IMXWriter
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMXXMLWriter60Properties= class;
{$ENDIF}
  TMXXMLWriter60 = class(TOleServer)
  private
    FIntf: IMXWriter;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TMXXMLWriter60Properties;
    function GetServerProperties: TMXXMLWriter60Properties;
{$ENDIF}
    function GetDefaultInterface: IMXWriter;
  protected
    procedure InitServerData; override;
    procedure Set_output(varDestination: OleVariant);
    function Get_output: OleVariant;
    procedure Set_encoding(const strEncoding: WideString);
    function Get_encoding: WideString;
    procedure Set_byteOrderMark(fWriteByteOrderMark: WordBool);
    function Get_byteOrderMark: WordBool;
    procedure Set_indent(fIndentMode: WordBool);
    function Get_indent: WordBool;
    procedure Set_standalone(fValue: WordBool);
    function Get_standalone: WordBool;
    procedure Set_omitXMLDeclaration(fValue: WordBool);
    function Get_omitXMLDeclaration: WordBool;
    procedure Set_version(const strVersion: WideString);
    function Get_version: WideString;
    procedure Set_disableOutputEscaping(fValue: WordBool);
    function Get_disableOutputEscaping: WordBool;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IMXWriter);
    procedure Disconnect; override;
    procedure flush;
    property DefaultInterface: IMXWriter read GetDefaultInterface;
    property output: OleVariant read Get_output write Set_output;
    property encoding: WideString read Get_encoding write Set_encoding;
    property byteOrderMark: WordBool read Get_byteOrderMark write Set_byteOrderMark;
    property indent: WordBool read Get_indent write Set_indent;
    property standalone: WordBool read Get_standalone write Set_standalone;
    property omitXMLDeclaration: WordBool read Get_omitXMLDeclaration write Set_omitXMLDeclaration;
    property version: WideString read Get_version write Set_version;
    property disableOutputEscaping: WordBool read Get_disableOutputEscaping write Set_disableOutputEscaping;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMXXMLWriter60Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TMXXMLWriter60
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TMXXMLWriter60Properties = class(TPersistent)
  private
    FServer:    TMXXMLWriter60;
    function    GetDefaultInterface: IMXWriter;
    constructor Create(AServer: TMXXMLWriter60);
  protected
    procedure Set_output(varDestination: OleVariant);
    function Get_output: OleVariant;
    procedure Set_encoding(const strEncoding: WideString);
    function Get_encoding: WideString;
    procedure Set_byteOrderMark(fWriteByteOrderMark: WordBool);
    function Get_byteOrderMark: WordBool;
    procedure Set_indent(fIndentMode: WordBool);
    function Get_indent: WordBool;
    procedure Set_standalone(fValue: WordBool);
    function Get_standalone: WordBool;
    procedure Set_omitXMLDeclaration(fValue: WordBool);
    function Get_omitXMLDeclaration: WordBool;
    procedure Set_version(const strVersion: WideString);
    function Get_version: WideString;
    procedure Set_disableOutputEscaping(fValue: WordBool);
    function Get_disableOutputEscaping: WordBool;
  public
    property DefaultInterface: IMXWriter read GetDefaultInterface;
  published
    property encoding: WideString read Get_encoding write Set_encoding;
    property byteOrderMark: WordBool read Get_byteOrderMark write Set_byteOrderMark;
    property indent: WordBool read Get_indent write Set_indent;
    property standalone: WordBool read Get_standalone write Set_standalone;
    property omitXMLDeclaration: WordBool read Get_omitXMLDeclaration write Set_omitXMLDeclaration;
    property version: WideString read Get_version write Set_version;
    property disableOutputEscaping: WordBool read Get_disableOutputEscaping write Set_disableOutputEscaping;
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TMXHTMLWriter
// Hilfe-String      : Microsoft HTML Writer (version independent) coclass
// Standard-Interface: IMXWriter
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMXHTMLWriterProperties= class;
{$ENDIF}
  TMXHTMLWriter = class(TOleServer)
  private
    FIntf: IMXWriter;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TMXHTMLWriterProperties;
    function GetServerProperties: TMXHTMLWriterProperties;
{$ENDIF}
    function GetDefaultInterface: IMXWriter;
  protected
    procedure InitServerData; override;
    procedure Set_output(varDestination: OleVariant);
    function Get_output: OleVariant;
    procedure Set_encoding(const strEncoding: WideString);
    function Get_encoding: WideString;
    procedure Set_byteOrderMark(fWriteByteOrderMark: WordBool);
    function Get_byteOrderMark: WordBool;
    procedure Set_indent(fIndentMode: WordBool);
    function Get_indent: WordBool;
    procedure Set_standalone(fValue: WordBool);
    function Get_standalone: WordBool;
    procedure Set_omitXMLDeclaration(fValue: WordBool);
    function Get_omitXMLDeclaration: WordBool;
    procedure Set_version(const strVersion: WideString);
    function Get_version: WideString;
    procedure Set_disableOutputEscaping(fValue: WordBool);
    function Get_disableOutputEscaping: WordBool;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IMXWriter);
    procedure Disconnect; override;
    procedure flush;
    property DefaultInterface: IMXWriter read GetDefaultInterface;
    property output: OleVariant read Get_output write Set_output;
    property encoding: WideString read Get_encoding write Set_encoding;
    property byteOrderMark: WordBool read Get_byteOrderMark write Set_byteOrderMark;
    property indent: WordBool read Get_indent write Set_indent;
    property standalone: WordBool read Get_standalone write Set_standalone;
    property omitXMLDeclaration: WordBool read Get_omitXMLDeclaration write Set_omitXMLDeclaration;
    property version: WideString read Get_version write Set_version;
    property disableOutputEscaping: WordBool read Get_disableOutputEscaping write Set_disableOutputEscaping;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMXHTMLWriterProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TMXHTMLWriter
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TMXHTMLWriterProperties = class(TPersistent)
  private
    FServer:    TMXHTMLWriter;
    function    GetDefaultInterface: IMXWriter;
    constructor Create(AServer: TMXHTMLWriter);
  protected
    procedure Set_output(varDestination: OleVariant);
    function Get_output: OleVariant;
    procedure Set_encoding(const strEncoding: WideString);
    function Get_encoding: WideString;
    procedure Set_byteOrderMark(fWriteByteOrderMark: WordBool);
    function Get_byteOrderMark: WordBool;
    procedure Set_indent(fIndentMode: WordBool);
    function Get_indent: WordBool;
    procedure Set_standalone(fValue: WordBool);
    function Get_standalone: WordBool;
    procedure Set_omitXMLDeclaration(fValue: WordBool);
    function Get_omitXMLDeclaration: WordBool;
    procedure Set_version(const strVersion: WideString);
    function Get_version: WideString;
    procedure Set_disableOutputEscaping(fValue: WordBool);
    function Get_disableOutputEscaping: WordBool;
  public
    property DefaultInterface: IMXWriter read GetDefaultInterface;
  published
    property encoding: WideString read Get_encoding write Set_encoding;
    property byteOrderMark: WordBool read Get_byteOrderMark write Set_byteOrderMark;
    property indent: WordBool read Get_indent write Set_indent;
    property standalone: WordBool read Get_standalone write Set_standalone;
    property omitXMLDeclaration: WordBool read Get_omitXMLDeclaration write Set_omitXMLDeclaration;
    property version: WideString read Get_version write Set_version;
    property disableOutputEscaping: WordBool read Get_disableOutputEscaping write Set_disableOutputEscaping;
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TMXHTMLWriter30
// Hilfe-String      : Microsoft HTML Writer 3.0 coclass
// Standard-Interface: IMXWriter
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMXHTMLWriter30Properties= class;
{$ENDIF}
  TMXHTMLWriter30 = class(TOleServer)
  private
    FIntf: IMXWriter;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TMXHTMLWriter30Properties;
    function GetServerProperties: TMXHTMLWriter30Properties;
{$ENDIF}
    function GetDefaultInterface: IMXWriter;
  protected
    procedure InitServerData; override;
    procedure Set_output(varDestination: OleVariant);
    function Get_output: OleVariant;
    procedure Set_encoding(const strEncoding: WideString);
    function Get_encoding: WideString;
    procedure Set_byteOrderMark(fWriteByteOrderMark: WordBool);
    function Get_byteOrderMark: WordBool;
    procedure Set_indent(fIndentMode: WordBool);
    function Get_indent: WordBool;
    procedure Set_standalone(fValue: WordBool);
    function Get_standalone: WordBool;
    procedure Set_omitXMLDeclaration(fValue: WordBool);
    function Get_omitXMLDeclaration: WordBool;
    procedure Set_version(const strVersion: WideString);
    function Get_version: WideString;
    procedure Set_disableOutputEscaping(fValue: WordBool);
    function Get_disableOutputEscaping: WordBool;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IMXWriter);
    procedure Disconnect; override;
    procedure flush;
    property DefaultInterface: IMXWriter read GetDefaultInterface;
    property output: OleVariant read Get_output write Set_output;
    property encoding: WideString read Get_encoding write Set_encoding;
    property byteOrderMark: WordBool read Get_byteOrderMark write Set_byteOrderMark;
    property indent: WordBool read Get_indent write Set_indent;
    property standalone: WordBool read Get_standalone write Set_standalone;
    property omitXMLDeclaration: WordBool read Get_omitXMLDeclaration write Set_omitXMLDeclaration;
    property version: WideString read Get_version write Set_version;
    property disableOutputEscaping: WordBool read Get_disableOutputEscaping write Set_disableOutputEscaping;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMXHTMLWriter30Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TMXHTMLWriter30
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TMXHTMLWriter30Properties = class(TPersistent)
  private
    FServer:    TMXHTMLWriter30;
    function    GetDefaultInterface: IMXWriter;
    constructor Create(AServer: TMXHTMLWriter30);
  protected
    procedure Set_output(varDestination: OleVariant);
    function Get_output: OleVariant;
    procedure Set_encoding(const strEncoding: WideString);
    function Get_encoding: WideString;
    procedure Set_byteOrderMark(fWriteByteOrderMark: WordBool);
    function Get_byteOrderMark: WordBool;
    procedure Set_indent(fIndentMode: WordBool);
    function Get_indent: WordBool;
    procedure Set_standalone(fValue: WordBool);
    function Get_standalone: WordBool;
    procedure Set_omitXMLDeclaration(fValue: WordBool);
    function Get_omitXMLDeclaration: WordBool;
    procedure Set_version(const strVersion: WideString);
    function Get_version: WideString;
    procedure Set_disableOutputEscaping(fValue: WordBool);
    function Get_disableOutputEscaping: WordBool;
  public
    property DefaultInterface: IMXWriter read GetDefaultInterface;
  published
    property encoding: WideString read Get_encoding write Set_encoding;
    property byteOrderMark: WordBool read Get_byteOrderMark write Set_byteOrderMark;
    property indent: WordBool read Get_indent write Set_indent;
    property standalone: WordBool read Get_standalone write Set_standalone;
    property omitXMLDeclaration: WordBool read Get_omitXMLDeclaration write Set_omitXMLDeclaration;
    property version: WideString read Get_version write Set_version;
    property disableOutputEscaping: WordBool read Get_disableOutputEscaping write Set_disableOutputEscaping;
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TMXHTMLWriter40
// Hilfe-String      : Microsoft HTML Writer 4.0 coclass
// Standard-Interface: IMXWriter
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMXHTMLWriter40Properties= class;
{$ENDIF}
  TMXHTMLWriter40 = class(TOleServer)
  private
    FIntf: IMXWriter;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TMXHTMLWriter40Properties;
    function GetServerProperties: TMXHTMLWriter40Properties;
{$ENDIF}
    function GetDefaultInterface: IMXWriter;
  protected
    procedure InitServerData; override;
    procedure Set_output(varDestination: OleVariant);
    function Get_output: OleVariant;
    procedure Set_encoding(const strEncoding: WideString);
    function Get_encoding: WideString;
    procedure Set_byteOrderMark(fWriteByteOrderMark: WordBool);
    function Get_byteOrderMark: WordBool;
    procedure Set_indent(fIndentMode: WordBool);
    function Get_indent: WordBool;
    procedure Set_standalone(fValue: WordBool);
    function Get_standalone: WordBool;
    procedure Set_omitXMLDeclaration(fValue: WordBool);
    function Get_omitXMLDeclaration: WordBool;
    procedure Set_version(const strVersion: WideString);
    function Get_version: WideString;
    procedure Set_disableOutputEscaping(fValue: WordBool);
    function Get_disableOutputEscaping: WordBool;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IMXWriter);
    procedure Disconnect; override;
    procedure flush;
    property DefaultInterface: IMXWriter read GetDefaultInterface;
    property output: OleVariant read Get_output write Set_output;
    property encoding: WideString read Get_encoding write Set_encoding;
    property byteOrderMark: WordBool read Get_byteOrderMark write Set_byteOrderMark;
    property indent: WordBool read Get_indent write Set_indent;
    property standalone: WordBool read Get_standalone write Set_standalone;
    property omitXMLDeclaration: WordBool read Get_omitXMLDeclaration write Set_omitXMLDeclaration;
    property version: WideString read Get_version write Set_version;
    property disableOutputEscaping: WordBool read Get_disableOutputEscaping write Set_disableOutputEscaping;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMXHTMLWriter40Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TMXHTMLWriter40
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TMXHTMLWriter40Properties = class(TPersistent)
  private
    FServer:    TMXHTMLWriter40;
    function    GetDefaultInterface: IMXWriter;
    constructor Create(AServer: TMXHTMLWriter40);
  protected
    procedure Set_output(varDestination: OleVariant);
    function Get_output: OleVariant;
    procedure Set_encoding(const strEncoding: WideString);
    function Get_encoding: WideString;
    procedure Set_byteOrderMark(fWriteByteOrderMark: WordBool);
    function Get_byteOrderMark: WordBool;
    procedure Set_indent(fIndentMode: WordBool);
    function Get_indent: WordBool;
    procedure Set_standalone(fValue: WordBool);
    function Get_standalone: WordBool;
    procedure Set_omitXMLDeclaration(fValue: WordBool);
    function Get_omitXMLDeclaration: WordBool;
    procedure Set_version(const strVersion: WideString);
    function Get_version: WideString;
    procedure Set_disableOutputEscaping(fValue: WordBool);
    function Get_disableOutputEscaping: WordBool;
  public
    property DefaultInterface: IMXWriter read GetDefaultInterface;
  published
    property encoding: WideString read Get_encoding write Set_encoding;
    property byteOrderMark: WordBool read Get_byteOrderMark write Set_byteOrderMark;
    property indent: WordBool read Get_indent write Set_indent;
    property standalone: WordBool read Get_standalone write Set_standalone;
    property omitXMLDeclaration: WordBool read Get_omitXMLDeclaration write Set_omitXMLDeclaration;
    property version: WideString read Get_version write Set_version;
    property disableOutputEscaping: WordBool read Get_disableOutputEscaping write Set_disableOutputEscaping;
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TMXHTMLWriter60
// Hilfe-String      : Microsoft HTML Writer 6.0
// Standard-Interface: IMXWriter
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMXHTMLWriter60Properties= class;
{$ENDIF}
  TMXHTMLWriter60 = class(TOleServer)
  private
    FIntf: IMXWriter;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TMXHTMLWriter60Properties;
    function GetServerProperties: TMXHTMLWriter60Properties;
{$ENDIF}
    function GetDefaultInterface: IMXWriter;
  protected
    procedure InitServerData; override;
    procedure Set_output(varDestination: OleVariant);
    function Get_output: OleVariant;
    procedure Set_encoding(const strEncoding: WideString);
    function Get_encoding: WideString;
    procedure Set_byteOrderMark(fWriteByteOrderMark: WordBool);
    function Get_byteOrderMark: WordBool;
    procedure Set_indent(fIndentMode: WordBool);
    function Get_indent: WordBool;
    procedure Set_standalone(fValue: WordBool);
    function Get_standalone: WordBool;
    procedure Set_omitXMLDeclaration(fValue: WordBool);
    function Get_omitXMLDeclaration: WordBool;
    procedure Set_version(const strVersion: WideString);
    function Get_version: WideString;
    procedure Set_disableOutputEscaping(fValue: WordBool);
    function Get_disableOutputEscaping: WordBool;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IMXWriter);
    procedure Disconnect; override;
    procedure flush;
    property DefaultInterface: IMXWriter read GetDefaultInterface;
    property output: OleVariant read Get_output write Set_output;
    property encoding: WideString read Get_encoding write Set_encoding;
    property byteOrderMark: WordBool read Get_byteOrderMark write Set_byteOrderMark;
    property indent: WordBool read Get_indent write Set_indent;
    property standalone: WordBool read Get_standalone write Set_standalone;
    property omitXMLDeclaration: WordBool read Get_omitXMLDeclaration write Set_omitXMLDeclaration;
    property version: WideString read Get_version write Set_version;
    property disableOutputEscaping: WordBool read Get_disableOutputEscaping write Set_disableOutputEscaping;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMXHTMLWriter60Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TMXHTMLWriter60
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TMXHTMLWriter60Properties = class(TPersistent)
  private
    FServer:    TMXHTMLWriter60;
    function    GetDefaultInterface: IMXWriter;
    constructor Create(AServer: TMXHTMLWriter60);
  protected
    procedure Set_output(varDestination: OleVariant);
    function Get_output: OleVariant;
    procedure Set_encoding(const strEncoding: WideString);
    function Get_encoding: WideString;
    procedure Set_byteOrderMark(fWriteByteOrderMark: WordBool);
    function Get_byteOrderMark: WordBool;
    procedure Set_indent(fIndentMode: WordBool);
    function Get_indent: WordBool;
    procedure Set_standalone(fValue: WordBool);
    function Get_standalone: WordBool;
    procedure Set_omitXMLDeclaration(fValue: WordBool);
    function Get_omitXMLDeclaration: WordBool;
    procedure Set_version(const strVersion: WideString);
    function Get_version: WideString;
    procedure Set_disableOutputEscaping(fValue: WordBool);
    function Get_disableOutputEscaping: WordBool;
  public
    property DefaultInterface: IMXWriter read GetDefaultInterface;
  published
    property encoding: WideString read Get_encoding write Set_encoding;
    property byteOrderMark: WordBool read Get_byteOrderMark write Set_byteOrderMark;
    property indent: WordBool read Get_indent write Set_indent;
    property standalone: WordBool read Get_standalone write Set_standalone;
    property omitXMLDeclaration: WordBool read Get_omitXMLDeclaration write Set_omitXMLDeclaration;
    property version: WideString read Get_version write Set_version;
    property disableOutputEscaping: WordBool read Get_disableOutputEscaping write Set_disableOutputEscaping;
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TmsSAXAttributes
// Hilfe-String      : SAX Attributes (version independent) coclass
// Standard-Interface: IMXAttributes
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TmsSAXAttributesProperties= class;
{$ENDIF}
  TmsSAXAttributes = class(TOleServer)
  private
    FIntf: IMXAttributes;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TmsSAXAttributesProperties;
    function GetServerProperties: TmsSAXAttributesProperties;
{$ENDIF}
    function GetDefaultInterface: IMXAttributes;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IMXAttributes);
    procedure Disconnect; override;
    procedure addAttribute(const strURI: WideString; const strLocalName: WideString; 
                           const strQName: WideString; const strType: WideString; 
                           const strValue: WideString);
    procedure addAttributeFromIndex(varAtts: OleVariant; nIndex: SYSINT);
    procedure clear;
    procedure removeAttribute(nIndex: SYSINT);
    procedure setAttribute(nIndex: SYSINT; const strURI: WideString; 
                           const strLocalName: WideString; const strQName: WideString; 
                           const strType: WideString; const strValue: WideString);
    procedure setAttributes(varAtts: OleVariant);
    procedure setLocalName(nIndex: SYSINT; const strLocalName: WideString);
    procedure setQName(nIndex: SYSINT; const strQName: WideString);
    procedure setType(nIndex: SYSINT; const strType: WideString);
    procedure setURI(nIndex: SYSINT; const strURI: WideString);
    procedure setValue(nIndex: SYSINT; const strValue: WideString);
    property DefaultInterface: IMXAttributes read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TmsSAXAttributesProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TmsSAXAttributes
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TmsSAXAttributesProperties = class(TPersistent)
  private
    FServer:    TmsSAXAttributes;
    function    GetDefaultInterface: IMXAttributes;
    constructor Create(AServer: TmsSAXAttributes);
  protected
  public
    property DefaultInterface: IMXAttributes read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TmsSAXAttributes30
// Hilfe-String      : SAX Attributes 3.0 coclass
// Standard-Interface: IMXAttributes
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TmsSAXAttributes30Properties= class;
{$ENDIF}
  TmsSAXAttributes30 = class(TOleServer)
  private
    FIntf: IMXAttributes;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TmsSAXAttributes30Properties;
    function GetServerProperties: TmsSAXAttributes30Properties;
{$ENDIF}
    function GetDefaultInterface: IMXAttributes;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IMXAttributes);
    procedure Disconnect; override;
    procedure addAttribute(const strURI: WideString; const strLocalName: WideString; 
                           const strQName: WideString; const strType: WideString; 
                           const strValue: WideString);
    procedure addAttributeFromIndex(varAtts: OleVariant; nIndex: SYSINT);
    procedure clear;
    procedure removeAttribute(nIndex: SYSINT);
    procedure setAttribute(nIndex: SYSINT; const strURI: WideString; 
                           const strLocalName: WideString; const strQName: WideString; 
                           const strType: WideString; const strValue: WideString);
    procedure setAttributes(varAtts: OleVariant);
    procedure setLocalName(nIndex: SYSINT; const strLocalName: WideString);
    procedure setQName(nIndex: SYSINT; const strQName: WideString);
    procedure setType(nIndex: SYSINT; const strType: WideString);
    procedure setURI(nIndex: SYSINT; const strURI: WideString);
    procedure setValue(nIndex: SYSINT; const strValue: WideString);
    property DefaultInterface: IMXAttributes read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TmsSAXAttributes30Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TmsSAXAttributes30
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TmsSAXAttributes30Properties = class(TPersistent)
  private
    FServer:    TmsSAXAttributes30;
    function    GetDefaultInterface: IMXAttributes;
    constructor Create(AServer: TmsSAXAttributes30);
  protected
  public
    property DefaultInterface: IMXAttributes read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TSAXAttributes40
// Hilfe-String      : SAX Attributes 4.0 coclass
// Standard-Interface: IMXAttributes
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TSAXAttributes40Properties= class;
{$ENDIF}
  TSAXAttributes40 = class(TOleServer)
  private
    FIntf: IMXAttributes;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TSAXAttributes40Properties;
    function GetServerProperties: TSAXAttributes40Properties;
{$ENDIF}
    function GetDefaultInterface: IMXAttributes;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IMXAttributes);
    procedure Disconnect; override;
    procedure addAttribute(const strURI: WideString; const strLocalName: WideString; 
                           const strQName: WideString; const strType: WideString; 
                           const strValue: WideString);
    procedure addAttributeFromIndex(varAtts: OleVariant; nIndex: SYSINT);
    procedure clear;
    procedure removeAttribute(nIndex: SYSINT);
    procedure setAttribute(nIndex: SYSINT; const strURI: WideString; 
                           const strLocalName: WideString; const strQName: WideString; 
                           const strType: WideString; const strValue: WideString);
    procedure setAttributes(varAtts: OleVariant);
    procedure setLocalName(nIndex: SYSINT; const strLocalName: WideString);
    procedure setQName(nIndex: SYSINT; const strQName: WideString);
    procedure setType(nIndex: SYSINT; const strType: WideString);
    procedure setURI(nIndex: SYSINT; const strURI: WideString);
    procedure setValue(nIndex: SYSINT; const strValue: WideString);
    property DefaultInterface: IMXAttributes read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TSAXAttributes40Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TSAXAttributes40
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TSAXAttributes40Properties = class(TPersistent)
  private
    FServer:    TSAXAttributes40;
    function    GetDefaultInterface: IMXAttributes;
    constructor Create(AServer: TSAXAttributes40);
  protected
  public
    property DefaultInterface: IMXAttributes read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TSAXAttributes60
// Hilfe-String      : SAX Attributes 6.0
// Standard-Interface: IMXAttributes
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TSAXAttributes60Properties= class;
{$ENDIF}
  TSAXAttributes60 = class(TOleServer)
  private
    FIntf: IMXAttributes;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TSAXAttributes60Properties;
    function GetServerProperties: TSAXAttributes60Properties;
{$ENDIF}
    function GetDefaultInterface: IMXAttributes;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IMXAttributes);
    procedure Disconnect; override;
    procedure addAttribute(const strURI: WideString; const strLocalName: WideString; 
                           const strQName: WideString; const strType: WideString; 
                           const strValue: WideString);
    procedure addAttributeFromIndex(varAtts: OleVariant; nIndex: SYSINT);
    procedure clear;
    procedure removeAttribute(nIndex: SYSINT);
    procedure setAttribute(nIndex: SYSINT; const strURI: WideString; 
                           const strLocalName: WideString; const strQName: WideString; 
                           const strType: WideString; const strValue: WideString);
    procedure setAttributes(varAtts: OleVariant);
    procedure setLocalName(nIndex: SYSINT; const strLocalName: WideString);
    procedure setQName(nIndex: SYSINT; const strQName: WideString);
    procedure setType(nIndex: SYSINT; const strType: WideString);
    procedure setURI(nIndex: SYSINT; const strURI: WideString);
    procedure setValue(nIndex: SYSINT; const strValue: WideString);
    property DefaultInterface: IMXAttributes read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TSAXAttributes60Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TSAXAttributes60
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TSAXAttributes60Properties = class(TPersistent)
  private
    FServer:    TSAXAttributes60;
    function    GetDefaultInterface: IMXAttributes;
    constructor Create(AServer: TSAXAttributes60);
  protected
  public
    property DefaultInterface: IMXAttributes read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TMXNamespaceManager
// Hilfe-String      : MX Namespace Manager coclass
// Standard-Interface: IVBMXNamespaceManager
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMXNamespaceManagerProperties= class;
{$ENDIF}
  TMXNamespaceManager = class(TOleServer)
  private
    FIntf: IVBMXNamespaceManager;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TMXNamespaceManagerProperties;
    function GetServerProperties: TMXNamespaceManagerProperties;
{$ENDIF}
    function GetDefaultInterface: IVBMXNamespaceManager;
  protected
    procedure InitServerData; override;
    procedure Set_allowOverride(fOverride: WordBool);
    function Get_allowOverride: WordBool;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IVBMXNamespaceManager);
    procedure Disconnect; override;
    procedure reset;
    procedure pushContext;
    procedure pushNodeContext(const contextNode: IXMLDOMNode; fDeep: WordBool);
    procedure popContext;
    procedure declarePrefix(const prefix: WideString; const namespaceURI: WideString);
    function getDeclaredPrefixes: IMXNamespacePrefixes;
    function getPrefixes(const namespaceURI: WideString): IMXNamespacePrefixes;
    function getURI(const prefix: WideString): OleVariant;
    function getURIFromNode(const strPrefix: WideString; const contextNode: IXMLDOMNode): OleVariant;
    property DefaultInterface: IVBMXNamespaceManager read GetDefaultInterface;
    property allowOverride: WordBool read Get_allowOverride write Set_allowOverride;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMXNamespaceManagerProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TMXNamespaceManager
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TMXNamespaceManagerProperties = class(TPersistent)
  private
    FServer:    TMXNamespaceManager;
    function    GetDefaultInterface: IVBMXNamespaceManager;
    constructor Create(AServer: TMXNamespaceManager);
  protected
    procedure Set_allowOverride(fOverride: WordBool);
    function Get_allowOverride: WordBool;
  public
    property DefaultInterface: IVBMXNamespaceManager read GetDefaultInterface;
  published
    property allowOverride: WordBool read Get_allowOverride write Set_allowOverride;
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TMXNamespaceManager40
// Hilfe-String      : MX Namespace Manager 4.0 coclass
// Standard-Interface: IVBMXNamespaceManager
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMXNamespaceManager40Properties= class;
{$ENDIF}
  TMXNamespaceManager40 = class(TOleServer)
  private
    FIntf: IVBMXNamespaceManager;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TMXNamespaceManager40Properties;
    function GetServerProperties: TMXNamespaceManager40Properties;
{$ENDIF}
    function GetDefaultInterface: IVBMXNamespaceManager;
  protected
    procedure InitServerData; override;
    procedure Set_allowOverride(fOverride: WordBool);
    function Get_allowOverride: WordBool;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IVBMXNamespaceManager);
    procedure Disconnect; override;
    procedure reset;
    procedure pushContext;
    procedure pushNodeContext(const contextNode: IXMLDOMNode; fDeep: WordBool);
    procedure popContext;
    procedure declarePrefix(const prefix: WideString; const namespaceURI: WideString);
    function getDeclaredPrefixes: IMXNamespacePrefixes;
    function getPrefixes(const namespaceURI: WideString): IMXNamespacePrefixes;
    function getURI(const prefix: WideString): OleVariant;
    function getURIFromNode(const strPrefix: WideString; const contextNode: IXMLDOMNode): OleVariant;
    property DefaultInterface: IVBMXNamespaceManager read GetDefaultInterface;
    property allowOverride: WordBool read Get_allowOverride write Set_allowOverride;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMXNamespaceManager40Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TMXNamespaceManager40
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TMXNamespaceManager40Properties = class(TPersistent)
  private
    FServer:    TMXNamespaceManager40;
    function    GetDefaultInterface: IVBMXNamespaceManager;
    constructor Create(AServer: TMXNamespaceManager40);
  protected
    procedure Set_allowOverride(fOverride: WordBool);
    function Get_allowOverride: WordBool;
  public
    property DefaultInterface: IVBMXNamespaceManager read GetDefaultInterface;
  published
    property allowOverride: WordBool read Get_allowOverride write Set_allowOverride;
  end;
{$ENDIF}


// *********************************************************************//
// OLE-Server-Proxy-Klassendeklaration
// Server-Objekt    : TMXNamespaceManager60
// Hilfe-String      : MX Namespace Manager 6.0
// Standard-Interface: IVBMXNamespaceManager
// Def. Intf. DISP? : No
// Ereignis-Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMXNamespaceManager60Properties= class;
{$ENDIF}
  TMXNamespaceManager60 = class(TOleServer)
  private
    FIntf: IVBMXNamespaceManager;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TMXNamespaceManager60Properties;
    function GetServerProperties: TMXNamespaceManager60Properties;
{$ENDIF}
    function GetDefaultInterface: IVBMXNamespaceManager;
  protected
    procedure InitServerData; override;
    procedure Set_allowOverride(fOverride: WordBool);
    function Get_allowOverride: WordBool;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IVBMXNamespaceManager);
    procedure Disconnect; override;
    procedure reset;
    procedure pushContext;
    procedure pushNodeContext(const contextNode: IXMLDOMNode; fDeep: WordBool);
    procedure popContext;
    procedure declarePrefix(const prefix: WideString; const namespaceURI: WideString);
    function getDeclaredPrefixes: IMXNamespacePrefixes;
    function getPrefixes(const namespaceURI: WideString): IMXNamespacePrefixes;
    function getURI(const prefix: WideString): OleVariant;
    function getURIFromNode(const strPrefix: WideString; const contextNode: IXMLDOMNode): OleVariant;
    property DefaultInterface: IVBMXNamespaceManager read GetDefaultInterface;
    property allowOverride: WordBool read Get_allowOverride write Set_allowOverride;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMXNamespaceManager60Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE-Server-Eigenschaften-Proxy-Klasse
// Server-Objekt     : TMXNamespaceManager60
// (Dieses Objekt wird vom Eigenschaftsinspektor der IDE verwendet,
//  um die Eigenschaften dieses Servers zu bearbeiten)
// *********************************************************************//
 TMXNamespaceManager60Properties = class(TPersistent)
  private
    FServer:    TMXNamespaceManager60;
    function    GetDefaultInterface: IVBMXNamespaceManager;
    constructor Create(AServer: TMXNamespaceManager60);
  protected
    procedure Set_allowOverride(fOverride: WordBool);
    function Get_allowOverride: WordBool;
  public
    property DefaultInterface: IVBMXNamespaceManager read GetDefaultInterface;
  published
    property allowOverride: WordBool read Get_allowOverride write Set_allowOverride;
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

procedure TmsDOMDocument.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{F6D90F11-9C73-11D3-B32E-00C04F990BB4}';
    IntfIID:   '{2933BF95-7B36-11D2-B20E-00C04F983E60}';
    EventIID:  '{3EFAA427-272F-11D2-836F-0000F87A7782}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TmsDOMDocument.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IXMLDOMDocument2;
  end;
end;

procedure TmsDOMDocument.ConnectTo(svrIntf: IXMLDOMDocument2);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TmsDOMDocument.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TmsDOMDocument.GetDefaultInterface: IXMLDOMDocument2;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TmsDOMDocument.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TmsDOMDocumentProperties.Create(Self);
{$ENDIF}
end;

destructor TmsDOMDocument.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TmsDOMDocument.GetServerProperties: TmsDOMDocumentProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TmsDOMDocument.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    198: if Assigned(FOnondataavailable) then
         FOnondataavailable(Self);
    -609: if Assigned(FOnonreadystatechange) then
         FOnonreadystatechange(Self);
  end; {case DispID}
end;

function TmsDOMDocument.Get_namespaces: IXMLDOMSchemaCollection;
begin
    Result := DefaultInterface.namespaces;
end;

function TmsDOMDocument.Get_schemas: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.schemas;
end;

procedure TmsDOMDocument._Set_schemas(otherCollection: OleVariant);
  { Warnung: Die Eigenschaftschemas hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.schemas := otherCollection;
end;

function TmsDOMDocument.validate: IXMLDOMParseError;
begin
  Result := DefaultInterface.validate;
end;

procedure TmsDOMDocument.setProperty(const name: WideString; value: OleVariant);
begin
  DefaultInterface.setProperty(name, value);
end;

function TmsDOMDocument.getProperty(const name: WideString): OleVariant;
begin
  Result := DefaultInterface.getProperty(name);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TmsDOMDocumentProperties.Create(AServer: TmsDOMDocument);
begin
  inherited Create;
  FServer := AServer;
end;

function TmsDOMDocumentProperties.GetDefaultInterface: IXMLDOMDocument2;
begin
  Result := FServer.DefaultInterface;
end;

function TmsDOMDocumentProperties.Get_namespaces: IXMLDOMSchemaCollection;
begin
    Result := DefaultInterface.namespaces;
end;

function TmsDOMDocumentProperties.Get_schemas: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.schemas;
end;

procedure TmsDOMDocumentProperties._Set_schemas(otherCollection: OleVariant);
  { Warnung: Die Eigenschaftschemas hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.schemas := otherCollection;
end;

{$ENDIF}

procedure TmsDOMDocument26.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{F5078F1B-C551-11D3-89B9-0000F81FE221}';
    IntfIID:   '{2933BF95-7B36-11D2-B20E-00C04F983E60}';
    EventIID:  '{3EFAA427-272F-11D2-836F-0000F87A7782}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TmsDOMDocument26.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IXMLDOMDocument2;
  end;
end;

procedure TmsDOMDocument26.ConnectTo(svrIntf: IXMLDOMDocument2);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TmsDOMDocument26.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TmsDOMDocument26.GetDefaultInterface: IXMLDOMDocument2;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TmsDOMDocument26.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TmsDOMDocument26Properties.Create(Self);
{$ENDIF}
end;

destructor TmsDOMDocument26.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TmsDOMDocument26.GetServerProperties: TmsDOMDocument26Properties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TmsDOMDocument26.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    198: if Assigned(FOnondataavailable) then
         FOnondataavailable(Self);
    -609: if Assigned(FOnonreadystatechange) then
         FOnonreadystatechange(Self);
  end; {case DispID}
end;

function TmsDOMDocument26.Get_namespaces: IXMLDOMSchemaCollection;
begin
    Result := DefaultInterface.namespaces;
end;

function TmsDOMDocument26.Get_schemas: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.schemas;
end;

procedure TmsDOMDocument26._Set_schemas(otherCollection: OleVariant);
  { Warnung: Die Eigenschaftschemas hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.schemas := otherCollection;
end;

function TmsDOMDocument26.validate: IXMLDOMParseError;
begin
  Result := DefaultInterface.validate;
end;

procedure TmsDOMDocument26.setProperty(const name: WideString; value: OleVariant);
begin
  DefaultInterface.setProperty(name, value);
end;

function TmsDOMDocument26.getProperty(const name: WideString): OleVariant;
begin
  Result := DefaultInterface.getProperty(name);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TmsDOMDocument26Properties.Create(AServer: TmsDOMDocument26);
begin
  inherited Create;
  FServer := AServer;
end;

function TmsDOMDocument26Properties.GetDefaultInterface: IXMLDOMDocument2;
begin
  Result := FServer.DefaultInterface;
end;

function TmsDOMDocument26Properties.Get_namespaces: IXMLDOMSchemaCollection;
begin
    Result := DefaultInterface.namespaces;
end;

function TmsDOMDocument26Properties.Get_schemas: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.schemas;
end;

procedure TmsDOMDocument26Properties._Set_schemas(otherCollection: OleVariant);
  { Warnung: Die Eigenschaftschemas hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.schemas := otherCollection;
end;

{$ENDIF}

procedure TmsDOMDocument30.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{F5078F32-C551-11D3-89B9-0000F81FE221}';
    IntfIID:   '{2933BF95-7B36-11D2-B20E-00C04F983E60}';
    EventIID:  '{3EFAA427-272F-11D2-836F-0000F87A7782}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TmsDOMDocument30.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IXMLDOMDocument2;
  end;
end;

procedure TmsDOMDocument30.ConnectTo(svrIntf: IXMLDOMDocument2);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TmsDOMDocument30.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TmsDOMDocument30.GetDefaultInterface: IXMLDOMDocument2;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TmsDOMDocument30.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TmsDOMDocument30Properties.Create(Self);
{$ENDIF}
end;

destructor TmsDOMDocument30.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TmsDOMDocument30.GetServerProperties: TmsDOMDocument30Properties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TmsDOMDocument30.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    198: if Assigned(FOnondataavailable) then
         FOnondataavailable(Self);
    -609: if Assigned(FOnonreadystatechange) then
         FOnonreadystatechange(Self);
  end; {case DispID}
end;

function TmsDOMDocument30.Get_namespaces: IXMLDOMSchemaCollection;
begin
    Result := DefaultInterface.namespaces;
end;

function TmsDOMDocument30.Get_schemas: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.schemas;
end;

procedure TmsDOMDocument30._Set_schemas(otherCollection: OleVariant);
  { Warnung: Die Eigenschaftschemas hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.schemas := otherCollection;
end;

function TmsDOMDocument30.validate: IXMLDOMParseError;
begin
  Result := DefaultInterface.validate;
end;

procedure TmsDOMDocument30.setProperty(const name: WideString; value: OleVariant);
begin
  DefaultInterface.setProperty(name, value);
end;

function TmsDOMDocument30.getProperty(const name: WideString): OleVariant;
begin
  Result := DefaultInterface.getProperty(name);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TmsDOMDocument30Properties.Create(AServer: TmsDOMDocument30);
begin
  inherited Create;
  FServer := AServer;
end;

function TmsDOMDocument30Properties.GetDefaultInterface: IXMLDOMDocument2;
begin
  Result := FServer.DefaultInterface;
end;

function TmsDOMDocument30Properties.Get_namespaces: IXMLDOMSchemaCollection;
begin
    Result := DefaultInterface.namespaces;
end;

function TmsDOMDocument30Properties.Get_schemas: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.schemas;
end;

procedure TmsDOMDocument30Properties._Set_schemas(otherCollection: OleVariant);
  { Warnung: Die Eigenschaftschemas hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.schemas := otherCollection;
end;

{$ENDIF}

procedure TDOMDocument40.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{88D969C0-F192-11D4-A65F-0040963251E5}';
    IntfIID:   '{2933BF95-7B36-11D2-B20E-00C04F983E60}';
    EventIID:  '{3EFAA427-272F-11D2-836F-0000F87A7782}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TDOMDocument40.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IXMLDOMDocument2;
  end;
end;

procedure TDOMDocument40.ConnectTo(svrIntf: IXMLDOMDocument2);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TDOMDocument40.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TDOMDocument40.GetDefaultInterface: IXMLDOMDocument2;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TDOMDocument40.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TDOMDocument40Properties.Create(Self);
{$ENDIF}
end;

destructor TDOMDocument40.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TDOMDocument40.GetServerProperties: TDOMDocument40Properties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TDOMDocument40.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    198: if Assigned(FOnondataavailable) then
         FOnondataavailable(Self);
    -609: if Assigned(FOnonreadystatechange) then
         FOnonreadystatechange(Self);
  end; {case DispID}
end;

function TDOMDocument40.Get_namespaces: IXMLDOMSchemaCollection;
begin
    Result := DefaultInterface.namespaces;
end;

function TDOMDocument40.Get_schemas: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.schemas;
end;

procedure TDOMDocument40._Set_schemas(otherCollection: OleVariant);
  { Warnung: Die Eigenschaftschemas hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.schemas := otherCollection;
end;

function TDOMDocument40.validate: IXMLDOMParseError;
begin
  Result := DefaultInterface.validate;
end;

procedure TDOMDocument40.setProperty(const name: WideString; value: OleVariant);
begin
  DefaultInterface.setProperty(name, value);
end;

function TDOMDocument40.getProperty(const name: WideString): OleVariant;
begin
  Result := DefaultInterface.getProperty(name);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TDOMDocument40Properties.Create(AServer: TDOMDocument40);
begin
  inherited Create;
  FServer := AServer;
end;

function TDOMDocument40Properties.GetDefaultInterface: IXMLDOMDocument2;
begin
  Result := FServer.DefaultInterface;
end;

function TDOMDocument40Properties.Get_namespaces: IXMLDOMSchemaCollection;
begin
    Result := DefaultInterface.namespaces;
end;

function TDOMDocument40Properties.Get_schemas: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.schemas;
end;

procedure TDOMDocument40Properties._Set_schemas(otherCollection: OleVariant);
  { Warnung: Die Eigenschaftschemas hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.schemas := otherCollection;
end;

{$ENDIF}

procedure TDOMDocument60.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{88D96A05-F192-11D4-A65F-0040963251E5}';
    IntfIID:   '{2933BF96-7B36-11D2-B20E-00C04F983E60}';
    EventIID:  '{3EFAA427-272F-11D2-836F-0000F87A7782}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TDOMDocument60.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IXMLDOMDocument3;
  end;
end;

procedure TDOMDocument60.ConnectTo(svrIntf: IXMLDOMDocument3);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TDOMDocument60.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TDOMDocument60.GetDefaultInterface: IXMLDOMDocument3;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TDOMDocument60.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TDOMDocument60Properties.Create(Self);
{$ENDIF}
end;

destructor TDOMDocument60.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TDOMDocument60.GetServerProperties: TDOMDocument60Properties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TDOMDocument60.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    198: if Assigned(FOnondataavailable) then
         FOnondataavailable(Self);
    -609: if Assigned(FOnonreadystatechange) then
         FOnonreadystatechange(Self);
  end; {case DispID}
end;

function TDOMDocument60.validateNode(const node: IXMLDOMNode): IXMLDOMParseError;
begin
  Result := DefaultInterface.validateNode(node);
end;

function TDOMDocument60.importNode(const node: IXMLDOMNode; deep: WordBool): IXMLDOMNode;
begin
  Result := DefaultInterface.importNode(node, deep);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TDOMDocument60Properties.Create(AServer: TDOMDocument60);
begin
  inherited Create;
  FServer := AServer;
end;

function TDOMDocument60Properties.GetDefaultInterface: IXMLDOMDocument3;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

procedure TmsFreeThreadedDOMDocument.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{F6D90F12-9C73-11D3-B32E-00C04F990BB4}';
    IntfIID:   '{2933BF95-7B36-11D2-B20E-00C04F983E60}';
    EventIID:  '{3EFAA427-272F-11D2-836F-0000F87A7782}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TmsFreeThreadedDOMDocument.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IXMLDOMDocument2;
  end;
end;

procedure TmsFreeThreadedDOMDocument.ConnectTo(svrIntf: IXMLDOMDocument2);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TmsFreeThreadedDOMDocument.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TmsFreeThreadedDOMDocument.GetDefaultInterface: IXMLDOMDocument2;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TmsFreeThreadedDOMDocument.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TmsFreeThreadedDOMDocumentProperties.Create(Self);
{$ENDIF}
end;

destructor TmsFreeThreadedDOMDocument.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TmsFreeThreadedDOMDocument.GetServerProperties: TmsFreeThreadedDOMDocumentProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TmsFreeThreadedDOMDocument.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    198: if Assigned(FOnondataavailable) then
         FOnondataavailable(Self);
    -609: if Assigned(FOnonreadystatechange) then
         FOnonreadystatechange(Self);
  end; {case DispID}
end;

function TmsFreeThreadedDOMDocument.Get_namespaces: IXMLDOMSchemaCollection;
begin
    Result := DefaultInterface.namespaces;
end;

function TmsFreeThreadedDOMDocument.Get_schemas: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.schemas;
end;

procedure TmsFreeThreadedDOMDocument._Set_schemas(otherCollection: OleVariant);
  { Warnung: Die Eigenschaftschemas hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.schemas := otherCollection;
end;

function TmsFreeThreadedDOMDocument.validate: IXMLDOMParseError;
begin
  Result := DefaultInterface.validate;
end;

procedure TmsFreeThreadedDOMDocument.setProperty(const name: WideString; value: OleVariant);
begin
  DefaultInterface.setProperty(name, value);
end;

function TmsFreeThreadedDOMDocument.getProperty(const name: WideString): OleVariant;
begin
  Result := DefaultInterface.getProperty(name);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TmsFreeThreadedDOMDocumentProperties.Create(AServer: TmsFreeThreadedDOMDocument);
begin
  inherited Create;
  FServer := AServer;
end;

function TmsFreeThreadedDOMDocumentProperties.GetDefaultInterface: IXMLDOMDocument2;
begin
  Result := FServer.DefaultInterface;
end;

function TmsFreeThreadedDOMDocumentProperties.Get_namespaces: IXMLDOMSchemaCollection;
begin
    Result := DefaultInterface.namespaces;
end;

function TmsFreeThreadedDOMDocumentProperties.Get_schemas: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.schemas;
end;

procedure TmsFreeThreadedDOMDocumentProperties._Set_schemas(otherCollection: OleVariant);
  { Warnung: Die Eigenschaftschemas hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.schemas := otherCollection;
end;

{$ENDIF}

procedure TmsFreeThreadedDOMDocument26.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{F5078F1C-C551-11D3-89B9-0000F81FE221}';
    IntfIID:   '{2933BF95-7B36-11D2-B20E-00C04F983E60}';
    EventIID:  '{3EFAA427-272F-11D2-836F-0000F87A7782}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TmsFreeThreadedDOMDocument26.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IXMLDOMDocument2;
  end;
end;

procedure TmsFreeThreadedDOMDocument26.ConnectTo(svrIntf: IXMLDOMDocument2);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TmsFreeThreadedDOMDocument26.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TmsFreeThreadedDOMDocument26.GetDefaultInterface: IXMLDOMDocument2;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TmsFreeThreadedDOMDocument26.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TmsFreeThreadedDOMDocument26Properties.Create(Self);
{$ENDIF}
end;

destructor TmsFreeThreadedDOMDocument26.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TmsFreeThreadedDOMDocument26.GetServerProperties: TmsFreeThreadedDOMDocument26Properties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TmsFreeThreadedDOMDocument26.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    198: if Assigned(FOnondataavailable) then
         FOnondataavailable(Self);
    -609: if Assigned(FOnonreadystatechange) then
         FOnonreadystatechange(Self);
  end; {case DispID}
end;

function TmsFreeThreadedDOMDocument26.Get_namespaces: IXMLDOMSchemaCollection;
begin
    Result := DefaultInterface.namespaces;
end;

function TmsFreeThreadedDOMDocument26.Get_schemas: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.schemas;
end;

procedure TmsFreeThreadedDOMDocument26._Set_schemas(otherCollection: OleVariant);
  { Warnung: Die Eigenschaftschemas hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.schemas := otherCollection;
end;

function TmsFreeThreadedDOMDocument26.validate: IXMLDOMParseError;
begin
  Result := DefaultInterface.validate;
end;

procedure TmsFreeThreadedDOMDocument26.setProperty(const name: WideString; value: OleVariant);
begin
  DefaultInterface.setProperty(name, value);
end;

function TmsFreeThreadedDOMDocument26.getProperty(const name: WideString): OleVariant;
begin
  Result := DefaultInterface.getProperty(name);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TmsFreeThreadedDOMDocument26Properties.Create(AServer: TmsFreeThreadedDOMDocument26);
begin
  inherited Create;
  FServer := AServer;
end;

function TmsFreeThreadedDOMDocument26Properties.GetDefaultInterface: IXMLDOMDocument2;
begin
  Result := FServer.DefaultInterface;
end;

function TmsFreeThreadedDOMDocument26Properties.Get_namespaces: IXMLDOMSchemaCollection;
begin
    Result := DefaultInterface.namespaces;
end;

function TmsFreeThreadedDOMDocument26Properties.Get_schemas: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.schemas;
end;

procedure TmsFreeThreadedDOMDocument26Properties._Set_schemas(otherCollection: OleVariant);
  { Warnung: Die Eigenschaftschemas hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.schemas := otherCollection;
end;

{$ENDIF}

procedure TmsFreeThreadedDOMDocument30.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{F5078F33-C551-11D3-89B9-0000F81FE221}';
    IntfIID:   '{2933BF95-7B36-11D2-B20E-00C04F983E60}';
    EventIID:  '{3EFAA427-272F-11D2-836F-0000F87A7782}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TmsFreeThreadedDOMDocument30.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IXMLDOMDocument2;
  end;
end;

procedure TmsFreeThreadedDOMDocument30.ConnectTo(svrIntf: IXMLDOMDocument2);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TmsFreeThreadedDOMDocument30.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TmsFreeThreadedDOMDocument30.GetDefaultInterface: IXMLDOMDocument2;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TmsFreeThreadedDOMDocument30.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TmsFreeThreadedDOMDocument30Properties.Create(Self);
{$ENDIF}
end;

destructor TmsFreeThreadedDOMDocument30.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TmsFreeThreadedDOMDocument30.GetServerProperties: TmsFreeThreadedDOMDocument30Properties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TmsFreeThreadedDOMDocument30.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    198: if Assigned(FOnondataavailable) then
         FOnondataavailable(Self);
    -609: if Assigned(FOnonreadystatechange) then
         FOnonreadystatechange(Self);
  end; {case DispID}
end;

function TmsFreeThreadedDOMDocument30.Get_namespaces: IXMLDOMSchemaCollection;
begin
    Result := DefaultInterface.namespaces;
end;

function TmsFreeThreadedDOMDocument30.Get_schemas: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.schemas;
end;

procedure TmsFreeThreadedDOMDocument30._Set_schemas(otherCollection: OleVariant);
  { Warnung: Die Eigenschaftschemas hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.schemas := otherCollection;
end;

function TmsFreeThreadedDOMDocument30.validate: IXMLDOMParseError;
begin
  Result := DefaultInterface.validate;
end;

procedure TmsFreeThreadedDOMDocument30.setProperty(const name: WideString; value: OleVariant);
begin
  DefaultInterface.setProperty(name, value);
end;

function TmsFreeThreadedDOMDocument30.getProperty(const name: WideString): OleVariant;
begin
  Result := DefaultInterface.getProperty(name);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TmsFreeThreadedDOMDocument30Properties.Create(AServer: TmsFreeThreadedDOMDocument30);
begin
  inherited Create;
  FServer := AServer;
end;

function TmsFreeThreadedDOMDocument30Properties.GetDefaultInterface: IXMLDOMDocument2;
begin
  Result := FServer.DefaultInterface;
end;

function TmsFreeThreadedDOMDocument30Properties.Get_namespaces: IXMLDOMSchemaCollection;
begin
    Result := DefaultInterface.namespaces;
end;

function TmsFreeThreadedDOMDocument30Properties.Get_schemas: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.schemas;
end;

procedure TmsFreeThreadedDOMDocument30Properties._Set_schemas(otherCollection: OleVariant);
  { Warnung: Die Eigenschaftschemas hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.schemas := otherCollection;
end;

{$ENDIF}

procedure TFreeThreadedDOMDocument40.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{88D969C1-F192-11D4-A65F-0040963251E5}';
    IntfIID:   '{2933BF95-7B36-11D2-B20E-00C04F983E60}';
    EventIID:  '{3EFAA427-272F-11D2-836F-0000F87A7782}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TFreeThreadedDOMDocument40.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IXMLDOMDocument2;
  end;
end;

procedure TFreeThreadedDOMDocument40.ConnectTo(svrIntf: IXMLDOMDocument2);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TFreeThreadedDOMDocument40.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TFreeThreadedDOMDocument40.GetDefaultInterface: IXMLDOMDocument2;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TFreeThreadedDOMDocument40.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TFreeThreadedDOMDocument40Properties.Create(Self);
{$ENDIF}
end;

destructor TFreeThreadedDOMDocument40.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TFreeThreadedDOMDocument40.GetServerProperties: TFreeThreadedDOMDocument40Properties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TFreeThreadedDOMDocument40.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    198: if Assigned(FOnondataavailable) then
         FOnondataavailable(Self);
    -609: if Assigned(FOnonreadystatechange) then
         FOnonreadystatechange(Self);
  end; {case DispID}
end;

function TFreeThreadedDOMDocument40.Get_namespaces: IXMLDOMSchemaCollection;
begin
    Result := DefaultInterface.namespaces;
end;

function TFreeThreadedDOMDocument40.Get_schemas: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.schemas;
end;

procedure TFreeThreadedDOMDocument40._Set_schemas(otherCollection: OleVariant);
  { Warnung: Die Eigenschaftschemas hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.schemas := otherCollection;
end;

function TFreeThreadedDOMDocument40.validate: IXMLDOMParseError;
begin
  Result := DefaultInterface.validate;
end;

procedure TFreeThreadedDOMDocument40.setProperty(const name: WideString; value: OleVariant);
begin
  DefaultInterface.setProperty(name, value);
end;

function TFreeThreadedDOMDocument40.getProperty(const name: WideString): OleVariant;
begin
  Result := DefaultInterface.getProperty(name);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TFreeThreadedDOMDocument40Properties.Create(AServer: TFreeThreadedDOMDocument40);
begin
  inherited Create;
  FServer := AServer;
end;

function TFreeThreadedDOMDocument40Properties.GetDefaultInterface: IXMLDOMDocument2;
begin
  Result := FServer.DefaultInterface;
end;

function TFreeThreadedDOMDocument40Properties.Get_namespaces: IXMLDOMSchemaCollection;
begin
    Result := DefaultInterface.namespaces;
end;

function TFreeThreadedDOMDocument40Properties.Get_schemas: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.schemas;
end;

procedure TFreeThreadedDOMDocument40Properties._Set_schemas(otherCollection: OleVariant);
  { Warnung: Die Eigenschaftschemas hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.schemas := otherCollection;
end;

{$ENDIF}

procedure TFreeThreadedDOMDocument60.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{88D96A06-F192-11D4-A65F-0040963251E5}';
    IntfIID:   '{2933BF96-7B36-11D2-B20E-00C04F983E60}';
    EventIID:  '{3EFAA427-272F-11D2-836F-0000F87A7782}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TFreeThreadedDOMDocument60.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IXMLDOMDocument3;
  end;
end;

procedure TFreeThreadedDOMDocument60.ConnectTo(svrIntf: IXMLDOMDocument3);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TFreeThreadedDOMDocument60.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TFreeThreadedDOMDocument60.GetDefaultInterface: IXMLDOMDocument3;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TFreeThreadedDOMDocument60.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TFreeThreadedDOMDocument60Properties.Create(Self);
{$ENDIF}
end;

destructor TFreeThreadedDOMDocument60.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TFreeThreadedDOMDocument60.GetServerProperties: TFreeThreadedDOMDocument60Properties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TFreeThreadedDOMDocument60.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    198: if Assigned(FOnondataavailable) then
         FOnondataavailable(Self);
    -609: if Assigned(FOnonreadystatechange) then
         FOnonreadystatechange(Self);
  end; {case DispID}
end;

function TFreeThreadedDOMDocument60.validateNode(const node: IXMLDOMNode): IXMLDOMParseError;
begin
  Result := DefaultInterface.validateNode(node);
end;

function TFreeThreadedDOMDocument60.importNode(const node: IXMLDOMNode; deep: WordBool): IXMLDOMNode;
begin
  Result := DefaultInterface.importNode(node, deep);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TFreeThreadedDOMDocument60Properties.Create(AServer: TFreeThreadedDOMDocument60);
begin
  inherited Create;
  FServer := AServer;
end;

function TFreeThreadedDOMDocument60Properties.GetDefaultInterface: IXMLDOMDocument3;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

procedure TmsXMLSchemaCache.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{373984C9-B845-449B-91E7-45AC83036ADE}';
    IntfIID:   '{373984C8-B845-449B-91E7-45AC83036ADE}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TmsXMLSchemaCache.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IXMLDOMSchemaCollection;
  end;
end;

procedure TmsXMLSchemaCache.ConnectTo(svrIntf: IXMLDOMSchemaCollection);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TmsXMLSchemaCache.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TmsXMLSchemaCache.GetDefaultInterface: IXMLDOMSchemaCollection;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TmsXMLSchemaCache.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TmsXMLSchemaCacheProperties.Create(Self);
{$ENDIF}
end;

destructor TmsXMLSchemaCache.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TmsXMLSchemaCache.GetServerProperties: TmsXMLSchemaCacheProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TmsXMLSchemaCache.Get_length: Integer;
begin
    Result := DefaultInterface.length;
end;

function TmsXMLSchemaCache.Get_namespaceURI(index: Integer): WideString;
begin
    Result := DefaultInterface.namespaceURI[index];
end;

procedure TmsXMLSchemaCache.add(const namespaceURI: WideString; var_: OleVariant);
begin
  DefaultInterface.add(namespaceURI, var_);
end;

function TmsXMLSchemaCache.get(const namespaceURI: WideString): IXMLDOMNode;
begin
  Result := DefaultInterface.get(namespaceURI);
end;

procedure TmsXMLSchemaCache.remove(const namespaceURI: WideString);
begin
  DefaultInterface.remove(namespaceURI);
end;

procedure TmsXMLSchemaCache.addCollection(const otherCollection: IXMLDOMSchemaCollection);
begin
  DefaultInterface.addCollection(otherCollection);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TmsXMLSchemaCacheProperties.Create(AServer: TmsXMLSchemaCache);
begin
  inherited Create;
  FServer := AServer;
end;

function TmsXMLSchemaCacheProperties.GetDefaultInterface: IXMLDOMSchemaCollection;
begin
  Result := FServer.DefaultInterface;
end;

function TmsXMLSchemaCacheProperties.Get_length: Integer;
begin
    Result := DefaultInterface.length;
end;

function TmsXMLSchemaCacheProperties.Get_namespaceURI(index: Integer): WideString;
begin
    Result := DefaultInterface.namespaceURI[index];
end;

{$ENDIF}

procedure TmsXMLSchemaCache26.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{F5078F1D-C551-11D3-89B9-0000F81FE221}';
    IntfIID:   '{373984C8-B845-449B-91E7-45AC83036ADE}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TmsXMLSchemaCache26.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IXMLDOMSchemaCollection;
  end;
end;

procedure TmsXMLSchemaCache26.ConnectTo(svrIntf: IXMLDOMSchemaCollection);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TmsXMLSchemaCache26.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TmsXMLSchemaCache26.GetDefaultInterface: IXMLDOMSchemaCollection;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TmsXMLSchemaCache26.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TmsXMLSchemaCache26Properties.Create(Self);
{$ENDIF}
end;

destructor TmsXMLSchemaCache26.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TmsXMLSchemaCache26.GetServerProperties: TmsXMLSchemaCache26Properties;
begin
  Result := FProps;
end;
{$ENDIF}

function TmsXMLSchemaCache26.Get_length: Integer;
begin
    Result := DefaultInterface.length;
end;

function TmsXMLSchemaCache26.Get_namespaceURI(index: Integer): WideString;
begin
    Result := DefaultInterface.namespaceURI[index];
end;

procedure TmsXMLSchemaCache26.add(const namespaceURI: WideString; var_: OleVariant);
begin
  DefaultInterface.add(namespaceURI, var_);
end;

function TmsXMLSchemaCache26.get(const namespaceURI: WideString): IXMLDOMNode;
begin
  Result := DefaultInterface.get(namespaceURI);
end;

procedure TmsXMLSchemaCache26.remove(const namespaceURI: WideString);
begin
  DefaultInterface.remove(namespaceURI);
end;

procedure TmsXMLSchemaCache26.addCollection(const otherCollection: IXMLDOMSchemaCollection);
begin
  DefaultInterface.addCollection(otherCollection);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TmsXMLSchemaCache26Properties.Create(AServer: TmsXMLSchemaCache26);
begin
  inherited Create;
  FServer := AServer;
end;

function TmsXMLSchemaCache26Properties.GetDefaultInterface: IXMLDOMSchemaCollection;
begin
  Result := FServer.DefaultInterface;
end;

function TmsXMLSchemaCache26Properties.Get_length: Integer;
begin
    Result := DefaultInterface.length;
end;

function TmsXMLSchemaCache26Properties.Get_namespaceURI(index: Integer): WideString;
begin
    Result := DefaultInterface.namespaceURI[index];
end;

{$ENDIF}

procedure TmsXMLSchemaCache30.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{F5078F34-C551-11D3-89B9-0000F81FE221}';
    IntfIID:   '{373984C8-B845-449B-91E7-45AC83036ADE}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TmsXMLSchemaCache30.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IXMLDOMSchemaCollection;
  end;
end;

procedure TmsXMLSchemaCache30.ConnectTo(svrIntf: IXMLDOMSchemaCollection);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TmsXMLSchemaCache30.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TmsXMLSchemaCache30.GetDefaultInterface: IXMLDOMSchemaCollection;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TmsXMLSchemaCache30.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TmsXMLSchemaCache30Properties.Create(Self);
{$ENDIF}
end;

destructor TmsXMLSchemaCache30.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TmsXMLSchemaCache30.GetServerProperties: TmsXMLSchemaCache30Properties;
begin
  Result := FProps;
end;
{$ENDIF}

function TmsXMLSchemaCache30.Get_length: Integer;
begin
    Result := DefaultInterface.length;
end;

function TmsXMLSchemaCache30.Get_namespaceURI(index: Integer): WideString;
begin
    Result := DefaultInterface.namespaceURI[index];
end;

procedure TmsXMLSchemaCache30.add(const namespaceURI: WideString; var_: OleVariant);
begin
  DefaultInterface.add(namespaceURI, var_);
end;

function TmsXMLSchemaCache30.get(const namespaceURI: WideString): IXMLDOMNode;
begin
  Result := DefaultInterface.get(namespaceURI);
end;

procedure TmsXMLSchemaCache30.remove(const namespaceURI: WideString);
begin
  DefaultInterface.remove(namespaceURI);
end;

procedure TmsXMLSchemaCache30.addCollection(const otherCollection: IXMLDOMSchemaCollection);
begin
  DefaultInterface.addCollection(otherCollection);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TmsXMLSchemaCache30Properties.Create(AServer: TmsXMLSchemaCache30);
begin
  inherited Create;
  FServer := AServer;
end;

function TmsXMLSchemaCache30Properties.GetDefaultInterface: IXMLDOMSchemaCollection;
begin
  Result := FServer.DefaultInterface;
end;

function TmsXMLSchemaCache30Properties.Get_length: Integer;
begin
    Result := DefaultInterface.length;
end;

function TmsXMLSchemaCache30Properties.Get_namespaceURI(index: Integer): WideString;
begin
    Result := DefaultInterface.namespaceURI[index];
end;

{$ENDIF}

procedure TXMLSchemaCache40.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{88D969C2-F192-11D4-A65F-0040963251E5}';
    IntfIID:   '{50EA08B0-DD1B-4664-9A50-C2F40F4BD79A}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TXMLSchemaCache40.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IXMLDOMSchemaCollection2;
  end;
end;

procedure TXMLSchemaCache40.ConnectTo(svrIntf: IXMLDOMSchemaCollection2);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TXMLSchemaCache40.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TXMLSchemaCache40.GetDefaultInterface: IXMLDOMSchemaCollection2;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TXMLSchemaCache40.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TXMLSchemaCache40Properties.Create(Self);
{$ENDIF}
end;

destructor TXMLSchemaCache40.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TXMLSchemaCache40.GetServerProperties: TXMLSchemaCache40Properties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TXMLSchemaCache40.Set_validateOnLoad(validateOnLoad: WordBool);
begin
  DefaultInterface.Set_validateOnLoad(validateOnLoad);
end;

function TXMLSchemaCache40.Get_validateOnLoad: WordBool;
begin
    Result := DefaultInterface.validateOnLoad;
end;

procedure TXMLSchemaCache40.validate;
begin
  DefaultInterface.validate;
end;

function TXMLSchemaCache40.getSchema(const namespaceURI: WideString): ISchema;
begin
  Result := DefaultInterface.getSchema(namespaceURI);
end;

function TXMLSchemaCache40.getDeclaration(const node: IXMLDOMNode): ISchemaItem;
begin
  Result := DefaultInterface.getDeclaration(node);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TXMLSchemaCache40Properties.Create(AServer: TXMLSchemaCache40);
begin
  inherited Create;
  FServer := AServer;
end;

function TXMLSchemaCache40Properties.GetDefaultInterface: IXMLDOMSchemaCollection2;
begin
  Result := FServer.DefaultInterface;
end;

procedure TXMLSchemaCache40Properties.Set_validateOnLoad(validateOnLoad: WordBool);
begin
  DefaultInterface.Set_validateOnLoad(validateOnLoad);
end;

function TXMLSchemaCache40Properties.Get_validateOnLoad: WordBool;
begin
    Result := DefaultInterface.validateOnLoad;
end;

{$ENDIF}

procedure TXMLSchemaCache60.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{88D96A07-F192-11D4-A65F-0040963251E5}';
    IntfIID:   '{50EA08B0-DD1B-4664-9A50-C2F40F4BD79A}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TXMLSchemaCache60.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IXMLDOMSchemaCollection2;
  end;
end;

procedure TXMLSchemaCache60.ConnectTo(svrIntf: IXMLDOMSchemaCollection2);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TXMLSchemaCache60.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TXMLSchemaCache60.GetDefaultInterface: IXMLDOMSchemaCollection2;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TXMLSchemaCache60.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TXMLSchemaCache60Properties.Create(Self);
{$ENDIF}
end;

destructor TXMLSchemaCache60.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TXMLSchemaCache60.GetServerProperties: TXMLSchemaCache60Properties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TXMLSchemaCache60.Set_validateOnLoad(validateOnLoad: WordBool);
begin
  DefaultInterface.Set_validateOnLoad(validateOnLoad);
end;

function TXMLSchemaCache60.Get_validateOnLoad: WordBool;
begin
    Result := DefaultInterface.validateOnLoad;
end;

procedure TXMLSchemaCache60.validate;
begin
  DefaultInterface.validate;
end;

function TXMLSchemaCache60.getSchema(const namespaceURI: WideString): ISchema;
begin
  Result := DefaultInterface.getSchema(namespaceURI);
end;

function TXMLSchemaCache60.getDeclaration(const node: IXMLDOMNode): ISchemaItem;
begin
  Result := DefaultInterface.getDeclaration(node);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TXMLSchemaCache60Properties.Create(AServer: TXMLSchemaCache60);
begin
  inherited Create;
  FServer := AServer;
end;

function TXMLSchemaCache60Properties.GetDefaultInterface: IXMLDOMSchemaCollection2;
begin
  Result := FServer.DefaultInterface;
end;

procedure TXMLSchemaCache60Properties.Set_validateOnLoad(validateOnLoad: WordBool);
begin
  DefaultInterface.Set_validateOnLoad(validateOnLoad);
end;

function TXMLSchemaCache60Properties.Get_validateOnLoad: WordBool;
begin
    Result := DefaultInterface.validateOnLoad;
end;

{$ENDIF}

procedure TmsXSLTemplate.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{2933BF94-7B36-11D2-B20E-00C04F983E60}';
    IntfIID:   '{2933BF93-7B36-11D2-B20E-00C04F983E60}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TmsXSLTemplate.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IXSLTemplate;
  end;
end;

procedure TmsXSLTemplate.ConnectTo(svrIntf: IXSLTemplate);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TmsXSLTemplate.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TmsXSLTemplate.GetDefaultInterface: IXSLTemplate;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TmsXSLTemplate.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TmsXSLTemplateProperties.Create(Self);
{$ENDIF}
end;

destructor TmsXSLTemplate.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TmsXSLTemplate.GetServerProperties: TmsXSLTemplateProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TmsXSLTemplate._Set_stylesheet(const stylesheet: IXMLDOMNode);
  { Warnung: Die Eigenschaftstylesheet hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.stylesheet := stylesheet;
end;

function TmsXSLTemplate.Get_stylesheet: IXMLDOMNode;
begin
    Result := DefaultInterface.stylesheet;
end;

function TmsXSLTemplate.createProcessor: IXSLProcessor;
begin
  Result := DefaultInterface.createProcessor;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TmsXSLTemplateProperties.Create(AServer: TmsXSLTemplate);
begin
  inherited Create;
  FServer := AServer;
end;

function TmsXSLTemplateProperties.GetDefaultInterface: IXSLTemplate;
begin
  Result := FServer.DefaultInterface;
end;

procedure TmsXSLTemplateProperties._Set_stylesheet(const stylesheet: IXMLDOMNode);
  { Warnung: Die Eigenschaftstylesheet hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.stylesheet := stylesheet;
end;

function TmsXSLTemplateProperties.Get_stylesheet: IXMLDOMNode;
begin
    Result := DefaultInterface.stylesheet;
end;

{$ENDIF}

procedure TmsXSLTemplate26.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{F5078F21-C551-11D3-89B9-0000F81FE221}';
    IntfIID:   '{2933BF93-7B36-11D2-B20E-00C04F983E60}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TmsXSLTemplate26.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IXSLTemplate;
  end;
end;

procedure TmsXSLTemplate26.ConnectTo(svrIntf: IXSLTemplate);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TmsXSLTemplate26.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TmsXSLTemplate26.GetDefaultInterface: IXSLTemplate;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TmsXSLTemplate26.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TmsXSLTemplate26Properties.Create(Self);
{$ENDIF}
end;

destructor TmsXSLTemplate26.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TmsXSLTemplate26.GetServerProperties: TmsXSLTemplate26Properties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TmsXSLTemplate26._Set_stylesheet(const stylesheet: IXMLDOMNode);
  { Warnung: Die Eigenschaftstylesheet hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.stylesheet := stylesheet;
end;

function TmsXSLTemplate26.Get_stylesheet: IXMLDOMNode;
begin
    Result := DefaultInterface.stylesheet;
end;

function TmsXSLTemplate26.createProcessor: IXSLProcessor;
begin
  Result := DefaultInterface.createProcessor;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TmsXSLTemplate26Properties.Create(AServer: TmsXSLTemplate26);
begin
  inherited Create;
  FServer := AServer;
end;

function TmsXSLTemplate26Properties.GetDefaultInterface: IXSLTemplate;
begin
  Result := FServer.DefaultInterface;
end;

procedure TmsXSLTemplate26Properties._Set_stylesheet(const stylesheet: IXMLDOMNode);
  { Warnung: Die Eigenschaftstylesheet hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.stylesheet := stylesheet;
end;

function TmsXSLTemplate26Properties.Get_stylesheet: IXMLDOMNode;
begin
    Result := DefaultInterface.stylesheet;
end;

{$ENDIF}

procedure TmsXSLTemplate30.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{F5078F36-C551-11D3-89B9-0000F81FE221}';
    IntfIID:   '{2933BF93-7B36-11D2-B20E-00C04F983E60}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TmsXSLTemplate30.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IXSLTemplate;
  end;
end;

procedure TmsXSLTemplate30.ConnectTo(svrIntf: IXSLTemplate);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TmsXSLTemplate30.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TmsXSLTemplate30.GetDefaultInterface: IXSLTemplate;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TmsXSLTemplate30.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TmsXSLTemplate30Properties.Create(Self);
{$ENDIF}
end;

destructor TmsXSLTemplate30.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TmsXSLTemplate30.GetServerProperties: TmsXSLTemplate30Properties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TmsXSLTemplate30._Set_stylesheet(const stylesheet: IXMLDOMNode);
  { Warnung: Die Eigenschaftstylesheet hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.stylesheet := stylesheet;
end;

function TmsXSLTemplate30.Get_stylesheet: IXMLDOMNode;
begin
    Result := DefaultInterface.stylesheet;
end;

function TmsXSLTemplate30.createProcessor: IXSLProcessor;
begin
  Result := DefaultInterface.createProcessor;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TmsXSLTemplate30Properties.Create(AServer: TmsXSLTemplate30);
begin
  inherited Create;
  FServer := AServer;
end;

function TmsXSLTemplate30Properties.GetDefaultInterface: IXSLTemplate;
begin
  Result := FServer.DefaultInterface;
end;

procedure TmsXSLTemplate30Properties._Set_stylesheet(const stylesheet: IXMLDOMNode);
  { Warnung: Die Eigenschaftstylesheet hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.stylesheet := stylesheet;
end;

function TmsXSLTemplate30Properties.Get_stylesheet: IXMLDOMNode;
begin
    Result := DefaultInterface.stylesheet;
end;

{$ENDIF}

procedure TXSLTemplate40.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{88D969C3-F192-11D4-A65F-0040963251E5}';
    IntfIID:   '{2933BF93-7B36-11D2-B20E-00C04F983E60}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TXSLTemplate40.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IXSLTemplate;
  end;
end;

procedure TXSLTemplate40.ConnectTo(svrIntf: IXSLTemplate);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TXSLTemplate40.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TXSLTemplate40.GetDefaultInterface: IXSLTemplate;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TXSLTemplate40.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TXSLTemplate40Properties.Create(Self);
{$ENDIF}
end;

destructor TXSLTemplate40.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TXSLTemplate40.GetServerProperties: TXSLTemplate40Properties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TXSLTemplate40._Set_stylesheet(const stylesheet: IXMLDOMNode);
  { Warnung: Die Eigenschaftstylesheet hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.stylesheet := stylesheet;
end;

function TXSLTemplate40.Get_stylesheet: IXMLDOMNode;
begin
    Result := DefaultInterface.stylesheet;
end;

function TXSLTemplate40.createProcessor: IXSLProcessor;
begin
  Result := DefaultInterface.createProcessor;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TXSLTemplate40Properties.Create(AServer: TXSLTemplate40);
begin
  inherited Create;
  FServer := AServer;
end;

function TXSLTemplate40Properties.GetDefaultInterface: IXSLTemplate;
begin
  Result := FServer.DefaultInterface;
end;

procedure TXSLTemplate40Properties._Set_stylesheet(const stylesheet: IXMLDOMNode);
  { Warnung: Die Eigenschaftstylesheet hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.stylesheet := stylesheet;
end;

function TXSLTemplate40Properties.Get_stylesheet: IXMLDOMNode;
begin
    Result := DefaultInterface.stylesheet;
end;

{$ENDIF}

procedure TXSLTemplate60.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{88D96A08-F192-11D4-A65F-0040963251E5}';
    IntfIID:   '{2933BF93-7B36-11D2-B20E-00C04F983E60}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TXSLTemplate60.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IXSLTemplate;
  end;
end;

procedure TXSLTemplate60.ConnectTo(svrIntf: IXSLTemplate);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TXSLTemplate60.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TXSLTemplate60.GetDefaultInterface: IXSLTemplate;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TXSLTemplate60.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TXSLTemplate60Properties.Create(Self);
{$ENDIF}
end;

destructor TXSLTemplate60.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TXSLTemplate60.GetServerProperties: TXSLTemplate60Properties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TXSLTemplate60._Set_stylesheet(const stylesheet: IXMLDOMNode);
  { Warnung: Die Eigenschaftstylesheet hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.stylesheet := stylesheet;
end;

function TXSLTemplate60.Get_stylesheet: IXMLDOMNode;
begin
    Result := DefaultInterface.stylesheet;
end;

function TXSLTemplate60.createProcessor: IXSLProcessor;
begin
  Result := DefaultInterface.createProcessor;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TXSLTemplate60Properties.Create(AServer: TXSLTemplate60);
begin
  inherited Create;
  FServer := AServer;
end;

function TXSLTemplate60Properties.GetDefaultInterface: IXSLTemplate;
begin
  Result := FServer.DefaultInterface;
end;

procedure TXSLTemplate60Properties._Set_stylesheet(const stylesheet: IXMLDOMNode);
  { Warnung: Die Eigenschaftstylesheet hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.stylesheet := stylesheet;
end;

function TXSLTemplate60Properties.Get_stylesheet: IXMLDOMNode;
begin
    Result := DefaultInterface.stylesheet;
end;

{$ENDIF}

procedure TmsXMLHTTP.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{F6D90F16-9C73-11D3-B32E-00C04F990BB4}';
    IntfIID:   '{ED8C108D-4349-11D2-91A4-00C04F7969E8}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TmsXMLHTTP.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IXMLHTTPRequest;
  end;
end;

procedure TmsXMLHTTP.ConnectTo(svrIntf: IXMLHTTPRequest);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TmsXMLHTTP.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TmsXMLHTTP.GetDefaultInterface: IXMLHTTPRequest;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TmsXMLHTTP.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TmsXMLHTTPProperties.Create(Self);
{$ENDIF}
end;

destructor TmsXMLHTTP.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TmsXMLHTTP.GetServerProperties: TmsXMLHTTPProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TmsXMLHTTP.Get_status: Integer;
begin
    Result := DefaultInterface.status;
end;

function TmsXMLHTTP.Get_statusText: WideString;
begin
    Result := DefaultInterface.statusText;
end;

function TmsXMLHTTP.Get_responseXML: IDispatch;
begin
    Result := DefaultInterface.responseXML;
end;

function TmsXMLHTTP.Get_responseText: WideString;
begin
    Result := DefaultInterface.responseText;
end;

function TmsXMLHTTP.Get_responseBody: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseBody;
end;

function TmsXMLHTTP.Get_responseStream: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseStream;
end;

function TmsXMLHTTP.Get_readyState: Integer;
begin
    Result := DefaultInterface.readyState;
end;

procedure TmsXMLHTTP.Set_onreadystatechange(const Param1: IDispatch);
begin
  DefaultInterface.Set_onreadystatechange(Param1);
end;

procedure TmsXMLHTTP.open(const bstrMethod: WideString; const bstrUrl: WideString);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, EmptyParam, EmptyParam, EmptyParam);
end;

procedure TmsXMLHTTP.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                          varAsync: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, EmptyParam, EmptyParam);
end;

procedure TmsXMLHTTP.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                          varAsync: OleVariant; bstrUser: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, bstrUser, EmptyParam);
end;

procedure TmsXMLHTTP.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                          varAsync: OleVariant; bstrUser: OleVariant; bstrPassword: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, bstrUser, bstrPassword);
end;

procedure TmsXMLHTTP.setRequestHeader(const bstrHeader: WideString; const bstrValue: WideString);
begin
  DefaultInterface.setRequestHeader(bstrHeader, bstrValue);
end;

function TmsXMLHTTP.getResponseHeader(const bstrHeader: WideString): WideString;
begin
  Result := DefaultInterface.getResponseHeader(bstrHeader);
end;

function TmsXMLHTTP.getAllResponseHeaders: WideString;
begin
  Result := DefaultInterface.getAllResponseHeaders;
end;

procedure TmsXMLHTTP.send;
begin
  DefaultInterface.send(EmptyParam);
end;

procedure TmsXMLHTTP.send(varBody: OleVariant);
begin
  DefaultInterface.send(varBody);
end;

procedure TmsXMLHTTP.abort;
begin
  DefaultInterface.abort;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TmsXMLHTTPProperties.Create(AServer: TmsXMLHTTP);
begin
  inherited Create;
  FServer := AServer;
end;

function TmsXMLHTTPProperties.GetDefaultInterface: IXMLHTTPRequest;
begin
  Result := FServer.DefaultInterface;
end;

function TmsXMLHTTPProperties.Get_status: Integer;
begin
    Result := DefaultInterface.status;
end;

function TmsXMLHTTPProperties.Get_statusText: WideString;
begin
    Result := DefaultInterface.statusText;
end;

function TmsXMLHTTPProperties.Get_responseXML: IDispatch;
begin
    Result := DefaultInterface.responseXML;
end;

function TmsXMLHTTPProperties.Get_responseText: WideString;
begin
    Result := DefaultInterface.responseText;
end;

function TmsXMLHTTPProperties.Get_responseBody: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseBody;
end;

function TmsXMLHTTPProperties.Get_responseStream: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseStream;
end;

function TmsXMLHTTPProperties.Get_readyState: Integer;
begin
    Result := DefaultInterface.readyState;
end;

procedure TmsXMLHTTPProperties.Set_onreadystatechange(const Param1: IDispatch);
begin
  DefaultInterface.Set_onreadystatechange(Param1);
end;

{$ENDIF}

procedure TmsXMLHTTP26.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{F5078F1E-C551-11D3-89B9-0000F81FE221}';
    IntfIID:   '{ED8C108D-4349-11D2-91A4-00C04F7969E8}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TmsXMLHTTP26.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IXMLHTTPRequest;
  end;
end;

procedure TmsXMLHTTP26.ConnectTo(svrIntf: IXMLHTTPRequest);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TmsXMLHTTP26.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TmsXMLHTTP26.GetDefaultInterface: IXMLHTTPRequest;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TmsXMLHTTP26.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TmsXMLHTTP26Properties.Create(Self);
{$ENDIF}
end;

destructor TmsXMLHTTP26.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TmsXMLHTTP26.GetServerProperties: TmsXMLHTTP26Properties;
begin
  Result := FProps;
end;
{$ENDIF}

function TmsXMLHTTP26.Get_status: Integer;
begin
    Result := DefaultInterface.status;
end;

function TmsXMLHTTP26.Get_statusText: WideString;
begin
    Result := DefaultInterface.statusText;
end;

function TmsXMLHTTP26.Get_responseXML: IDispatch;
begin
    Result := DefaultInterface.responseXML;
end;

function TmsXMLHTTP26.Get_responseText: WideString;
begin
    Result := DefaultInterface.responseText;
end;

function TmsXMLHTTP26.Get_responseBody: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseBody;
end;

function TmsXMLHTTP26.Get_responseStream: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseStream;
end;

function TmsXMLHTTP26.Get_readyState: Integer;
begin
    Result := DefaultInterface.readyState;
end;

procedure TmsXMLHTTP26.Set_onreadystatechange(const Param1: IDispatch);
begin
  DefaultInterface.Set_onreadystatechange(Param1);
end;

procedure TmsXMLHTTP26.open(const bstrMethod: WideString; const bstrUrl: WideString);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, EmptyParam, EmptyParam, EmptyParam);
end;

procedure TmsXMLHTTP26.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                            varAsync: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, EmptyParam, EmptyParam);
end;

procedure TmsXMLHTTP26.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                            varAsync: OleVariant; bstrUser: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, bstrUser, EmptyParam);
end;

procedure TmsXMLHTTP26.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                            varAsync: OleVariant; bstrUser: OleVariant; bstrPassword: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, bstrUser, bstrPassword);
end;

procedure TmsXMLHTTP26.setRequestHeader(const bstrHeader: WideString; const bstrValue: WideString);
begin
  DefaultInterface.setRequestHeader(bstrHeader, bstrValue);
end;

function TmsXMLHTTP26.getResponseHeader(const bstrHeader: WideString): WideString;
begin
  Result := DefaultInterface.getResponseHeader(bstrHeader);
end;

function TmsXMLHTTP26.getAllResponseHeaders: WideString;
begin
  Result := DefaultInterface.getAllResponseHeaders;
end;

procedure TmsXMLHTTP26.send;
begin
  DefaultInterface.send(EmptyParam);
end;

procedure TmsXMLHTTP26.send(varBody: OleVariant);
begin
  DefaultInterface.send(varBody);
end;

procedure TmsXMLHTTP26.abort;
begin
  DefaultInterface.abort;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TmsXMLHTTP26Properties.Create(AServer: TmsXMLHTTP26);
begin
  inherited Create;
  FServer := AServer;
end;

function TmsXMLHTTP26Properties.GetDefaultInterface: IXMLHTTPRequest;
begin
  Result := FServer.DefaultInterface;
end;

function TmsXMLHTTP26Properties.Get_status: Integer;
begin
    Result := DefaultInterface.status;
end;

function TmsXMLHTTP26Properties.Get_statusText: WideString;
begin
    Result := DefaultInterface.statusText;
end;

function TmsXMLHTTP26Properties.Get_responseXML: IDispatch;
begin
    Result := DefaultInterface.responseXML;
end;

function TmsXMLHTTP26Properties.Get_responseText: WideString;
begin
    Result := DefaultInterface.responseText;
end;

function TmsXMLHTTP26Properties.Get_responseBody: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseBody;
end;

function TmsXMLHTTP26Properties.Get_responseStream: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseStream;
end;

function TmsXMLHTTP26Properties.Get_readyState: Integer;
begin
    Result := DefaultInterface.readyState;
end;

procedure TmsXMLHTTP26Properties.Set_onreadystatechange(const Param1: IDispatch);
begin
  DefaultInterface.Set_onreadystatechange(Param1);
end;

{$ENDIF}

procedure TmsXMLHTTP30.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{F5078F35-C551-11D3-89B9-0000F81FE221}';
    IntfIID:   '{ED8C108D-4349-11D2-91A4-00C04F7969E8}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TmsXMLHTTP30.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IXMLHTTPRequest;
  end;
end;

procedure TmsXMLHTTP30.ConnectTo(svrIntf: IXMLHTTPRequest);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TmsXMLHTTP30.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TmsXMLHTTP30.GetDefaultInterface: IXMLHTTPRequest;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TmsXMLHTTP30.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TmsXMLHTTP30Properties.Create(Self);
{$ENDIF}
end;

destructor TmsXMLHTTP30.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TmsXMLHTTP30.GetServerProperties: TmsXMLHTTP30Properties;
begin
  Result := FProps;
end;
{$ENDIF}

function TmsXMLHTTP30.Get_status: Integer;
begin
    Result := DefaultInterface.status;
end;

function TmsXMLHTTP30.Get_statusText: WideString;
begin
    Result := DefaultInterface.statusText;
end;

function TmsXMLHTTP30.Get_responseXML: IDispatch;
begin
    Result := DefaultInterface.responseXML;
end;

function TmsXMLHTTP30.Get_responseText: WideString;
begin
    Result := DefaultInterface.responseText;
end;

function TmsXMLHTTP30.Get_responseBody: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseBody;
end;

function TmsXMLHTTP30.Get_responseStream: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseStream;
end;

function TmsXMLHTTP30.Get_readyState: Integer;
begin
    Result := DefaultInterface.readyState;
end;

procedure TmsXMLHTTP30.Set_onreadystatechange(const Param1: IDispatch);
begin
  DefaultInterface.Set_onreadystatechange(Param1);
end;

procedure TmsXMLHTTP30.open(const bstrMethod: WideString; const bstrUrl: WideString);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, EmptyParam, EmptyParam, EmptyParam);
end;

procedure TmsXMLHTTP30.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                            varAsync: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, EmptyParam, EmptyParam);
end;

procedure TmsXMLHTTP30.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                            varAsync: OleVariant; bstrUser: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, bstrUser, EmptyParam);
end;

procedure TmsXMLHTTP30.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                            varAsync: OleVariant; bstrUser: OleVariant; bstrPassword: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, bstrUser, bstrPassword);
end;

procedure TmsXMLHTTP30.setRequestHeader(const bstrHeader: WideString; const bstrValue: WideString);
begin
  DefaultInterface.setRequestHeader(bstrHeader, bstrValue);
end;

function TmsXMLHTTP30.getResponseHeader(const bstrHeader: WideString): WideString;
begin
  Result := DefaultInterface.getResponseHeader(bstrHeader);
end;

function TmsXMLHTTP30.getAllResponseHeaders: WideString;
begin
  Result := DefaultInterface.getAllResponseHeaders;
end;

procedure TmsXMLHTTP30.send;
begin
  DefaultInterface.send(EmptyParam);
end;

procedure TmsXMLHTTP30.send(varBody: OleVariant);
begin
  DefaultInterface.send(varBody);
end;

procedure TmsXMLHTTP30.abort;
begin
  DefaultInterface.abort;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TmsXMLHTTP30Properties.Create(AServer: TmsXMLHTTP30);
begin
  inherited Create;
  FServer := AServer;
end;

function TmsXMLHTTP30Properties.GetDefaultInterface: IXMLHTTPRequest;
begin
  Result := FServer.DefaultInterface;
end;

function TmsXMLHTTP30Properties.Get_status: Integer;
begin
    Result := DefaultInterface.status;
end;

function TmsXMLHTTP30Properties.Get_statusText: WideString;
begin
    Result := DefaultInterface.statusText;
end;

function TmsXMLHTTP30Properties.Get_responseXML: IDispatch;
begin
    Result := DefaultInterface.responseXML;
end;

function TmsXMLHTTP30Properties.Get_responseText: WideString;
begin
    Result := DefaultInterface.responseText;
end;

function TmsXMLHTTP30Properties.Get_responseBody: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseBody;
end;

function TmsXMLHTTP30Properties.Get_responseStream: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseStream;
end;

function TmsXMLHTTP30Properties.Get_readyState: Integer;
begin
    Result := DefaultInterface.readyState;
end;

procedure TmsXMLHTTP30Properties.Set_onreadystatechange(const Param1: IDispatch);
begin
  DefaultInterface.Set_onreadystatechange(Param1);
end;

{$ENDIF}

procedure TXMLHTTP40.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{88D969C5-F192-11D4-A65F-0040963251E5}';
    IntfIID:   '{ED8C108D-4349-11D2-91A4-00C04F7969E8}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TXMLHTTP40.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IXMLHTTPRequest;
  end;
end;

procedure TXMLHTTP40.ConnectTo(svrIntf: IXMLHTTPRequest);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TXMLHTTP40.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TXMLHTTP40.GetDefaultInterface: IXMLHTTPRequest;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TXMLHTTP40.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TXMLHTTP40Properties.Create(Self);
{$ENDIF}
end;

destructor TXMLHTTP40.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TXMLHTTP40.GetServerProperties: TXMLHTTP40Properties;
begin
  Result := FProps;
end;
{$ENDIF}

function TXMLHTTP40.Get_status: Integer;
begin
    Result := DefaultInterface.status;
end;

function TXMLHTTP40.Get_statusText: WideString;
begin
    Result := DefaultInterface.statusText;
end;

function TXMLHTTP40.Get_responseXML: IDispatch;
begin
    Result := DefaultInterface.responseXML;
end;

function TXMLHTTP40.Get_responseText: WideString;
begin
    Result := DefaultInterface.responseText;
end;

function TXMLHTTP40.Get_responseBody: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseBody;
end;

function TXMLHTTP40.Get_responseStream: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseStream;
end;

function TXMLHTTP40.Get_readyState: Integer;
begin
    Result := DefaultInterface.readyState;
end;

procedure TXMLHTTP40.Set_onreadystatechange(const Param1: IDispatch);
begin
  DefaultInterface.Set_onreadystatechange(Param1);
end;

procedure TXMLHTTP40.open(const bstrMethod: WideString; const bstrUrl: WideString);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, EmptyParam, EmptyParam, EmptyParam);
end;

procedure TXMLHTTP40.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                          varAsync: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, EmptyParam, EmptyParam);
end;

procedure TXMLHTTP40.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                          varAsync: OleVariant; bstrUser: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, bstrUser, EmptyParam);
end;

procedure TXMLHTTP40.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                          varAsync: OleVariant; bstrUser: OleVariant; bstrPassword: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, bstrUser, bstrPassword);
end;

procedure TXMLHTTP40.setRequestHeader(const bstrHeader: WideString; const bstrValue: WideString);
begin
  DefaultInterface.setRequestHeader(bstrHeader, bstrValue);
end;

function TXMLHTTP40.getResponseHeader(const bstrHeader: WideString): WideString;
begin
  Result := DefaultInterface.getResponseHeader(bstrHeader);
end;

function TXMLHTTP40.getAllResponseHeaders: WideString;
begin
  Result := DefaultInterface.getAllResponseHeaders;
end;

procedure TXMLHTTP40.send;
begin
  DefaultInterface.send(EmptyParam);
end;

procedure TXMLHTTP40.send(varBody: OleVariant);
begin
  DefaultInterface.send(varBody);
end;

procedure TXMLHTTP40.abort;
begin
  DefaultInterface.abort;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TXMLHTTP40Properties.Create(AServer: TXMLHTTP40);
begin
  inherited Create;
  FServer := AServer;
end;

function TXMLHTTP40Properties.GetDefaultInterface: IXMLHTTPRequest;
begin
  Result := FServer.DefaultInterface;
end;

function TXMLHTTP40Properties.Get_status: Integer;
begin
    Result := DefaultInterface.status;
end;

function TXMLHTTP40Properties.Get_statusText: WideString;
begin
    Result := DefaultInterface.statusText;
end;

function TXMLHTTP40Properties.Get_responseXML: IDispatch;
begin
    Result := DefaultInterface.responseXML;
end;

function TXMLHTTP40Properties.Get_responseText: WideString;
begin
    Result := DefaultInterface.responseText;
end;

function TXMLHTTP40Properties.Get_responseBody: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseBody;
end;

function TXMLHTTP40Properties.Get_responseStream: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseStream;
end;

function TXMLHTTP40Properties.Get_readyState: Integer;
begin
    Result := DefaultInterface.readyState;
end;

procedure TXMLHTTP40Properties.Set_onreadystatechange(const Param1: IDispatch);
begin
  DefaultInterface.Set_onreadystatechange(Param1);
end;

{$ENDIF}

procedure TXMLHTTP60.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{88D96A0A-F192-11D4-A65F-0040963251E5}';
    IntfIID:   '{ED8C108D-4349-11D2-91A4-00C04F7969E8}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TXMLHTTP60.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IXMLHTTPRequest;
  end;
end;

procedure TXMLHTTP60.ConnectTo(svrIntf: IXMLHTTPRequest);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TXMLHTTP60.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TXMLHTTP60.GetDefaultInterface: IXMLHTTPRequest;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TXMLHTTP60.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TXMLHTTP60Properties.Create(Self);
{$ENDIF}
end;

destructor TXMLHTTP60.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TXMLHTTP60.GetServerProperties: TXMLHTTP60Properties;
begin
  Result := FProps;
end;
{$ENDIF}

function TXMLHTTP60.Get_status: Integer;
begin
    Result := DefaultInterface.status;
end;

function TXMLHTTP60.Get_statusText: WideString;
begin
    Result := DefaultInterface.statusText;
end;

function TXMLHTTP60.Get_responseXML: IDispatch;
begin
    Result := DefaultInterface.responseXML;
end;

function TXMLHTTP60.Get_responseText: WideString;
begin
    Result := DefaultInterface.responseText;
end;

function TXMLHTTP60.Get_responseBody: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseBody;
end;

function TXMLHTTP60.Get_responseStream: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseStream;
end;

function TXMLHTTP60.Get_readyState: Integer;
begin
    Result := DefaultInterface.readyState;
end;

procedure TXMLHTTP60.Set_onreadystatechange(const Param1: IDispatch);
begin
  DefaultInterface.Set_onreadystatechange(Param1);
end;

procedure TXMLHTTP60.open(const bstrMethod: WideString; const bstrUrl: WideString);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, EmptyParam, EmptyParam, EmptyParam);
end;

procedure TXMLHTTP60.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                          varAsync: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, EmptyParam, EmptyParam);
end;

procedure TXMLHTTP60.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                          varAsync: OleVariant; bstrUser: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, bstrUser, EmptyParam);
end;

procedure TXMLHTTP60.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                          varAsync: OleVariant; bstrUser: OleVariant; bstrPassword: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, bstrUser, bstrPassword);
end;

procedure TXMLHTTP60.setRequestHeader(const bstrHeader: WideString; const bstrValue: WideString);
begin
  DefaultInterface.setRequestHeader(bstrHeader, bstrValue);
end;

function TXMLHTTP60.getResponseHeader(const bstrHeader: WideString): WideString;
begin
  Result := DefaultInterface.getResponseHeader(bstrHeader);
end;

function TXMLHTTP60.getAllResponseHeaders: WideString;
begin
  Result := DefaultInterface.getAllResponseHeaders;
end;

procedure TXMLHTTP60.send;
begin
  DefaultInterface.send(EmptyParam);
end;

procedure TXMLHTTP60.send(varBody: OleVariant);
begin
  DefaultInterface.send(varBody);
end;

procedure TXMLHTTP60.abort;
begin
  DefaultInterface.abort;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TXMLHTTP60Properties.Create(AServer: TXMLHTTP60);
begin
  inherited Create;
  FServer := AServer;
end;

function TXMLHTTP60Properties.GetDefaultInterface: IXMLHTTPRequest;
begin
  Result := FServer.DefaultInterface;
end;

function TXMLHTTP60Properties.Get_status: Integer;
begin
    Result := DefaultInterface.status;
end;

function TXMLHTTP60Properties.Get_statusText: WideString;
begin
    Result := DefaultInterface.statusText;
end;

function TXMLHTTP60Properties.Get_responseXML: IDispatch;
begin
    Result := DefaultInterface.responseXML;
end;

function TXMLHTTP60Properties.Get_responseText: WideString;
begin
    Result := DefaultInterface.responseText;
end;

function TXMLHTTP60Properties.Get_responseBody: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseBody;
end;

function TXMLHTTP60Properties.Get_responseStream: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseStream;
end;

function TXMLHTTP60Properties.Get_readyState: Integer;
begin
    Result := DefaultInterface.readyState;
end;

procedure TXMLHTTP60Properties.Set_onreadystatechange(const Param1: IDispatch);
begin
  DefaultInterface.Set_onreadystatechange(Param1);
end;

{$ENDIF}

procedure TmsServerXMLHTTP.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{AFBA6B42-5692-48EA-8141-DC517DCF0EF1}';
    IntfIID:   '{2E9196BF-13BA-4DD4-91CA-6C571F281495}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TmsServerXMLHTTP.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IServerXMLHTTPRequest;
  end;
end;

procedure TmsServerXMLHTTP.ConnectTo(svrIntf: IServerXMLHTTPRequest);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TmsServerXMLHTTP.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TmsServerXMLHTTP.GetDefaultInterface: IServerXMLHTTPRequest;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TmsServerXMLHTTP.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TmsServerXMLHTTPProperties.Create(Self);
{$ENDIF}
end;

destructor TmsServerXMLHTTP.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TmsServerXMLHTTP.GetServerProperties: TmsServerXMLHTTPProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TmsServerXMLHTTP.Get_status: Integer;
begin
    Result := DefaultInterface.status;
end;

function TmsServerXMLHTTP.Get_statusText: WideString;
begin
    Result := DefaultInterface.statusText;
end;

function TmsServerXMLHTTP.Get_responseXML: IDispatch;
begin
    Result := DefaultInterface.responseXML;
end;

function TmsServerXMLHTTP.Get_responseText: WideString;
begin
    Result := DefaultInterface.responseText;
end;

function TmsServerXMLHTTP.Get_responseBody: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseBody;
end;

function TmsServerXMLHTTP.Get_responseStream: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseStream;
end;

function TmsServerXMLHTTP.Get_readyState: Integer;
begin
    Result := DefaultInterface.readyState;
end;

procedure TmsServerXMLHTTP.Set_onreadystatechange(const Param1: IDispatch);
begin
  DefaultInterface.Set_onreadystatechange(Param1);
end;

procedure TmsServerXMLHTTP.open(const bstrMethod: WideString; const bstrUrl: WideString);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, EmptyParam, EmptyParam, EmptyParam);
end;

procedure TmsServerXMLHTTP.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                                varAsync: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, EmptyParam, EmptyParam);
end;

procedure TmsServerXMLHTTP.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                                varAsync: OleVariant; bstrUser: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, bstrUser, EmptyParam);
end;

procedure TmsServerXMLHTTP.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                                varAsync: OleVariant; bstrUser: OleVariant; bstrPassword: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, bstrUser, bstrPassword);
end;

procedure TmsServerXMLHTTP.setRequestHeader(const bstrHeader: WideString; 
                                            const bstrValue: WideString);
begin
  DefaultInterface.setRequestHeader(bstrHeader, bstrValue);
end;

function TmsServerXMLHTTP.getResponseHeader(const bstrHeader: WideString): WideString;
begin
  Result := DefaultInterface.getResponseHeader(bstrHeader);
end;

function TmsServerXMLHTTP.getAllResponseHeaders: WideString;
begin
  Result := DefaultInterface.getAllResponseHeaders;
end;

procedure TmsServerXMLHTTP.send;
begin
  DefaultInterface.send(EmptyParam);
end;

procedure TmsServerXMLHTTP.send(varBody: OleVariant);
begin
  DefaultInterface.send(varBody);
end;

procedure TmsServerXMLHTTP.abort;
begin
  DefaultInterface.abort;
end;

procedure TmsServerXMLHTTP.setTimeouts(resolveTimeout: Integer; connectTimeout: Integer; 
                                       sendTimeout: Integer; receiveTimeout: Integer);
begin
  DefaultInterface.setTimeouts(resolveTimeout, connectTimeout, sendTimeout, receiveTimeout);
end;

function TmsServerXMLHTTP.waitForResponse: WordBool;
begin
  Result := DefaultInterface.waitForResponse(EmptyParam);
end;

function TmsServerXMLHTTP.waitForResponse(timeoutInSeconds: OleVariant): WordBool;
begin
  Result := DefaultInterface.waitForResponse(timeoutInSeconds);
end;

function TmsServerXMLHTTP.getOption(option: SERVERXMLHTTP_OPTION): OleVariant;
begin
  Result := DefaultInterface.getOption(option);
end;

procedure TmsServerXMLHTTP.setOption(option: SERVERXMLHTTP_OPTION; value: OleVariant);
begin
  DefaultInterface.setOption(option, value);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TmsServerXMLHTTPProperties.Create(AServer: TmsServerXMLHTTP);
begin
  inherited Create;
  FServer := AServer;
end;

function TmsServerXMLHTTPProperties.GetDefaultInterface: IServerXMLHTTPRequest;
begin
  Result := FServer.DefaultInterface;
end;

function TmsServerXMLHTTPProperties.Get_status: Integer;
begin
    Result := DefaultInterface.status;
end;

function TmsServerXMLHTTPProperties.Get_statusText: WideString;
begin
    Result := DefaultInterface.statusText;
end;

function TmsServerXMLHTTPProperties.Get_responseXML: IDispatch;
begin
    Result := DefaultInterface.responseXML;
end;

function TmsServerXMLHTTPProperties.Get_responseText: WideString;
begin
    Result := DefaultInterface.responseText;
end;

function TmsServerXMLHTTPProperties.Get_responseBody: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseBody;
end;

function TmsServerXMLHTTPProperties.Get_responseStream: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseStream;
end;

function TmsServerXMLHTTPProperties.Get_readyState: Integer;
begin
    Result := DefaultInterface.readyState;
end;

procedure TmsServerXMLHTTPProperties.Set_onreadystatechange(const Param1: IDispatch);
begin
  DefaultInterface.Set_onreadystatechange(Param1);
end;

{$ENDIF}

procedure TmsServerXMLHTTP30.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{AFB40FFD-B609-40A3-9828-F88BBE11E4E3}';
    IntfIID:   '{2E9196BF-13BA-4DD4-91CA-6C571F281495}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TmsServerXMLHTTP30.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IServerXMLHTTPRequest;
  end;
end;

procedure TmsServerXMLHTTP30.ConnectTo(svrIntf: IServerXMLHTTPRequest);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TmsServerXMLHTTP30.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TmsServerXMLHTTP30.GetDefaultInterface: IServerXMLHTTPRequest;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TmsServerXMLHTTP30.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TmsServerXMLHTTP30Properties.Create(Self);
{$ENDIF}
end;

destructor TmsServerXMLHTTP30.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TmsServerXMLHTTP30.GetServerProperties: TmsServerXMLHTTP30Properties;
begin
  Result := FProps;
end;
{$ENDIF}

function TmsServerXMLHTTP30.Get_status: Integer;
begin
    Result := DefaultInterface.status;
end;

function TmsServerXMLHTTP30.Get_statusText: WideString;
begin
    Result := DefaultInterface.statusText;
end;

function TmsServerXMLHTTP30.Get_responseXML: IDispatch;
begin
    Result := DefaultInterface.responseXML;
end;

function TmsServerXMLHTTP30.Get_responseText: WideString;
begin
    Result := DefaultInterface.responseText;
end;

function TmsServerXMLHTTP30.Get_responseBody: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseBody;
end;

function TmsServerXMLHTTP30.Get_responseStream: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseStream;
end;

function TmsServerXMLHTTP30.Get_readyState: Integer;
begin
    Result := DefaultInterface.readyState;
end;

procedure TmsServerXMLHTTP30.Set_onreadystatechange(const Param1: IDispatch);
begin
  DefaultInterface.Set_onreadystatechange(Param1);
end;

procedure TmsServerXMLHTTP30.open(const bstrMethod: WideString; const bstrUrl: WideString);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, EmptyParam, EmptyParam, EmptyParam);
end;

procedure TmsServerXMLHTTP30.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                                  varAsync: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, EmptyParam, EmptyParam);
end;

procedure TmsServerXMLHTTP30.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                                  varAsync: OleVariant; bstrUser: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, bstrUser, EmptyParam);
end;

procedure TmsServerXMLHTTP30.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                                  varAsync: OleVariant; bstrUser: OleVariant; 
                                  bstrPassword: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, bstrUser, bstrPassword);
end;

procedure TmsServerXMLHTTP30.setRequestHeader(const bstrHeader: WideString; 
                                              const bstrValue: WideString);
begin
  DefaultInterface.setRequestHeader(bstrHeader, bstrValue);
end;

function TmsServerXMLHTTP30.getResponseHeader(const bstrHeader: WideString): WideString;
begin
  Result := DefaultInterface.getResponseHeader(bstrHeader);
end;

function TmsServerXMLHTTP30.getAllResponseHeaders: WideString;
begin
  Result := DefaultInterface.getAllResponseHeaders;
end;

procedure TmsServerXMLHTTP30.send;
begin
  DefaultInterface.send(EmptyParam);
end;

procedure TmsServerXMLHTTP30.send(varBody: OleVariant);
begin
  DefaultInterface.send(varBody);
end;

procedure TmsServerXMLHTTP30.abort;
begin
  DefaultInterface.abort;
end;

procedure TmsServerXMLHTTP30.setTimeouts(resolveTimeout: Integer; connectTimeout: Integer; 
                                         sendTimeout: Integer; receiveTimeout: Integer);
begin
  DefaultInterface.setTimeouts(resolveTimeout, connectTimeout, sendTimeout, receiveTimeout);
end;

function TmsServerXMLHTTP30.waitForResponse: WordBool;
begin
  Result := DefaultInterface.waitForResponse(EmptyParam);
end;

function TmsServerXMLHTTP30.waitForResponse(timeoutInSeconds: OleVariant): WordBool;
begin
  Result := DefaultInterface.waitForResponse(timeoutInSeconds);
end;

function TmsServerXMLHTTP30.getOption(option: SERVERXMLHTTP_OPTION): OleVariant;
begin
  Result := DefaultInterface.getOption(option);
end;

procedure TmsServerXMLHTTP30.setOption(option: SERVERXMLHTTP_OPTION; value: OleVariant);
begin
  DefaultInterface.setOption(option, value);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TmsServerXMLHTTP30Properties.Create(AServer: TmsServerXMLHTTP30);
begin
  inherited Create;
  FServer := AServer;
end;

function TmsServerXMLHTTP30Properties.GetDefaultInterface: IServerXMLHTTPRequest;
begin
  Result := FServer.DefaultInterface;
end;

function TmsServerXMLHTTP30Properties.Get_status: Integer;
begin
    Result := DefaultInterface.status;
end;

function TmsServerXMLHTTP30Properties.Get_statusText: WideString;
begin
    Result := DefaultInterface.statusText;
end;

function TmsServerXMLHTTP30Properties.Get_responseXML: IDispatch;
begin
    Result := DefaultInterface.responseXML;
end;

function TmsServerXMLHTTP30Properties.Get_responseText: WideString;
begin
    Result := DefaultInterface.responseText;
end;

function TmsServerXMLHTTP30Properties.Get_responseBody: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseBody;
end;

function TmsServerXMLHTTP30Properties.Get_responseStream: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseStream;
end;

function TmsServerXMLHTTP30Properties.Get_readyState: Integer;
begin
    Result := DefaultInterface.readyState;
end;

procedure TmsServerXMLHTTP30Properties.Set_onreadystatechange(const Param1: IDispatch);
begin
  DefaultInterface.Set_onreadystatechange(Param1);
end;

{$ENDIF}

procedure TServerXMLHTTP40.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{88D969C6-F192-11D4-A65F-0040963251E5}';
    IntfIID:   '{2E01311B-C322-4B0A-BD77-B90CFDC8DCE7}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TServerXMLHTTP40.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IServerXMLHTTPRequest2;
  end;
end;

procedure TServerXMLHTTP40.ConnectTo(svrIntf: IServerXMLHTTPRequest2);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TServerXMLHTTP40.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TServerXMLHTTP40.GetDefaultInterface: IServerXMLHTTPRequest2;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TServerXMLHTTP40.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TServerXMLHTTP40Properties.Create(Self);
{$ENDIF}
end;

destructor TServerXMLHTTP40.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TServerXMLHTTP40.GetServerProperties: TServerXMLHTTP40Properties;
begin
  Result := FProps;
end;
{$ENDIF}

function TServerXMLHTTP40.Get_status: Integer;
begin
    Result := DefaultInterface.status;
end;

function TServerXMLHTTP40.Get_statusText: WideString;
begin
    Result := DefaultInterface.statusText;
end;

function TServerXMLHTTP40.Get_responseXML: IDispatch;
begin
    Result := DefaultInterface.responseXML;
end;

function TServerXMLHTTP40.Get_responseText: WideString;
begin
    Result := DefaultInterface.responseText;
end;

function TServerXMLHTTP40.Get_responseBody: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseBody;
end;

function TServerXMLHTTP40.Get_responseStream: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseStream;
end;

function TServerXMLHTTP40.Get_readyState: Integer;
begin
    Result := DefaultInterface.readyState;
end;

procedure TServerXMLHTTP40.Set_onreadystatechange(const Param1: IDispatch);
begin
  DefaultInterface.Set_onreadystatechange(Param1);
end;

procedure TServerXMLHTTP40.open(const bstrMethod: WideString; const bstrUrl: WideString);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, EmptyParam, EmptyParam, EmptyParam);
end;

procedure TServerXMLHTTP40.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                                varAsync: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, EmptyParam, EmptyParam);
end;

procedure TServerXMLHTTP40.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                                varAsync: OleVariant; bstrUser: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, bstrUser, EmptyParam);
end;

procedure TServerXMLHTTP40.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                                varAsync: OleVariant; bstrUser: OleVariant; bstrPassword: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, bstrUser, bstrPassword);
end;

procedure TServerXMLHTTP40.setRequestHeader(const bstrHeader: WideString; 
                                            const bstrValue: WideString);
begin
  DefaultInterface.setRequestHeader(bstrHeader, bstrValue);
end;

function TServerXMLHTTP40.getResponseHeader(const bstrHeader: WideString): WideString;
begin
  Result := DefaultInterface.getResponseHeader(bstrHeader);
end;

function TServerXMLHTTP40.getAllResponseHeaders: WideString;
begin
  Result := DefaultInterface.getAllResponseHeaders;
end;

procedure TServerXMLHTTP40.send;
begin
  DefaultInterface.send(EmptyParam);
end;

procedure TServerXMLHTTP40.send(varBody: OleVariant);
begin
  DefaultInterface.send(varBody);
end;

procedure TServerXMLHTTP40.abort;
begin
  DefaultInterface.abort;
end;

procedure TServerXMLHTTP40.setTimeouts(resolveTimeout: Integer; connectTimeout: Integer; 
                                       sendTimeout: Integer; receiveTimeout: Integer);
begin
  DefaultInterface.setTimeouts(resolveTimeout, connectTimeout, sendTimeout, receiveTimeout);
end;

function TServerXMLHTTP40.waitForResponse: WordBool;
begin
  Result := DefaultInterface.waitForResponse(EmptyParam);
end;

function TServerXMLHTTP40.waitForResponse(timeoutInSeconds: OleVariant): WordBool;
begin
  Result := DefaultInterface.waitForResponse(timeoutInSeconds);
end;

function TServerXMLHTTP40.getOption(option: SERVERXMLHTTP_OPTION): OleVariant;
begin
  Result := DefaultInterface.getOption(option);
end;

procedure TServerXMLHTTP40.setOption(option: SERVERXMLHTTP_OPTION; value: OleVariant);
begin
  DefaultInterface.setOption(option, value);
end;

procedure TServerXMLHTTP40.setProxy(proxySetting: SXH_PROXY_SETTING);
begin
  DefaultInterface.setProxy(proxySetting, EmptyParam, EmptyParam);
end;

procedure TServerXMLHTTP40.setProxy(proxySetting: SXH_PROXY_SETTING; varProxyServer: OleVariant);
begin
  DefaultInterface.setProxy(proxySetting, varProxyServer, EmptyParam);
end;

procedure TServerXMLHTTP40.setProxy(proxySetting: SXH_PROXY_SETTING; varProxyServer: OleVariant; 
                                    varBypassList: OleVariant);
begin
  DefaultInterface.setProxy(proxySetting, varProxyServer, varBypassList);
end;

procedure TServerXMLHTTP40.setProxyCredentials(const bstrUserName: WideString; 
                                               const bstrPassword: WideString);
begin
  DefaultInterface.setProxyCredentials(bstrUserName, bstrPassword);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TServerXMLHTTP40Properties.Create(AServer: TServerXMLHTTP40);
begin
  inherited Create;
  FServer := AServer;
end;

function TServerXMLHTTP40Properties.GetDefaultInterface: IServerXMLHTTPRequest2;
begin
  Result := FServer.DefaultInterface;
end;

function TServerXMLHTTP40Properties.Get_status: Integer;
begin
    Result := DefaultInterface.status;
end;

function TServerXMLHTTP40Properties.Get_statusText: WideString;
begin
    Result := DefaultInterface.statusText;
end;

function TServerXMLHTTP40Properties.Get_responseXML: IDispatch;
begin
    Result := DefaultInterface.responseXML;
end;

function TServerXMLHTTP40Properties.Get_responseText: WideString;
begin
    Result := DefaultInterface.responseText;
end;

function TServerXMLHTTP40Properties.Get_responseBody: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseBody;
end;

function TServerXMLHTTP40Properties.Get_responseStream: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseStream;
end;

function TServerXMLHTTP40Properties.Get_readyState: Integer;
begin
    Result := DefaultInterface.readyState;
end;

procedure TServerXMLHTTP40Properties.Set_onreadystatechange(const Param1: IDispatch);
begin
  DefaultInterface.Set_onreadystatechange(Param1);
end;

{$ENDIF}

procedure TServerXMLHTTP60.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{88D96A0B-F192-11D4-A65F-0040963251E5}';
    IntfIID:   '{2E01311B-C322-4B0A-BD77-B90CFDC8DCE7}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TServerXMLHTTP60.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IServerXMLHTTPRequest2;
  end;
end;

procedure TServerXMLHTTP60.ConnectTo(svrIntf: IServerXMLHTTPRequest2);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TServerXMLHTTP60.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TServerXMLHTTP60.GetDefaultInterface: IServerXMLHTTPRequest2;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TServerXMLHTTP60.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TServerXMLHTTP60Properties.Create(Self);
{$ENDIF}
end;

destructor TServerXMLHTTP60.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TServerXMLHTTP60.GetServerProperties: TServerXMLHTTP60Properties;
begin
  Result := FProps;
end;
{$ENDIF}

function TServerXMLHTTP60.Get_status: Integer;
begin
    Result := DefaultInterface.status;
end;

function TServerXMLHTTP60.Get_statusText: WideString;
begin
    Result := DefaultInterface.statusText;
end;

function TServerXMLHTTP60.Get_responseXML: IDispatch;
begin
    Result := DefaultInterface.responseXML;
end;

function TServerXMLHTTP60.Get_responseText: WideString;
begin
    Result := DefaultInterface.responseText;
end;

function TServerXMLHTTP60.Get_responseBody: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseBody;
end;

function TServerXMLHTTP60.Get_responseStream: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseStream;
end;

function TServerXMLHTTP60.Get_readyState: Integer;
begin
    Result := DefaultInterface.readyState;
end;

procedure TServerXMLHTTP60.Set_onreadystatechange(const Param1: IDispatch);
begin
  DefaultInterface.Set_onreadystatechange(Param1);
end;

procedure TServerXMLHTTP60.open(const bstrMethod: WideString; const bstrUrl: WideString);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, EmptyParam, EmptyParam, EmptyParam);
end;

procedure TServerXMLHTTP60.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                                varAsync: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, EmptyParam, EmptyParam);
end;

procedure TServerXMLHTTP60.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                                varAsync: OleVariant; bstrUser: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, bstrUser, EmptyParam);
end;

procedure TServerXMLHTTP60.open(const bstrMethod: WideString; const bstrUrl: WideString; 
                                varAsync: OleVariant; bstrUser: OleVariant; bstrPassword: OleVariant);
begin
  DefaultInterface.open(bstrMethod, bstrUrl, varAsync, bstrUser, bstrPassword);
end;

procedure TServerXMLHTTP60.setRequestHeader(const bstrHeader: WideString; 
                                            const bstrValue: WideString);
begin
  DefaultInterface.setRequestHeader(bstrHeader, bstrValue);
end;

function TServerXMLHTTP60.getResponseHeader(const bstrHeader: WideString): WideString;
begin
  Result := DefaultInterface.getResponseHeader(bstrHeader);
end;

function TServerXMLHTTP60.getAllResponseHeaders: WideString;
begin
  Result := DefaultInterface.getAllResponseHeaders;
end;

procedure TServerXMLHTTP60.send;
begin
  DefaultInterface.send(EmptyParam);
end;

procedure TServerXMLHTTP60.send(varBody: OleVariant);
begin
  DefaultInterface.send(varBody);
end;

procedure TServerXMLHTTP60.abort;
begin
  DefaultInterface.abort;
end;

procedure TServerXMLHTTP60.setTimeouts(resolveTimeout: Integer; connectTimeout: Integer; 
                                       sendTimeout: Integer; receiveTimeout: Integer);
begin
  DefaultInterface.setTimeouts(resolveTimeout, connectTimeout, sendTimeout, receiveTimeout);
end;

function TServerXMLHTTP60.waitForResponse: WordBool;
begin
  Result := DefaultInterface.waitForResponse(EmptyParam);
end;

function TServerXMLHTTP60.waitForResponse(timeoutInSeconds: OleVariant): WordBool;
begin
  Result := DefaultInterface.waitForResponse(timeoutInSeconds);
end;

function TServerXMLHTTP60.getOption(option: SERVERXMLHTTP_OPTION): OleVariant;
begin
  Result := DefaultInterface.getOption(option);
end;

procedure TServerXMLHTTP60.setOption(option: SERVERXMLHTTP_OPTION; value: OleVariant);
begin
  DefaultInterface.setOption(option, value);
end;

procedure TServerXMLHTTP60.setProxy(proxySetting: SXH_PROXY_SETTING);
begin
  DefaultInterface.setProxy(proxySetting, EmptyParam, EmptyParam);
end;

procedure TServerXMLHTTP60.setProxy(proxySetting: SXH_PROXY_SETTING; varProxyServer: OleVariant);
begin
  DefaultInterface.setProxy(proxySetting, varProxyServer, EmptyParam);
end;

procedure TServerXMLHTTP60.setProxy(proxySetting: SXH_PROXY_SETTING; varProxyServer: OleVariant; 
                                    varBypassList: OleVariant);
begin
  DefaultInterface.setProxy(proxySetting, varProxyServer, varBypassList);
end;

procedure TServerXMLHTTP60.setProxyCredentials(const bstrUserName: WideString; 
                                               const bstrPassword: WideString);
begin
  DefaultInterface.setProxyCredentials(bstrUserName, bstrPassword);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TServerXMLHTTP60Properties.Create(AServer: TServerXMLHTTP60);
begin
  inherited Create;
  FServer := AServer;
end;

function TServerXMLHTTP60Properties.GetDefaultInterface: IServerXMLHTTPRequest2;
begin
  Result := FServer.DefaultInterface;
end;

function TServerXMLHTTP60Properties.Get_status: Integer;
begin
    Result := DefaultInterface.status;
end;

function TServerXMLHTTP60Properties.Get_statusText: WideString;
begin
    Result := DefaultInterface.statusText;
end;

function TServerXMLHTTP60Properties.Get_responseXML: IDispatch;
begin
    Result := DefaultInterface.responseXML;
end;

function TServerXMLHTTP60Properties.Get_responseText: WideString;
begin
    Result := DefaultInterface.responseText;
end;

function TServerXMLHTTP60Properties.Get_responseBody: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseBody;
end;

function TServerXMLHTTP60Properties.Get_responseStream: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.responseStream;
end;

function TServerXMLHTTP60Properties.Get_readyState: Integer;
begin
    Result := DefaultInterface.readyState;
end;

procedure TServerXMLHTTP60Properties.Set_onreadystatechange(const Param1: IDispatch);
begin
  DefaultInterface.Set_onreadystatechange(Param1);
end;

{$ENDIF}

procedure TmsSAXXMLReader.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{079AA557-4A18-424A-8EEE-E39F0A8D41B9}';
    IntfIID:   '{8C033CAA-6CD6-4F73-B728-4531AF74945F}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TmsSAXXMLReader.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IVBSAXXMLReader;
  end;
end;

procedure TmsSAXXMLReader.ConnectTo(svrIntf: IVBSAXXMLReader);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TmsSAXXMLReader.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TmsSAXXMLReader.GetDefaultInterface: IVBSAXXMLReader;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TmsSAXXMLReader.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TmsSAXXMLReaderProperties.Create(Self);
{$ENDIF}
end;

destructor TmsSAXXMLReader.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TmsSAXXMLReader.GetServerProperties: TmsSAXXMLReaderProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TmsSAXXMLReader.Get_entityResolver: IVBSAXEntityResolver;
begin
    Result := DefaultInterface.entityResolver;
end;

procedure TmsSAXXMLReader._Set_entityResolver(const oResolver: IVBSAXEntityResolver);
  { Warnung: Die EigenschaftentityResolver hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.entityResolver := oResolver;
end;

function TmsSAXXMLReader.Get_contentHandler: IVBSAXContentHandler;
begin
    Result := DefaultInterface.contentHandler;
end;

procedure TmsSAXXMLReader._Set_contentHandler(const oHandler: IVBSAXContentHandler);
  { Warnung: Die EigenschaftcontentHandler hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.contentHandler := oHandler;
end;

function TmsSAXXMLReader.Get_dtdHandler: IVBSAXDTDHandler;
begin
    Result := DefaultInterface.dtdHandler;
end;

procedure TmsSAXXMLReader._Set_dtdHandler(const oHandler: IVBSAXDTDHandler);
  { Warnung: Die EigenschaftdtdHandler hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dtdHandler := oHandler;
end;

function TmsSAXXMLReader.Get_errorHandler: IVBSAXErrorHandler;
begin
    Result := DefaultInterface.errorHandler;
end;

procedure TmsSAXXMLReader._Set_errorHandler(const oHandler: IVBSAXErrorHandler);
  { Warnung: Die EigenschafterrorHandler hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.errorHandler := oHandler;
end;

function TmsSAXXMLReader.Get_baseURL: WideString;
begin
    Result := DefaultInterface.baseURL;
end;

procedure TmsSAXXMLReader.Set_baseURL(const strBaseURL: WideString);
  { Warnung: Die EigenschaftbaseURL hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.baseURL := strBaseURL;
end;

function TmsSAXXMLReader.Get_secureBaseURL: WideString;
begin
    Result := DefaultInterface.secureBaseURL;
end;

procedure TmsSAXXMLReader.Set_secureBaseURL(const strSecureBaseURL: WideString);
  { Warnung: Die EigenschaftsecureBaseURL hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.secureBaseURL := strSecureBaseURL;
end;

function TmsSAXXMLReader.getFeature(const strName: WideString): WordBool;
begin
  Result := DefaultInterface.getFeature(strName);
end;

procedure TmsSAXXMLReader.putFeature(const strName: WideString; fValue: WordBool);
begin
  DefaultInterface.putFeature(strName, fValue);
end;

function TmsSAXXMLReader.getProperty(const strName: WideString): OleVariant;
begin
  Result := DefaultInterface.getProperty(strName);
end;

procedure TmsSAXXMLReader.putProperty(const strName: WideString; varValue: OleVariant);
begin
  DefaultInterface.putProperty(strName, varValue);
end;

procedure TmsSAXXMLReader.parse;
begin
  DefaultInterface.parse(EmptyParam);
end;

procedure TmsSAXXMLReader.parse(varInput: OleVariant);
begin
  DefaultInterface.parse(varInput);
end;

procedure TmsSAXXMLReader.parseURL(const strURL: WideString);
begin
  DefaultInterface.parseURL(strURL);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TmsSAXXMLReaderProperties.Create(AServer: TmsSAXXMLReader);
begin
  inherited Create;
  FServer := AServer;
end;

function TmsSAXXMLReaderProperties.GetDefaultInterface: IVBSAXXMLReader;
begin
  Result := FServer.DefaultInterface;
end;

function TmsSAXXMLReaderProperties.Get_entityResolver: IVBSAXEntityResolver;
begin
    Result := DefaultInterface.entityResolver;
end;

procedure TmsSAXXMLReaderProperties._Set_entityResolver(const oResolver: IVBSAXEntityResolver);
  { Warnung: Die EigenschaftentityResolver hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.entityResolver := oResolver;
end;

function TmsSAXXMLReaderProperties.Get_contentHandler: IVBSAXContentHandler;
begin
    Result := DefaultInterface.contentHandler;
end;

procedure TmsSAXXMLReaderProperties._Set_contentHandler(const oHandler: IVBSAXContentHandler);
  { Warnung: Die EigenschaftcontentHandler hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.contentHandler := oHandler;
end;

function TmsSAXXMLReaderProperties.Get_dtdHandler: IVBSAXDTDHandler;
begin
    Result := DefaultInterface.dtdHandler;
end;

procedure TmsSAXXMLReaderProperties._Set_dtdHandler(const oHandler: IVBSAXDTDHandler);
  { Warnung: Die EigenschaftdtdHandler hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dtdHandler := oHandler;
end;

function TmsSAXXMLReaderProperties.Get_errorHandler: IVBSAXErrorHandler;
begin
    Result := DefaultInterface.errorHandler;
end;

procedure TmsSAXXMLReaderProperties._Set_errorHandler(const oHandler: IVBSAXErrorHandler);
  { Warnung: Die EigenschafterrorHandler hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.errorHandler := oHandler;
end;

function TmsSAXXMLReaderProperties.Get_baseURL: WideString;
begin
    Result := DefaultInterface.baseURL;
end;

procedure TmsSAXXMLReaderProperties.Set_baseURL(const strBaseURL: WideString);
  { Warnung: Die EigenschaftbaseURL hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.baseURL := strBaseURL;
end;

function TmsSAXXMLReaderProperties.Get_secureBaseURL: WideString;
begin
    Result := DefaultInterface.secureBaseURL;
end;

procedure TmsSAXXMLReaderProperties.Set_secureBaseURL(const strSecureBaseURL: WideString);
  { Warnung: Die EigenschaftsecureBaseURL hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.secureBaseURL := strSecureBaseURL;
end;

{$ENDIF}

procedure TmsSAXXMLReader30.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{3124C396-FB13-4836-A6AD-1317F1713688}';
    IntfIID:   '{8C033CAA-6CD6-4F73-B728-4531AF74945F}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TmsSAXXMLReader30.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IVBSAXXMLReader;
  end;
end;

procedure TmsSAXXMLReader30.ConnectTo(svrIntf: IVBSAXXMLReader);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TmsSAXXMLReader30.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TmsSAXXMLReader30.GetDefaultInterface: IVBSAXXMLReader;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TmsSAXXMLReader30.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TmsSAXXMLReader30Properties.Create(Self);
{$ENDIF}
end;

destructor TmsSAXXMLReader30.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TmsSAXXMLReader30.GetServerProperties: TmsSAXXMLReader30Properties;
begin
  Result := FProps;
end;
{$ENDIF}

function TmsSAXXMLReader30.Get_entityResolver: IVBSAXEntityResolver;
begin
    Result := DefaultInterface.entityResolver;
end;

procedure TmsSAXXMLReader30._Set_entityResolver(const oResolver: IVBSAXEntityResolver);
  { Warnung: Die EigenschaftentityResolver hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.entityResolver := oResolver;
end;

function TmsSAXXMLReader30.Get_contentHandler: IVBSAXContentHandler;
begin
    Result := DefaultInterface.contentHandler;
end;

procedure TmsSAXXMLReader30._Set_contentHandler(const oHandler: IVBSAXContentHandler);
  { Warnung: Die EigenschaftcontentHandler hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.contentHandler := oHandler;
end;

function TmsSAXXMLReader30.Get_dtdHandler: IVBSAXDTDHandler;
begin
    Result := DefaultInterface.dtdHandler;
end;

procedure TmsSAXXMLReader30._Set_dtdHandler(const oHandler: IVBSAXDTDHandler);
  { Warnung: Die EigenschaftdtdHandler hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dtdHandler := oHandler;
end;

function TmsSAXXMLReader30.Get_errorHandler: IVBSAXErrorHandler;
begin
    Result := DefaultInterface.errorHandler;
end;

procedure TmsSAXXMLReader30._Set_errorHandler(const oHandler: IVBSAXErrorHandler);
  { Warnung: Die EigenschafterrorHandler hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.errorHandler := oHandler;
end;

function TmsSAXXMLReader30.Get_baseURL: WideString;
begin
    Result := DefaultInterface.baseURL;
end;

procedure TmsSAXXMLReader30.Set_baseURL(const strBaseURL: WideString);
  { Warnung: Die EigenschaftbaseURL hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.baseURL := strBaseURL;
end;

function TmsSAXXMLReader30.Get_secureBaseURL: WideString;
begin
    Result := DefaultInterface.secureBaseURL;
end;

procedure TmsSAXXMLReader30.Set_secureBaseURL(const strSecureBaseURL: WideString);
  { Warnung: Die EigenschaftsecureBaseURL hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.secureBaseURL := strSecureBaseURL;
end;

function TmsSAXXMLReader30.getFeature(const strName: WideString): WordBool;
begin
  Result := DefaultInterface.getFeature(strName);
end;

procedure TmsSAXXMLReader30.putFeature(const strName: WideString; fValue: WordBool);
begin
  DefaultInterface.putFeature(strName, fValue);
end;

function TmsSAXXMLReader30.getProperty(const strName: WideString): OleVariant;
begin
  Result := DefaultInterface.getProperty(strName);
end;

procedure TmsSAXXMLReader30.putProperty(const strName: WideString; varValue: OleVariant);
begin
  DefaultInterface.putProperty(strName, varValue);
end;

procedure TmsSAXXMLReader30.parse;
begin
  DefaultInterface.parse(EmptyParam);
end;

procedure TmsSAXXMLReader30.parse(varInput: OleVariant);
begin
  DefaultInterface.parse(varInput);
end;

procedure TmsSAXXMLReader30.parseURL(const strURL: WideString);
begin
  DefaultInterface.parseURL(strURL);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TmsSAXXMLReader30Properties.Create(AServer: TmsSAXXMLReader30);
begin
  inherited Create;
  FServer := AServer;
end;

function TmsSAXXMLReader30Properties.GetDefaultInterface: IVBSAXXMLReader;
begin
  Result := FServer.DefaultInterface;
end;

function TmsSAXXMLReader30Properties.Get_entityResolver: IVBSAXEntityResolver;
begin
    Result := DefaultInterface.entityResolver;
end;

procedure TmsSAXXMLReader30Properties._Set_entityResolver(const oResolver: IVBSAXEntityResolver);
  { Warnung: Die EigenschaftentityResolver hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.entityResolver := oResolver;
end;

function TmsSAXXMLReader30Properties.Get_contentHandler: IVBSAXContentHandler;
begin
    Result := DefaultInterface.contentHandler;
end;

procedure TmsSAXXMLReader30Properties._Set_contentHandler(const oHandler: IVBSAXContentHandler);
  { Warnung: Die EigenschaftcontentHandler hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.contentHandler := oHandler;
end;

function TmsSAXXMLReader30Properties.Get_dtdHandler: IVBSAXDTDHandler;
begin
    Result := DefaultInterface.dtdHandler;
end;

procedure TmsSAXXMLReader30Properties._Set_dtdHandler(const oHandler: IVBSAXDTDHandler);
  { Warnung: Die EigenschaftdtdHandler hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dtdHandler := oHandler;
end;

function TmsSAXXMLReader30Properties.Get_errorHandler: IVBSAXErrorHandler;
begin
    Result := DefaultInterface.errorHandler;
end;

procedure TmsSAXXMLReader30Properties._Set_errorHandler(const oHandler: IVBSAXErrorHandler);
  { Warnung: Die EigenschafterrorHandler hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.errorHandler := oHandler;
end;

function TmsSAXXMLReader30Properties.Get_baseURL: WideString;
begin
    Result := DefaultInterface.baseURL;
end;

procedure TmsSAXXMLReader30Properties.Set_baseURL(const strBaseURL: WideString);
  { Warnung: Die EigenschaftbaseURL hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.baseURL := strBaseURL;
end;

function TmsSAXXMLReader30Properties.Get_secureBaseURL: WideString;
begin
    Result := DefaultInterface.secureBaseURL;
end;

procedure TmsSAXXMLReader30Properties.Set_secureBaseURL(const strSecureBaseURL: WideString);
  { Warnung: Die EigenschaftsecureBaseURL hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.secureBaseURL := strSecureBaseURL;
end;

{$ENDIF}

procedure TSAXXMLReader40.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{7C6E29BC-8B8B-4C3D-859E-AF6CD158BE0F}';
    IntfIID:   '{8C033CAA-6CD6-4F73-B728-4531AF74945F}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TSAXXMLReader40.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IVBSAXXMLReader;
  end;
end;

procedure TSAXXMLReader40.ConnectTo(svrIntf: IVBSAXXMLReader);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TSAXXMLReader40.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TSAXXMLReader40.GetDefaultInterface: IVBSAXXMLReader;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TSAXXMLReader40.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TSAXXMLReader40Properties.Create(Self);
{$ENDIF}
end;

destructor TSAXXMLReader40.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TSAXXMLReader40.GetServerProperties: TSAXXMLReader40Properties;
begin
  Result := FProps;
end;
{$ENDIF}

function TSAXXMLReader40.Get_entityResolver: IVBSAXEntityResolver;
begin
    Result := DefaultInterface.entityResolver;
end;

procedure TSAXXMLReader40._Set_entityResolver(const oResolver: IVBSAXEntityResolver);
  { Warnung: Die EigenschaftentityResolver hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.entityResolver := oResolver;
end;

function TSAXXMLReader40.Get_contentHandler: IVBSAXContentHandler;
begin
    Result := DefaultInterface.contentHandler;
end;

procedure TSAXXMLReader40._Set_contentHandler(const oHandler: IVBSAXContentHandler);
  { Warnung: Die EigenschaftcontentHandler hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.contentHandler := oHandler;
end;

function TSAXXMLReader40.Get_dtdHandler: IVBSAXDTDHandler;
begin
    Result := DefaultInterface.dtdHandler;
end;

procedure TSAXXMLReader40._Set_dtdHandler(const oHandler: IVBSAXDTDHandler);
  { Warnung: Die EigenschaftdtdHandler hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dtdHandler := oHandler;
end;

function TSAXXMLReader40.Get_errorHandler: IVBSAXErrorHandler;
begin
    Result := DefaultInterface.errorHandler;
end;

procedure TSAXXMLReader40._Set_errorHandler(const oHandler: IVBSAXErrorHandler);
  { Warnung: Die EigenschafterrorHandler hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.errorHandler := oHandler;
end;

function TSAXXMLReader40.Get_baseURL: WideString;
begin
    Result := DefaultInterface.baseURL;
end;

procedure TSAXXMLReader40.Set_baseURL(const strBaseURL: WideString);
  { Warnung: Die EigenschaftbaseURL hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.baseURL := strBaseURL;
end;

function TSAXXMLReader40.Get_secureBaseURL: WideString;
begin
    Result := DefaultInterface.secureBaseURL;
end;

procedure TSAXXMLReader40.Set_secureBaseURL(const strSecureBaseURL: WideString);
  { Warnung: Die EigenschaftsecureBaseURL hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.secureBaseURL := strSecureBaseURL;
end;

function TSAXXMLReader40.getFeature(const strName: WideString): WordBool;
begin
  Result := DefaultInterface.getFeature(strName);
end;

procedure TSAXXMLReader40.putFeature(const strName: WideString; fValue: WordBool);
begin
  DefaultInterface.putFeature(strName, fValue);
end;

function TSAXXMLReader40.getProperty(const strName: WideString): OleVariant;
begin
  Result := DefaultInterface.getProperty(strName);
end;

procedure TSAXXMLReader40.putProperty(const strName: WideString; varValue: OleVariant);
begin
  DefaultInterface.putProperty(strName, varValue);
end;

procedure TSAXXMLReader40.parse;
begin
  DefaultInterface.parse(EmptyParam);
end;

procedure TSAXXMLReader40.parse(varInput: OleVariant);
begin
  DefaultInterface.parse(varInput);
end;

procedure TSAXXMLReader40.parseURL(const strURL: WideString);
begin
  DefaultInterface.parseURL(strURL);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TSAXXMLReader40Properties.Create(AServer: TSAXXMLReader40);
begin
  inherited Create;
  FServer := AServer;
end;

function TSAXXMLReader40Properties.GetDefaultInterface: IVBSAXXMLReader;
begin
  Result := FServer.DefaultInterface;
end;

function TSAXXMLReader40Properties.Get_entityResolver: IVBSAXEntityResolver;
begin
    Result := DefaultInterface.entityResolver;
end;

procedure TSAXXMLReader40Properties._Set_entityResolver(const oResolver: IVBSAXEntityResolver);
  { Warnung: Die EigenschaftentityResolver hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.entityResolver := oResolver;
end;

function TSAXXMLReader40Properties.Get_contentHandler: IVBSAXContentHandler;
begin
    Result := DefaultInterface.contentHandler;
end;

procedure TSAXXMLReader40Properties._Set_contentHandler(const oHandler: IVBSAXContentHandler);
  { Warnung: Die EigenschaftcontentHandler hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.contentHandler := oHandler;
end;

function TSAXXMLReader40Properties.Get_dtdHandler: IVBSAXDTDHandler;
begin
    Result := DefaultInterface.dtdHandler;
end;

procedure TSAXXMLReader40Properties._Set_dtdHandler(const oHandler: IVBSAXDTDHandler);
  { Warnung: Die EigenschaftdtdHandler hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dtdHandler := oHandler;
end;

function TSAXXMLReader40Properties.Get_errorHandler: IVBSAXErrorHandler;
begin
    Result := DefaultInterface.errorHandler;
end;

procedure TSAXXMLReader40Properties._Set_errorHandler(const oHandler: IVBSAXErrorHandler);
  { Warnung: Die EigenschafterrorHandler hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.errorHandler := oHandler;
end;

function TSAXXMLReader40Properties.Get_baseURL: WideString;
begin
    Result := DefaultInterface.baseURL;
end;

procedure TSAXXMLReader40Properties.Set_baseURL(const strBaseURL: WideString);
  { Warnung: Die EigenschaftbaseURL hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.baseURL := strBaseURL;
end;

function TSAXXMLReader40Properties.Get_secureBaseURL: WideString;
begin
    Result := DefaultInterface.secureBaseURL;
end;

procedure TSAXXMLReader40Properties.Set_secureBaseURL(const strSecureBaseURL: WideString);
  { Warnung: Die EigenschaftsecureBaseURL hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.secureBaseURL := strSecureBaseURL;
end;

{$ENDIF}

procedure TSAXXMLReader60.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{88D96A0C-F192-11D4-A65F-0040963251E5}';
    IntfIID:   '{8C033CAA-6CD6-4F73-B728-4531AF74945F}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TSAXXMLReader60.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IVBSAXXMLReader;
  end;
end;

procedure TSAXXMLReader60.ConnectTo(svrIntf: IVBSAXXMLReader);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TSAXXMLReader60.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TSAXXMLReader60.GetDefaultInterface: IVBSAXXMLReader;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TSAXXMLReader60.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TSAXXMLReader60Properties.Create(Self);
{$ENDIF}
end;

destructor TSAXXMLReader60.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TSAXXMLReader60.GetServerProperties: TSAXXMLReader60Properties;
begin
  Result := FProps;
end;
{$ENDIF}

function TSAXXMLReader60.Get_entityResolver: IVBSAXEntityResolver;
begin
    Result := DefaultInterface.entityResolver;
end;

procedure TSAXXMLReader60._Set_entityResolver(const oResolver: IVBSAXEntityResolver);
  { Warnung: Die EigenschaftentityResolver hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.entityResolver := oResolver;
end;

function TSAXXMLReader60.Get_contentHandler: IVBSAXContentHandler;
begin
    Result := DefaultInterface.contentHandler;
end;

procedure TSAXXMLReader60._Set_contentHandler(const oHandler: IVBSAXContentHandler);
  { Warnung: Die EigenschaftcontentHandler hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.contentHandler := oHandler;
end;

function TSAXXMLReader60.Get_dtdHandler: IVBSAXDTDHandler;
begin
    Result := DefaultInterface.dtdHandler;
end;

procedure TSAXXMLReader60._Set_dtdHandler(const oHandler: IVBSAXDTDHandler);
  { Warnung: Die EigenschaftdtdHandler hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dtdHandler := oHandler;
end;

function TSAXXMLReader60.Get_errorHandler: IVBSAXErrorHandler;
begin
    Result := DefaultInterface.errorHandler;
end;

procedure TSAXXMLReader60._Set_errorHandler(const oHandler: IVBSAXErrorHandler);
  { Warnung: Die EigenschafterrorHandler hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.errorHandler := oHandler;
end;

function TSAXXMLReader60.Get_baseURL: WideString;
begin
    Result := DefaultInterface.baseURL;
end;

procedure TSAXXMLReader60.Set_baseURL(const strBaseURL: WideString);
  { Warnung: Die EigenschaftbaseURL hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.baseURL := strBaseURL;
end;

function TSAXXMLReader60.Get_secureBaseURL: WideString;
begin
    Result := DefaultInterface.secureBaseURL;
end;

procedure TSAXXMLReader60.Set_secureBaseURL(const strSecureBaseURL: WideString);
  { Warnung: Die EigenschaftsecureBaseURL hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.secureBaseURL := strSecureBaseURL;
end;

function TSAXXMLReader60.getFeature(const strName: WideString): WordBool;
begin
  Result := DefaultInterface.getFeature(strName);
end;

procedure TSAXXMLReader60.putFeature(const strName: WideString; fValue: WordBool);
begin
  DefaultInterface.putFeature(strName, fValue);
end;

function TSAXXMLReader60.getProperty(const strName: WideString): OleVariant;
begin
  Result := DefaultInterface.getProperty(strName);
end;

procedure TSAXXMLReader60.putProperty(const strName: WideString; varValue: OleVariant);
begin
  DefaultInterface.putProperty(strName, varValue);
end;

procedure TSAXXMLReader60.parse;
begin
  DefaultInterface.parse(EmptyParam);
end;

procedure TSAXXMLReader60.parse(varInput: OleVariant);
begin
  DefaultInterface.parse(varInput);
end;

procedure TSAXXMLReader60.parseURL(const strURL: WideString);
begin
  DefaultInterface.parseURL(strURL);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TSAXXMLReader60Properties.Create(AServer: TSAXXMLReader60);
begin
  inherited Create;
  FServer := AServer;
end;

function TSAXXMLReader60Properties.GetDefaultInterface: IVBSAXXMLReader;
begin
  Result := FServer.DefaultInterface;
end;

function TSAXXMLReader60Properties.Get_entityResolver: IVBSAXEntityResolver;
begin
    Result := DefaultInterface.entityResolver;
end;

procedure TSAXXMLReader60Properties._Set_entityResolver(const oResolver: IVBSAXEntityResolver);
  { Warnung: Die EigenschaftentityResolver hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.entityResolver := oResolver;
end;

function TSAXXMLReader60Properties.Get_contentHandler: IVBSAXContentHandler;
begin
    Result := DefaultInterface.contentHandler;
end;

procedure TSAXXMLReader60Properties._Set_contentHandler(const oHandler: IVBSAXContentHandler);
  { Warnung: Die EigenschaftcontentHandler hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.contentHandler := oHandler;
end;

function TSAXXMLReader60Properties.Get_dtdHandler: IVBSAXDTDHandler;
begin
    Result := DefaultInterface.dtdHandler;
end;

procedure TSAXXMLReader60Properties._Set_dtdHandler(const oHandler: IVBSAXDTDHandler);
  { Warnung: Die EigenschaftdtdHandler hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dtdHandler := oHandler;
end;

function TSAXXMLReader60Properties.Get_errorHandler: IVBSAXErrorHandler;
begin
    Result := DefaultInterface.errorHandler;
end;

procedure TSAXXMLReader60Properties._Set_errorHandler(const oHandler: IVBSAXErrorHandler);
  { Warnung: Die EigenschafterrorHandler hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.errorHandler := oHandler;
end;

function TSAXXMLReader60Properties.Get_baseURL: WideString;
begin
    Result := DefaultInterface.baseURL;
end;

procedure TSAXXMLReader60Properties.Set_baseURL(const strBaseURL: WideString);
  { Warnung: Die EigenschaftbaseURL hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.baseURL := strBaseURL;
end;

function TSAXXMLReader60Properties.Get_secureBaseURL: WideString;
begin
    Result := DefaultInterface.secureBaseURL;
end;

procedure TSAXXMLReader60Properties.Set_secureBaseURL(const strSecureBaseURL: WideString);
  { Warnung: Die EigenschaftsecureBaseURL hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.secureBaseURL := strSecureBaseURL;
end;

{$ENDIF}

procedure TmsMXXMLWriter.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{FC220AD8-A72A-4EE8-926E-0B7AD152A020}';
    IntfIID:   '{4D7FF4BA-1565-4EA8-94E1-6E724A46F98D}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TmsMXXMLWriter.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IMXWriter;
  end;
end;

procedure TmsMXXMLWriter.ConnectTo(svrIntf: IMXWriter);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TmsMXXMLWriter.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TmsMXXMLWriter.GetDefaultInterface: IMXWriter;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TmsMXXMLWriter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TmsMXXMLWriterProperties.Create(Self);
{$ENDIF}
end;

destructor TmsMXXMLWriter.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TmsMXXMLWriter.GetServerProperties: TmsMXXMLWriterProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TmsMXXMLWriter.Set_output(varDestination: OleVariant);
begin
  DefaultInterface.Set_output(varDestination);
end;

function TmsMXXMLWriter.Get_output: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.output;
end;

procedure TmsMXXMLWriter.Set_encoding(const strEncoding: WideString);
  { Warnung: Die Eigenschaftencoding hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.encoding := strEncoding;
end;

function TmsMXXMLWriter.Get_encoding: WideString;
begin
    Result := DefaultInterface.encoding;
end;

procedure TmsMXXMLWriter.Set_byteOrderMark(fWriteByteOrderMark: WordBool);
begin
  DefaultInterface.Set_byteOrderMark(fWriteByteOrderMark);
end;

function TmsMXXMLWriter.Get_byteOrderMark: WordBool;
begin
    Result := DefaultInterface.byteOrderMark;
end;

procedure TmsMXXMLWriter.Set_indent(fIndentMode: WordBool);
begin
  DefaultInterface.Set_indent(fIndentMode);
end;

function TmsMXXMLWriter.Get_indent: WordBool;
begin
    Result := DefaultInterface.indent;
end;

procedure TmsMXXMLWriter.Set_standalone(fValue: WordBool);
begin
  DefaultInterface.Set_standalone(fValue);
end;

function TmsMXXMLWriter.Get_standalone: WordBool;
begin
    Result := DefaultInterface.standalone;
end;

procedure TmsMXXMLWriter.Set_omitXMLDeclaration(fValue: WordBool);
begin
  DefaultInterface.Set_omitXMLDeclaration(fValue);
end;

function TmsMXXMLWriter.Get_omitXMLDeclaration: WordBool;
begin
    Result := DefaultInterface.omitXMLDeclaration;
end;

procedure TmsMXXMLWriter.Set_version(const strVersion: WideString);
  { Warnung: Die Eigenschaftversion hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.version := strVersion;
end;

function TmsMXXMLWriter.Get_version: WideString;
begin
    Result := DefaultInterface.version;
end;

procedure TmsMXXMLWriter.Set_disableOutputEscaping(fValue: WordBool);
begin
  DefaultInterface.Set_disableOutputEscaping(fValue);
end;

function TmsMXXMLWriter.Get_disableOutputEscaping: WordBool;
begin
    Result := DefaultInterface.disableOutputEscaping;
end;

procedure TmsMXXMLWriter.flush;
begin
  DefaultInterface.flush;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TmsMXXMLWriterProperties.Create(AServer: TmsMXXMLWriter);
begin
  inherited Create;
  FServer := AServer;
end;

function TmsMXXMLWriterProperties.GetDefaultInterface: IMXWriter;
begin
  Result := FServer.DefaultInterface;
end;

procedure TmsMXXMLWriterProperties.Set_output(varDestination: OleVariant);
begin
  DefaultInterface.Set_output(varDestination);
end;

function TmsMXXMLWriterProperties.Get_output: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.output;
end;

procedure TmsMXXMLWriterProperties.Set_encoding(const strEncoding: WideString);
  { Warnung: Die Eigenschaftencoding hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.encoding := strEncoding;
end;

function TmsMXXMLWriterProperties.Get_encoding: WideString;
begin
    Result := DefaultInterface.encoding;
end;

procedure TmsMXXMLWriterProperties.Set_byteOrderMark(fWriteByteOrderMark: WordBool);
begin
  DefaultInterface.Set_byteOrderMark(fWriteByteOrderMark);
end;

function TmsMXXMLWriterProperties.Get_byteOrderMark: WordBool;
begin
    Result := DefaultInterface.byteOrderMark;
end;

procedure TmsMXXMLWriterProperties.Set_indent(fIndentMode: WordBool);
begin
  DefaultInterface.Set_indent(fIndentMode);
end;

function TmsMXXMLWriterProperties.Get_indent: WordBool;
begin
    Result := DefaultInterface.indent;
end;

procedure TmsMXXMLWriterProperties.Set_standalone(fValue: WordBool);
begin
  DefaultInterface.Set_standalone(fValue);
end;

function TmsMXXMLWriterProperties.Get_standalone: WordBool;
begin
    Result := DefaultInterface.standalone;
end;

procedure TmsMXXMLWriterProperties.Set_omitXMLDeclaration(fValue: WordBool);
begin
  DefaultInterface.Set_omitXMLDeclaration(fValue);
end;

function TmsMXXMLWriterProperties.Get_omitXMLDeclaration: WordBool;
begin
    Result := DefaultInterface.omitXMLDeclaration;
end;

procedure TmsMXXMLWriterProperties.Set_version(const strVersion: WideString);
  { Warnung: Die Eigenschaftversion hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.version := strVersion;
end;

function TmsMXXMLWriterProperties.Get_version: WideString;
begin
    Result := DefaultInterface.version;
end;

procedure TmsMXXMLWriterProperties.Set_disableOutputEscaping(fValue: WordBool);
begin
  DefaultInterface.Set_disableOutputEscaping(fValue);
end;

function TmsMXXMLWriterProperties.Get_disableOutputEscaping: WordBool;
begin
    Result := DefaultInterface.disableOutputEscaping;
end;

{$ENDIF}

procedure TmsMXXMLWriter30.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{3D813DFE-6C91-4A4E-8F41-04346A841D9C}';
    IntfIID:   '{4D7FF4BA-1565-4EA8-94E1-6E724A46F98D}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TmsMXXMLWriter30.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IMXWriter;
  end;
end;

procedure TmsMXXMLWriter30.ConnectTo(svrIntf: IMXWriter);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TmsMXXMLWriter30.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TmsMXXMLWriter30.GetDefaultInterface: IMXWriter;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TmsMXXMLWriter30.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TmsMXXMLWriter30Properties.Create(Self);
{$ENDIF}
end;

destructor TmsMXXMLWriter30.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TmsMXXMLWriter30.GetServerProperties: TmsMXXMLWriter30Properties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TmsMXXMLWriter30.Set_output(varDestination: OleVariant);
begin
  DefaultInterface.Set_output(varDestination);
end;

function TmsMXXMLWriter30.Get_output: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.output;
end;

procedure TmsMXXMLWriter30.Set_encoding(const strEncoding: WideString);
  { Warnung: Die Eigenschaftencoding hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.encoding := strEncoding;
end;

function TmsMXXMLWriter30.Get_encoding: WideString;
begin
    Result := DefaultInterface.encoding;
end;

procedure TmsMXXMLWriter30.Set_byteOrderMark(fWriteByteOrderMark: WordBool);
begin
  DefaultInterface.Set_byteOrderMark(fWriteByteOrderMark);
end;

function TmsMXXMLWriter30.Get_byteOrderMark: WordBool;
begin
    Result := DefaultInterface.byteOrderMark;
end;

procedure TmsMXXMLWriter30.Set_indent(fIndentMode: WordBool);
begin
  DefaultInterface.Set_indent(fIndentMode);
end;

function TmsMXXMLWriter30.Get_indent: WordBool;
begin
    Result := DefaultInterface.indent;
end;

procedure TmsMXXMLWriter30.Set_standalone(fValue: WordBool);
begin
  DefaultInterface.Set_standalone(fValue);
end;

function TmsMXXMLWriter30.Get_standalone: WordBool;
begin
    Result := DefaultInterface.standalone;
end;

procedure TmsMXXMLWriter30.Set_omitXMLDeclaration(fValue: WordBool);
begin
  DefaultInterface.Set_omitXMLDeclaration(fValue);
end;

function TmsMXXMLWriter30.Get_omitXMLDeclaration: WordBool;
begin
    Result := DefaultInterface.omitXMLDeclaration;
end;

procedure TmsMXXMLWriter30.Set_version(const strVersion: WideString);
  { Warnung: Die Eigenschaftversion hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.version := strVersion;
end;

function TmsMXXMLWriter30.Get_version: WideString;
begin
    Result := DefaultInterface.version;
end;

procedure TmsMXXMLWriter30.Set_disableOutputEscaping(fValue: WordBool);
begin
  DefaultInterface.Set_disableOutputEscaping(fValue);
end;

function TmsMXXMLWriter30.Get_disableOutputEscaping: WordBool;
begin
    Result := DefaultInterface.disableOutputEscaping;
end;

procedure TmsMXXMLWriter30.flush;
begin
  DefaultInterface.flush;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TmsMXXMLWriter30Properties.Create(AServer: TmsMXXMLWriter30);
begin
  inherited Create;
  FServer := AServer;
end;

function TmsMXXMLWriter30Properties.GetDefaultInterface: IMXWriter;
begin
  Result := FServer.DefaultInterface;
end;

procedure TmsMXXMLWriter30Properties.Set_output(varDestination: OleVariant);
begin
  DefaultInterface.Set_output(varDestination);
end;

function TmsMXXMLWriter30Properties.Get_output: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.output;
end;

procedure TmsMXXMLWriter30Properties.Set_encoding(const strEncoding: WideString);
  { Warnung: Die Eigenschaftencoding hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.encoding := strEncoding;
end;

function TmsMXXMLWriter30Properties.Get_encoding: WideString;
begin
    Result := DefaultInterface.encoding;
end;

procedure TmsMXXMLWriter30Properties.Set_byteOrderMark(fWriteByteOrderMark: WordBool);
begin
  DefaultInterface.Set_byteOrderMark(fWriteByteOrderMark);
end;

function TmsMXXMLWriter30Properties.Get_byteOrderMark: WordBool;
begin
    Result := DefaultInterface.byteOrderMark;
end;

procedure TmsMXXMLWriter30Properties.Set_indent(fIndentMode: WordBool);
begin
  DefaultInterface.Set_indent(fIndentMode);
end;

function TmsMXXMLWriter30Properties.Get_indent: WordBool;
begin
    Result := DefaultInterface.indent;
end;

procedure TmsMXXMLWriter30Properties.Set_standalone(fValue: WordBool);
begin
  DefaultInterface.Set_standalone(fValue);
end;

function TmsMXXMLWriter30Properties.Get_standalone: WordBool;
begin
    Result := DefaultInterface.standalone;
end;

procedure TmsMXXMLWriter30Properties.Set_omitXMLDeclaration(fValue: WordBool);
begin
  DefaultInterface.Set_omitXMLDeclaration(fValue);
end;

function TmsMXXMLWriter30Properties.Get_omitXMLDeclaration: WordBool;
begin
    Result := DefaultInterface.omitXMLDeclaration;
end;

procedure TmsMXXMLWriter30Properties.Set_version(const strVersion: WideString);
  { Warnung: Die Eigenschaftversion hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.version := strVersion;
end;

function TmsMXXMLWriter30Properties.Get_version: WideString;
begin
    Result := DefaultInterface.version;
end;

procedure TmsMXXMLWriter30Properties.Set_disableOutputEscaping(fValue: WordBool);
begin
  DefaultInterface.Set_disableOutputEscaping(fValue);
end;

function TmsMXXMLWriter30Properties.Get_disableOutputEscaping: WordBool;
begin
    Result := DefaultInterface.disableOutputEscaping;
end;

{$ENDIF}

procedure TMXXMLWriter40.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{88D969C8-F192-11D4-A65F-0040963251E5}';
    IntfIID:   '{4D7FF4BA-1565-4EA8-94E1-6E724A46F98D}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMXXMLWriter40.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IMXWriter;
  end;
end;

procedure TMXXMLWriter40.ConnectTo(svrIntf: IMXWriter);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMXXMLWriter40.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMXXMLWriter40.GetDefaultInterface: IMXWriter;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TMXXMLWriter40.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMXXMLWriter40Properties.Create(Self);
{$ENDIF}
end;

destructor TMXXMLWriter40.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMXXMLWriter40.GetServerProperties: TMXXMLWriter40Properties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TMXXMLWriter40.Set_output(varDestination: OleVariant);
begin
  DefaultInterface.Set_output(varDestination);
end;

function TMXXMLWriter40.Get_output: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.output;
end;

procedure TMXXMLWriter40.Set_encoding(const strEncoding: WideString);
  { Warnung: Die Eigenschaftencoding hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.encoding := strEncoding;
end;

function TMXXMLWriter40.Get_encoding: WideString;
begin
    Result := DefaultInterface.encoding;
end;

procedure TMXXMLWriter40.Set_byteOrderMark(fWriteByteOrderMark: WordBool);
begin
  DefaultInterface.Set_byteOrderMark(fWriteByteOrderMark);
end;

function TMXXMLWriter40.Get_byteOrderMark: WordBool;
begin
    Result := DefaultInterface.byteOrderMark;
end;

procedure TMXXMLWriter40.Set_indent(fIndentMode: WordBool);
begin
  DefaultInterface.Set_indent(fIndentMode);
end;

function TMXXMLWriter40.Get_indent: WordBool;
begin
    Result := DefaultInterface.indent;
end;

procedure TMXXMLWriter40.Set_standalone(fValue: WordBool);
begin
  DefaultInterface.Set_standalone(fValue);
end;

function TMXXMLWriter40.Get_standalone: WordBool;
begin
    Result := DefaultInterface.standalone;
end;

procedure TMXXMLWriter40.Set_omitXMLDeclaration(fValue: WordBool);
begin
  DefaultInterface.Set_omitXMLDeclaration(fValue);
end;

function TMXXMLWriter40.Get_omitXMLDeclaration: WordBool;
begin
    Result := DefaultInterface.omitXMLDeclaration;
end;

procedure TMXXMLWriter40.Set_version(const strVersion: WideString);
  { Warnung: Die Eigenschaftversion hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.version := strVersion;
end;

function TMXXMLWriter40.Get_version: WideString;
begin
    Result := DefaultInterface.version;
end;

procedure TMXXMLWriter40.Set_disableOutputEscaping(fValue: WordBool);
begin
  DefaultInterface.Set_disableOutputEscaping(fValue);
end;

function TMXXMLWriter40.Get_disableOutputEscaping: WordBool;
begin
    Result := DefaultInterface.disableOutputEscaping;
end;

procedure TMXXMLWriter40.flush;
begin
  DefaultInterface.flush;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMXXMLWriter40Properties.Create(AServer: TMXXMLWriter40);
begin
  inherited Create;
  FServer := AServer;
end;

function TMXXMLWriter40Properties.GetDefaultInterface: IMXWriter;
begin
  Result := FServer.DefaultInterface;
end;

procedure TMXXMLWriter40Properties.Set_output(varDestination: OleVariant);
begin
  DefaultInterface.Set_output(varDestination);
end;

function TMXXMLWriter40Properties.Get_output: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.output;
end;

procedure TMXXMLWriter40Properties.Set_encoding(const strEncoding: WideString);
  { Warnung: Die Eigenschaftencoding hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.encoding := strEncoding;
end;

function TMXXMLWriter40Properties.Get_encoding: WideString;
begin
    Result := DefaultInterface.encoding;
end;

procedure TMXXMLWriter40Properties.Set_byteOrderMark(fWriteByteOrderMark: WordBool);
begin
  DefaultInterface.Set_byteOrderMark(fWriteByteOrderMark);
end;

function TMXXMLWriter40Properties.Get_byteOrderMark: WordBool;
begin
    Result := DefaultInterface.byteOrderMark;
end;

procedure TMXXMLWriter40Properties.Set_indent(fIndentMode: WordBool);
begin
  DefaultInterface.Set_indent(fIndentMode);
end;

function TMXXMLWriter40Properties.Get_indent: WordBool;
begin
    Result := DefaultInterface.indent;
end;

procedure TMXXMLWriter40Properties.Set_standalone(fValue: WordBool);
begin
  DefaultInterface.Set_standalone(fValue);
end;

function TMXXMLWriter40Properties.Get_standalone: WordBool;
begin
    Result := DefaultInterface.standalone;
end;

procedure TMXXMLWriter40Properties.Set_omitXMLDeclaration(fValue: WordBool);
begin
  DefaultInterface.Set_omitXMLDeclaration(fValue);
end;

function TMXXMLWriter40Properties.Get_omitXMLDeclaration: WordBool;
begin
    Result := DefaultInterface.omitXMLDeclaration;
end;

procedure TMXXMLWriter40Properties.Set_version(const strVersion: WideString);
  { Warnung: Die Eigenschaftversion hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.version := strVersion;
end;

function TMXXMLWriter40Properties.Get_version: WideString;
begin
    Result := DefaultInterface.version;
end;

procedure TMXXMLWriter40Properties.Set_disableOutputEscaping(fValue: WordBool);
begin
  DefaultInterface.Set_disableOutputEscaping(fValue);
end;

function TMXXMLWriter40Properties.Get_disableOutputEscaping: WordBool;
begin
    Result := DefaultInterface.disableOutputEscaping;
end;

{$ENDIF}

procedure TMXXMLWriter60.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{88D96A0F-F192-11D4-A65F-0040963251E5}';
    IntfIID:   '{4D7FF4BA-1565-4EA8-94E1-6E724A46F98D}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMXXMLWriter60.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IMXWriter;
  end;
end;

procedure TMXXMLWriter60.ConnectTo(svrIntf: IMXWriter);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMXXMLWriter60.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMXXMLWriter60.GetDefaultInterface: IMXWriter;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TMXXMLWriter60.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMXXMLWriter60Properties.Create(Self);
{$ENDIF}
end;

destructor TMXXMLWriter60.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMXXMLWriter60.GetServerProperties: TMXXMLWriter60Properties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TMXXMLWriter60.Set_output(varDestination: OleVariant);
begin
  DefaultInterface.Set_output(varDestination);
end;

function TMXXMLWriter60.Get_output: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.output;
end;

procedure TMXXMLWriter60.Set_encoding(const strEncoding: WideString);
  { Warnung: Die Eigenschaftencoding hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.encoding := strEncoding;
end;

function TMXXMLWriter60.Get_encoding: WideString;
begin
    Result := DefaultInterface.encoding;
end;

procedure TMXXMLWriter60.Set_byteOrderMark(fWriteByteOrderMark: WordBool);
begin
  DefaultInterface.Set_byteOrderMark(fWriteByteOrderMark);
end;

function TMXXMLWriter60.Get_byteOrderMark: WordBool;
begin
    Result := DefaultInterface.byteOrderMark;
end;

procedure TMXXMLWriter60.Set_indent(fIndentMode: WordBool);
begin
  DefaultInterface.Set_indent(fIndentMode);
end;

function TMXXMLWriter60.Get_indent: WordBool;
begin
    Result := DefaultInterface.indent;
end;

procedure TMXXMLWriter60.Set_standalone(fValue: WordBool);
begin
  DefaultInterface.Set_standalone(fValue);
end;

function TMXXMLWriter60.Get_standalone: WordBool;
begin
    Result := DefaultInterface.standalone;
end;

procedure TMXXMLWriter60.Set_omitXMLDeclaration(fValue: WordBool);
begin
  DefaultInterface.Set_omitXMLDeclaration(fValue);
end;

function TMXXMLWriter60.Get_omitXMLDeclaration: WordBool;
begin
    Result := DefaultInterface.omitXMLDeclaration;
end;

procedure TMXXMLWriter60.Set_version(const strVersion: WideString);
  { Warnung: Die Eigenschaftversion hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.version := strVersion;
end;

function TMXXMLWriter60.Get_version: WideString;
begin
    Result := DefaultInterface.version;
end;

procedure TMXXMLWriter60.Set_disableOutputEscaping(fValue: WordBool);
begin
  DefaultInterface.Set_disableOutputEscaping(fValue);
end;

function TMXXMLWriter60.Get_disableOutputEscaping: WordBool;
begin
    Result := DefaultInterface.disableOutputEscaping;
end;

procedure TMXXMLWriter60.flush;
begin
  DefaultInterface.flush;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMXXMLWriter60Properties.Create(AServer: TMXXMLWriter60);
begin
  inherited Create;
  FServer := AServer;
end;

function TMXXMLWriter60Properties.GetDefaultInterface: IMXWriter;
begin
  Result := FServer.DefaultInterface;
end;

procedure TMXXMLWriter60Properties.Set_output(varDestination: OleVariant);
begin
  DefaultInterface.Set_output(varDestination);
end;

function TMXXMLWriter60Properties.Get_output: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.output;
end;

procedure TMXXMLWriter60Properties.Set_encoding(const strEncoding: WideString);
  { Warnung: Die Eigenschaftencoding hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.encoding := strEncoding;
end;

function TMXXMLWriter60Properties.Get_encoding: WideString;
begin
    Result := DefaultInterface.encoding;
end;

procedure TMXXMLWriter60Properties.Set_byteOrderMark(fWriteByteOrderMark: WordBool);
begin
  DefaultInterface.Set_byteOrderMark(fWriteByteOrderMark);
end;

function TMXXMLWriter60Properties.Get_byteOrderMark: WordBool;
begin
    Result := DefaultInterface.byteOrderMark;
end;

procedure TMXXMLWriter60Properties.Set_indent(fIndentMode: WordBool);
begin
  DefaultInterface.Set_indent(fIndentMode);
end;

function TMXXMLWriter60Properties.Get_indent: WordBool;
begin
    Result := DefaultInterface.indent;
end;

procedure TMXXMLWriter60Properties.Set_standalone(fValue: WordBool);
begin
  DefaultInterface.Set_standalone(fValue);
end;

function TMXXMLWriter60Properties.Get_standalone: WordBool;
begin
    Result := DefaultInterface.standalone;
end;

procedure TMXXMLWriter60Properties.Set_omitXMLDeclaration(fValue: WordBool);
begin
  DefaultInterface.Set_omitXMLDeclaration(fValue);
end;

function TMXXMLWriter60Properties.Get_omitXMLDeclaration: WordBool;
begin
    Result := DefaultInterface.omitXMLDeclaration;
end;

procedure TMXXMLWriter60Properties.Set_version(const strVersion: WideString);
  { Warnung: Die Eigenschaftversion hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.version := strVersion;
end;

function TMXXMLWriter60Properties.Get_version: WideString;
begin
    Result := DefaultInterface.version;
end;

procedure TMXXMLWriter60Properties.Set_disableOutputEscaping(fValue: WordBool);
begin
  DefaultInterface.Set_disableOutputEscaping(fValue);
end;

function TMXXMLWriter60Properties.Get_disableOutputEscaping: WordBool;
begin
    Result := DefaultInterface.disableOutputEscaping;
end;

{$ENDIF}

procedure TMXHTMLWriter.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{A4C23EC3-6B70-4466-9127-550077239978}';
    IntfIID:   '{4D7FF4BA-1565-4EA8-94E1-6E724A46F98D}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMXHTMLWriter.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IMXWriter;
  end;
end;

procedure TMXHTMLWriter.ConnectTo(svrIntf: IMXWriter);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMXHTMLWriter.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMXHTMLWriter.GetDefaultInterface: IMXWriter;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TMXHTMLWriter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMXHTMLWriterProperties.Create(Self);
{$ENDIF}
end;

destructor TMXHTMLWriter.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMXHTMLWriter.GetServerProperties: TMXHTMLWriterProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TMXHTMLWriter.Set_output(varDestination: OleVariant);
begin
  DefaultInterface.Set_output(varDestination);
end;

function TMXHTMLWriter.Get_output: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.output;
end;

procedure TMXHTMLWriter.Set_encoding(const strEncoding: WideString);
  { Warnung: Die Eigenschaftencoding hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.encoding := strEncoding;
end;

function TMXHTMLWriter.Get_encoding: WideString;
begin
    Result := DefaultInterface.encoding;
end;

procedure TMXHTMLWriter.Set_byteOrderMark(fWriteByteOrderMark: WordBool);
begin
  DefaultInterface.Set_byteOrderMark(fWriteByteOrderMark);
end;

function TMXHTMLWriter.Get_byteOrderMark: WordBool;
begin
    Result := DefaultInterface.byteOrderMark;
end;

procedure TMXHTMLWriter.Set_indent(fIndentMode: WordBool);
begin
  DefaultInterface.Set_indent(fIndentMode);
end;

function TMXHTMLWriter.Get_indent: WordBool;
begin
    Result := DefaultInterface.indent;
end;

procedure TMXHTMLWriter.Set_standalone(fValue: WordBool);
begin
  DefaultInterface.Set_standalone(fValue);
end;

function TMXHTMLWriter.Get_standalone: WordBool;
begin
    Result := DefaultInterface.standalone;
end;

procedure TMXHTMLWriter.Set_omitXMLDeclaration(fValue: WordBool);
begin
  DefaultInterface.Set_omitXMLDeclaration(fValue);
end;

function TMXHTMLWriter.Get_omitXMLDeclaration: WordBool;
begin
    Result := DefaultInterface.omitXMLDeclaration;
end;

procedure TMXHTMLWriter.Set_version(const strVersion: WideString);
  { Warnung: Die Eigenschaftversion hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.version := strVersion;
end;

function TMXHTMLWriter.Get_version: WideString;
begin
    Result := DefaultInterface.version;
end;

procedure TMXHTMLWriter.Set_disableOutputEscaping(fValue: WordBool);
begin
  DefaultInterface.Set_disableOutputEscaping(fValue);
end;

function TMXHTMLWriter.Get_disableOutputEscaping: WordBool;
begin
    Result := DefaultInterface.disableOutputEscaping;
end;

procedure TMXHTMLWriter.flush;
begin
  DefaultInterface.flush;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMXHTMLWriterProperties.Create(AServer: TMXHTMLWriter);
begin
  inherited Create;
  FServer := AServer;
end;

function TMXHTMLWriterProperties.GetDefaultInterface: IMXWriter;
begin
  Result := FServer.DefaultInterface;
end;

procedure TMXHTMLWriterProperties.Set_output(varDestination: OleVariant);
begin
  DefaultInterface.Set_output(varDestination);
end;

function TMXHTMLWriterProperties.Get_output: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.output;
end;

procedure TMXHTMLWriterProperties.Set_encoding(const strEncoding: WideString);
  { Warnung: Die Eigenschaftencoding hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.encoding := strEncoding;
end;

function TMXHTMLWriterProperties.Get_encoding: WideString;
begin
    Result := DefaultInterface.encoding;
end;

procedure TMXHTMLWriterProperties.Set_byteOrderMark(fWriteByteOrderMark: WordBool);
begin
  DefaultInterface.Set_byteOrderMark(fWriteByteOrderMark);
end;

function TMXHTMLWriterProperties.Get_byteOrderMark: WordBool;
begin
    Result := DefaultInterface.byteOrderMark;
end;

procedure TMXHTMLWriterProperties.Set_indent(fIndentMode: WordBool);
begin
  DefaultInterface.Set_indent(fIndentMode);
end;

function TMXHTMLWriterProperties.Get_indent: WordBool;
begin
    Result := DefaultInterface.indent;
end;

procedure TMXHTMLWriterProperties.Set_standalone(fValue: WordBool);
begin
  DefaultInterface.Set_standalone(fValue);
end;

function TMXHTMLWriterProperties.Get_standalone: WordBool;
begin
    Result := DefaultInterface.standalone;
end;

procedure TMXHTMLWriterProperties.Set_omitXMLDeclaration(fValue: WordBool);
begin
  DefaultInterface.Set_omitXMLDeclaration(fValue);
end;

function TMXHTMLWriterProperties.Get_omitXMLDeclaration: WordBool;
begin
    Result := DefaultInterface.omitXMLDeclaration;
end;

procedure TMXHTMLWriterProperties.Set_version(const strVersion: WideString);
  { Warnung: Die Eigenschaftversion hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.version := strVersion;
end;

function TMXHTMLWriterProperties.Get_version: WideString;
begin
    Result := DefaultInterface.version;
end;

procedure TMXHTMLWriterProperties.Set_disableOutputEscaping(fValue: WordBool);
begin
  DefaultInterface.Set_disableOutputEscaping(fValue);
end;

function TMXHTMLWriterProperties.Get_disableOutputEscaping: WordBool;
begin
    Result := DefaultInterface.disableOutputEscaping;
end;

{$ENDIF}

procedure TMXHTMLWriter30.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{853D1540-C1A7-4AA9-A226-4D3BD301146D}';
    IntfIID:   '{4D7FF4BA-1565-4EA8-94E1-6E724A46F98D}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMXHTMLWriter30.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IMXWriter;
  end;
end;

procedure TMXHTMLWriter30.ConnectTo(svrIntf: IMXWriter);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMXHTMLWriter30.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMXHTMLWriter30.GetDefaultInterface: IMXWriter;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TMXHTMLWriter30.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMXHTMLWriter30Properties.Create(Self);
{$ENDIF}
end;

destructor TMXHTMLWriter30.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMXHTMLWriter30.GetServerProperties: TMXHTMLWriter30Properties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TMXHTMLWriter30.Set_output(varDestination: OleVariant);
begin
  DefaultInterface.Set_output(varDestination);
end;

function TMXHTMLWriter30.Get_output: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.output;
end;

procedure TMXHTMLWriter30.Set_encoding(const strEncoding: WideString);
  { Warnung: Die Eigenschaftencoding hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.encoding := strEncoding;
end;

function TMXHTMLWriter30.Get_encoding: WideString;
begin
    Result := DefaultInterface.encoding;
end;

procedure TMXHTMLWriter30.Set_byteOrderMark(fWriteByteOrderMark: WordBool);
begin
  DefaultInterface.Set_byteOrderMark(fWriteByteOrderMark);
end;

function TMXHTMLWriter30.Get_byteOrderMark: WordBool;
begin
    Result := DefaultInterface.byteOrderMark;
end;

procedure TMXHTMLWriter30.Set_indent(fIndentMode: WordBool);
begin
  DefaultInterface.Set_indent(fIndentMode);
end;

function TMXHTMLWriter30.Get_indent: WordBool;
begin
    Result := DefaultInterface.indent;
end;

procedure TMXHTMLWriter30.Set_standalone(fValue: WordBool);
begin
  DefaultInterface.Set_standalone(fValue);
end;

function TMXHTMLWriter30.Get_standalone: WordBool;
begin
    Result := DefaultInterface.standalone;
end;

procedure TMXHTMLWriter30.Set_omitXMLDeclaration(fValue: WordBool);
begin
  DefaultInterface.Set_omitXMLDeclaration(fValue);
end;

function TMXHTMLWriter30.Get_omitXMLDeclaration: WordBool;
begin
    Result := DefaultInterface.omitXMLDeclaration;
end;

procedure TMXHTMLWriter30.Set_version(const strVersion: WideString);
  { Warnung: Die Eigenschaftversion hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.version := strVersion;
end;

function TMXHTMLWriter30.Get_version: WideString;
begin
    Result := DefaultInterface.version;
end;

procedure TMXHTMLWriter30.Set_disableOutputEscaping(fValue: WordBool);
begin
  DefaultInterface.Set_disableOutputEscaping(fValue);
end;

function TMXHTMLWriter30.Get_disableOutputEscaping: WordBool;
begin
    Result := DefaultInterface.disableOutputEscaping;
end;

procedure TMXHTMLWriter30.flush;
begin
  DefaultInterface.flush;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMXHTMLWriter30Properties.Create(AServer: TMXHTMLWriter30);
begin
  inherited Create;
  FServer := AServer;
end;

function TMXHTMLWriter30Properties.GetDefaultInterface: IMXWriter;
begin
  Result := FServer.DefaultInterface;
end;

procedure TMXHTMLWriter30Properties.Set_output(varDestination: OleVariant);
begin
  DefaultInterface.Set_output(varDestination);
end;

function TMXHTMLWriter30Properties.Get_output: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.output;
end;

procedure TMXHTMLWriter30Properties.Set_encoding(const strEncoding: WideString);
  { Warnung: Die Eigenschaftencoding hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.encoding := strEncoding;
end;

function TMXHTMLWriter30Properties.Get_encoding: WideString;
begin
    Result := DefaultInterface.encoding;
end;

procedure TMXHTMLWriter30Properties.Set_byteOrderMark(fWriteByteOrderMark: WordBool);
begin
  DefaultInterface.Set_byteOrderMark(fWriteByteOrderMark);
end;

function TMXHTMLWriter30Properties.Get_byteOrderMark: WordBool;
begin
    Result := DefaultInterface.byteOrderMark;
end;

procedure TMXHTMLWriter30Properties.Set_indent(fIndentMode: WordBool);
begin
  DefaultInterface.Set_indent(fIndentMode);
end;

function TMXHTMLWriter30Properties.Get_indent: WordBool;
begin
    Result := DefaultInterface.indent;
end;

procedure TMXHTMLWriter30Properties.Set_standalone(fValue: WordBool);
begin
  DefaultInterface.Set_standalone(fValue);
end;

function TMXHTMLWriter30Properties.Get_standalone: WordBool;
begin
    Result := DefaultInterface.standalone;
end;

procedure TMXHTMLWriter30Properties.Set_omitXMLDeclaration(fValue: WordBool);
begin
  DefaultInterface.Set_omitXMLDeclaration(fValue);
end;

function TMXHTMLWriter30Properties.Get_omitXMLDeclaration: WordBool;
begin
    Result := DefaultInterface.omitXMLDeclaration;
end;

procedure TMXHTMLWriter30Properties.Set_version(const strVersion: WideString);
  { Warnung: Die Eigenschaftversion hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.version := strVersion;
end;

function TMXHTMLWriter30Properties.Get_version: WideString;
begin
    Result := DefaultInterface.version;
end;

procedure TMXHTMLWriter30Properties.Set_disableOutputEscaping(fValue: WordBool);
begin
  DefaultInterface.Set_disableOutputEscaping(fValue);
end;

function TMXHTMLWriter30Properties.Get_disableOutputEscaping: WordBool;
begin
    Result := DefaultInterface.disableOutputEscaping;
end;

{$ENDIF}

procedure TMXHTMLWriter40.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{88D969C9-F192-11D4-A65F-0040963251E5}';
    IntfIID:   '{4D7FF4BA-1565-4EA8-94E1-6E724A46F98D}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMXHTMLWriter40.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IMXWriter;
  end;
end;

procedure TMXHTMLWriter40.ConnectTo(svrIntf: IMXWriter);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMXHTMLWriter40.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMXHTMLWriter40.GetDefaultInterface: IMXWriter;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TMXHTMLWriter40.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMXHTMLWriter40Properties.Create(Self);
{$ENDIF}
end;

destructor TMXHTMLWriter40.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMXHTMLWriter40.GetServerProperties: TMXHTMLWriter40Properties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TMXHTMLWriter40.Set_output(varDestination: OleVariant);
begin
  DefaultInterface.Set_output(varDestination);
end;

function TMXHTMLWriter40.Get_output: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.output;
end;

procedure TMXHTMLWriter40.Set_encoding(const strEncoding: WideString);
  { Warnung: Die Eigenschaftencoding hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.encoding := strEncoding;
end;

function TMXHTMLWriter40.Get_encoding: WideString;
begin
    Result := DefaultInterface.encoding;
end;

procedure TMXHTMLWriter40.Set_byteOrderMark(fWriteByteOrderMark: WordBool);
begin
  DefaultInterface.Set_byteOrderMark(fWriteByteOrderMark);
end;

function TMXHTMLWriter40.Get_byteOrderMark: WordBool;
begin
    Result := DefaultInterface.byteOrderMark;
end;

procedure TMXHTMLWriter40.Set_indent(fIndentMode: WordBool);
begin
  DefaultInterface.Set_indent(fIndentMode);
end;

function TMXHTMLWriter40.Get_indent: WordBool;
begin
    Result := DefaultInterface.indent;
end;

procedure TMXHTMLWriter40.Set_standalone(fValue: WordBool);
begin
  DefaultInterface.Set_standalone(fValue);
end;

function TMXHTMLWriter40.Get_standalone: WordBool;
begin
    Result := DefaultInterface.standalone;
end;

procedure TMXHTMLWriter40.Set_omitXMLDeclaration(fValue: WordBool);
begin
  DefaultInterface.Set_omitXMLDeclaration(fValue);
end;

function TMXHTMLWriter40.Get_omitXMLDeclaration: WordBool;
begin
    Result := DefaultInterface.omitXMLDeclaration;
end;

procedure TMXHTMLWriter40.Set_version(const strVersion: WideString);
  { Warnung: Die Eigenschaftversion hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.version := strVersion;
end;

function TMXHTMLWriter40.Get_version: WideString;
begin
    Result := DefaultInterface.version;
end;

procedure TMXHTMLWriter40.Set_disableOutputEscaping(fValue: WordBool);
begin
  DefaultInterface.Set_disableOutputEscaping(fValue);
end;

function TMXHTMLWriter40.Get_disableOutputEscaping: WordBool;
begin
    Result := DefaultInterface.disableOutputEscaping;
end;

procedure TMXHTMLWriter40.flush;
begin
  DefaultInterface.flush;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMXHTMLWriter40Properties.Create(AServer: TMXHTMLWriter40);
begin
  inherited Create;
  FServer := AServer;
end;

function TMXHTMLWriter40Properties.GetDefaultInterface: IMXWriter;
begin
  Result := FServer.DefaultInterface;
end;

procedure TMXHTMLWriter40Properties.Set_output(varDestination: OleVariant);
begin
  DefaultInterface.Set_output(varDestination);
end;

function TMXHTMLWriter40Properties.Get_output: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.output;
end;

procedure TMXHTMLWriter40Properties.Set_encoding(const strEncoding: WideString);
  { Warnung: Die Eigenschaftencoding hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.encoding := strEncoding;
end;

function TMXHTMLWriter40Properties.Get_encoding: WideString;
begin
    Result := DefaultInterface.encoding;
end;

procedure TMXHTMLWriter40Properties.Set_byteOrderMark(fWriteByteOrderMark: WordBool);
begin
  DefaultInterface.Set_byteOrderMark(fWriteByteOrderMark);
end;

function TMXHTMLWriter40Properties.Get_byteOrderMark: WordBool;
begin
    Result := DefaultInterface.byteOrderMark;
end;

procedure TMXHTMLWriter40Properties.Set_indent(fIndentMode: WordBool);
begin
  DefaultInterface.Set_indent(fIndentMode);
end;

function TMXHTMLWriter40Properties.Get_indent: WordBool;
begin
    Result := DefaultInterface.indent;
end;

procedure TMXHTMLWriter40Properties.Set_standalone(fValue: WordBool);
begin
  DefaultInterface.Set_standalone(fValue);
end;

function TMXHTMLWriter40Properties.Get_standalone: WordBool;
begin
    Result := DefaultInterface.standalone;
end;

procedure TMXHTMLWriter40Properties.Set_omitXMLDeclaration(fValue: WordBool);
begin
  DefaultInterface.Set_omitXMLDeclaration(fValue);
end;

function TMXHTMLWriter40Properties.Get_omitXMLDeclaration: WordBool;
begin
    Result := DefaultInterface.omitXMLDeclaration;
end;

procedure TMXHTMLWriter40Properties.Set_version(const strVersion: WideString);
  { Warnung: Die Eigenschaftversion hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.version := strVersion;
end;

function TMXHTMLWriter40Properties.Get_version: WideString;
begin
    Result := DefaultInterface.version;
end;

procedure TMXHTMLWriter40Properties.Set_disableOutputEscaping(fValue: WordBool);
begin
  DefaultInterface.Set_disableOutputEscaping(fValue);
end;

function TMXHTMLWriter40Properties.Get_disableOutputEscaping: WordBool;
begin
    Result := DefaultInterface.disableOutputEscaping;
end;

{$ENDIF}

procedure TMXHTMLWriter60.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{88D96A10-F192-11D4-A65F-0040963251E5}';
    IntfIID:   '{4D7FF4BA-1565-4EA8-94E1-6E724A46F98D}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMXHTMLWriter60.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IMXWriter;
  end;
end;

procedure TMXHTMLWriter60.ConnectTo(svrIntf: IMXWriter);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMXHTMLWriter60.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMXHTMLWriter60.GetDefaultInterface: IMXWriter;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TMXHTMLWriter60.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMXHTMLWriter60Properties.Create(Self);
{$ENDIF}
end;

destructor TMXHTMLWriter60.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMXHTMLWriter60.GetServerProperties: TMXHTMLWriter60Properties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TMXHTMLWriter60.Set_output(varDestination: OleVariant);
begin
  DefaultInterface.Set_output(varDestination);
end;

function TMXHTMLWriter60.Get_output: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.output;
end;

procedure TMXHTMLWriter60.Set_encoding(const strEncoding: WideString);
  { Warnung: Die Eigenschaftencoding hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.encoding := strEncoding;
end;

function TMXHTMLWriter60.Get_encoding: WideString;
begin
    Result := DefaultInterface.encoding;
end;

procedure TMXHTMLWriter60.Set_byteOrderMark(fWriteByteOrderMark: WordBool);
begin
  DefaultInterface.Set_byteOrderMark(fWriteByteOrderMark);
end;

function TMXHTMLWriter60.Get_byteOrderMark: WordBool;
begin
    Result := DefaultInterface.byteOrderMark;
end;

procedure TMXHTMLWriter60.Set_indent(fIndentMode: WordBool);
begin
  DefaultInterface.Set_indent(fIndentMode);
end;

function TMXHTMLWriter60.Get_indent: WordBool;
begin
    Result := DefaultInterface.indent;
end;

procedure TMXHTMLWriter60.Set_standalone(fValue: WordBool);
begin
  DefaultInterface.Set_standalone(fValue);
end;

function TMXHTMLWriter60.Get_standalone: WordBool;
begin
    Result := DefaultInterface.standalone;
end;

procedure TMXHTMLWriter60.Set_omitXMLDeclaration(fValue: WordBool);
begin
  DefaultInterface.Set_omitXMLDeclaration(fValue);
end;

function TMXHTMLWriter60.Get_omitXMLDeclaration: WordBool;
begin
    Result := DefaultInterface.omitXMLDeclaration;
end;

procedure TMXHTMLWriter60.Set_version(const strVersion: WideString);
  { Warnung: Die Eigenschaftversion hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.version := strVersion;
end;

function TMXHTMLWriter60.Get_version: WideString;
begin
    Result := DefaultInterface.version;
end;

procedure TMXHTMLWriter60.Set_disableOutputEscaping(fValue: WordBool);
begin
  DefaultInterface.Set_disableOutputEscaping(fValue);
end;

function TMXHTMLWriter60.Get_disableOutputEscaping: WordBool;
begin
    Result := DefaultInterface.disableOutputEscaping;
end;

procedure TMXHTMLWriter60.flush;
begin
  DefaultInterface.flush;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMXHTMLWriter60Properties.Create(AServer: TMXHTMLWriter60);
begin
  inherited Create;
  FServer := AServer;
end;

function TMXHTMLWriter60Properties.GetDefaultInterface: IMXWriter;
begin
  Result := FServer.DefaultInterface;
end;

procedure TMXHTMLWriter60Properties.Set_output(varDestination: OleVariant);
begin
  DefaultInterface.Set_output(varDestination);
end;

function TMXHTMLWriter60Properties.Get_output: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.output;
end;

procedure TMXHTMLWriter60Properties.Set_encoding(const strEncoding: WideString);
  { Warnung: Die Eigenschaftencoding hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.encoding := strEncoding;
end;

function TMXHTMLWriter60Properties.Get_encoding: WideString;
begin
    Result := DefaultInterface.encoding;
end;

procedure TMXHTMLWriter60Properties.Set_byteOrderMark(fWriteByteOrderMark: WordBool);
begin
  DefaultInterface.Set_byteOrderMark(fWriteByteOrderMark);
end;

function TMXHTMLWriter60Properties.Get_byteOrderMark: WordBool;
begin
    Result := DefaultInterface.byteOrderMark;
end;

procedure TMXHTMLWriter60Properties.Set_indent(fIndentMode: WordBool);
begin
  DefaultInterface.Set_indent(fIndentMode);
end;

function TMXHTMLWriter60Properties.Get_indent: WordBool;
begin
    Result := DefaultInterface.indent;
end;

procedure TMXHTMLWriter60Properties.Set_standalone(fValue: WordBool);
begin
  DefaultInterface.Set_standalone(fValue);
end;

function TMXHTMLWriter60Properties.Get_standalone: WordBool;
begin
    Result := DefaultInterface.standalone;
end;

procedure TMXHTMLWriter60Properties.Set_omitXMLDeclaration(fValue: WordBool);
begin
  DefaultInterface.Set_omitXMLDeclaration(fValue);
end;

function TMXHTMLWriter60Properties.Get_omitXMLDeclaration: WordBool;
begin
    Result := DefaultInterface.omitXMLDeclaration;
end;

procedure TMXHTMLWriter60Properties.Set_version(const strVersion: WideString);
  { Warnung: Die Eigenschaftversion hat einen Setter und eine Getter, deren
    Typen unterscheidlich sind. Delphi kann keine solche Eigenschaft generieren
    und verwendet deshalb eine Variante . }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.version := strVersion;
end;

function TMXHTMLWriter60Properties.Get_version: WideString;
begin
    Result := DefaultInterface.version;
end;

procedure TMXHTMLWriter60Properties.Set_disableOutputEscaping(fValue: WordBool);
begin
  DefaultInterface.Set_disableOutputEscaping(fValue);
end;

function TMXHTMLWriter60Properties.Get_disableOutputEscaping: WordBool;
begin
    Result := DefaultInterface.disableOutputEscaping;
end;

{$ENDIF}

procedure TmsSAXAttributes.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{4DD441AD-526D-4A77-9F1B-9841ED802FB0}';
    IntfIID:   '{F10D27CC-3EC0-415C-8ED8-77AB1C5E7262}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TmsSAXAttributes.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IMXAttributes;
  end;
end;

procedure TmsSAXAttributes.ConnectTo(svrIntf: IMXAttributes);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TmsSAXAttributes.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TmsSAXAttributes.GetDefaultInterface: IMXAttributes;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TmsSAXAttributes.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TmsSAXAttributesProperties.Create(Self);
{$ENDIF}
end;

destructor TmsSAXAttributes.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TmsSAXAttributes.GetServerProperties: TmsSAXAttributesProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TmsSAXAttributes.addAttribute(const strURI: WideString; const strLocalName: WideString; 
                                        const strQName: WideString; const strType: WideString; 
                                        const strValue: WideString);
begin
  DefaultInterface.addAttribute(strURI, strLocalName, strQName, strType, strValue);
end;

procedure TmsSAXAttributes.addAttributeFromIndex(varAtts: OleVariant; nIndex: SYSINT);
begin
  DefaultInterface.addAttributeFromIndex(varAtts, nIndex);
end;

procedure TmsSAXAttributes.clear;
begin
  DefaultInterface.clear;
end;

procedure TmsSAXAttributes.removeAttribute(nIndex: SYSINT);
begin
  DefaultInterface.removeAttribute(nIndex);
end;

procedure TmsSAXAttributes.setAttribute(nIndex: SYSINT; const strURI: WideString; 
                                        const strLocalName: WideString; const strQName: WideString; 
                                        const strType: WideString; const strValue: WideString);
begin
  DefaultInterface.setAttribute(nIndex, strURI, strLocalName, strQName, strType, strValue);
end;

procedure TmsSAXAttributes.setAttributes(varAtts: OleVariant);
begin
  DefaultInterface.setAttributes(varAtts);
end;

procedure TmsSAXAttributes.setLocalName(nIndex: SYSINT; const strLocalName: WideString);
begin
  DefaultInterface.setLocalName(nIndex, strLocalName);
end;

procedure TmsSAXAttributes.setQName(nIndex: SYSINT; const strQName: WideString);
begin
  DefaultInterface.setQName(nIndex, strQName);
end;

procedure TmsSAXAttributes.setType(nIndex: SYSINT; const strType: WideString);
begin
  DefaultInterface.setType(nIndex, strType);
end;

procedure TmsSAXAttributes.setURI(nIndex: SYSINT; const strURI: WideString);
begin
  DefaultInterface.setURI(nIndex, strURI);
end;

procedure TmsSAXAttributes.setValue(nIndex: SYSINT; const strValue: WideString);
begin
  DefaultInterface.setValue(nIndex, strValue);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TmsSAXAttributesProperties.Create(AServer: TmsSAXAttributes);
begin
  inherited Create;
  FServer := AServer;
end;

function TmsSAXAttributesProperties.GetDefaultInterface: IMXAttributes;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

procedure TmsSAXAttributes30.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{3E784A01-F3AE-4DC0-9354-9526B9370EBA}';
    IntfIID:   '{F10D27CC-3EC0-415C-8ED8-77AB1C5E7262}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TmsSAXAttributes30.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IMXAttributes;
  end;
end;

procedure TmsSAXAttributes30.ConnectTo(svrIntf: IMXAttributes);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TmsSAXAttributes30.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TmsSAXAttributes30.GetDefaultInterface: IMXAttributes;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TmsSAXAttributes30.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TmsSAXAttributes30Properties.Create(Self);
{$ENDIF}
end;

destructor TmsSAXAttributes30.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TmsSAXAttributes30.GetServerProperties: TmsSAXAttributes30Properties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TmsSAXAttributes30.addAttribute(const strURI: WideString; const strLocalName: WideString; 
                                          const strQName: WideString; const strType: WideString; 
                                          const strValue: WideString);
begin
  DefaultInterface.addAttribute(strURI, strLocalName, strQName, strType, strValue);
end;

procedure TmsSAXAttributes30.addAttributeFromIndex(varAtts: OleVariant; nIndex: SYSINT);
begin
  DefaultInterface.addAttributeFromIndex(varAtts, nIndex);
end;

procedure TmsSAXAttributes30.clear;
begin
  DefaultInterface.clear;
end;

procedure TmsSAXAttributes30.removeAttribute(nIndex: SYSINT);
begin
  DefaultInterface.removeAttribute(nIndex);
end;

procedure TmsSAXAttributes30.setAttribute(nIndex: SYSINT; const strURI: WideString; 
                                          const strLocalName: WideString; 
                                          const strQName: WideString; const strType: WideString; 
                                          const strValue: WideString);
begin
  DefaultInterface.setAttribute(nIndex, strURI, strLocalName, strQName, strType, strValue);
end;

procedure TmsSAXAttributes30.setAttributes(varAtts: OleVariant);
begin
  DefaultInterface.setAttributes(varAtts);
end;

procedure TmsSAXAttributes30.setLocalName(nIndex: SYSINT; const strLocalName: WideString);
begin
  DefaultInterface.setLocalName(nIndex, strLocalName);
end;

procedure TmsSAXAttributes30.setQName(nIndex: SYSINT; const strQName: WideString);
begin
  DefaultInterface.setQName(nIndex, strQName);
end;

procedure TmsSAXAttributes30.setType(nIndex: SYSINT; const strType: WideString);
begin
  DefaultInterface.setType(nIndex, strType);
end;

procedure TmsSAXAttributes30.setURI(nIndex: SYSINT; const strURI: WideString);
begin
  DefaultInterface.setURI(nIndex, strURI);
end;

procedure TmsSAXAttributes30.setValue(nIndex: SYSINT; const strValue: WideString);
begin
  DefaultInterface.setValue(nIndex, strValue);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TmsSAXAttributes30Properties.Create(AServer: TmsSAXAttributes30);
begin
  inherited Create;
  FServer := AServer;
end;

function TmsSAXAttributes30Properties.GetDefaultInterface: IMXAttributes;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

procedure TSAXAttributes40.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{88D969CA-F192-11D4-A65F-0040963251E5}';
    IntfIID:   '{F10D27CC-3EC0-415C-8ED8-77AB1C5E7262}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TSAXAttributes40.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IMXAttributes;
  end;
end;

procedure TSAXAttributes40.ConnectTo(svrIntf: IMXAttributes);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TSAXAttributes40.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TSAXAttributes40.GetDefaultInterface: IMXAttributes;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TSAXAttributes40.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TSAXAttributes40Properties.Create(Self);
{$ENDIF}
end;

destructor TSAXAttributes40.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TSAXAttributes40.GetServerProperties: TSAXAttributes40Properties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TSAXAttributes40.addAttribute(const strURI: WideString; const strLocalName: WideString; 
                                        const strQName: WideString; const strType: WideString; 
                                        const strValue: WideString);
begin
  DefaultInterface.addAttribute(strURI, strLocalName, strQName, strType, strValue);
end;

procedure TSAXAttributes40.addAttributeFromIndex(varAtts: OleVariant; nIndex: SYSINT);
begin
  DefaultInterface.addAttributeFromIndex(varAtts, nIndex);
end;

procedure TSAXAttributes40.clear;
begin
  DefaultInterface.clear;
end;

procedure TSAXAttributes40.removeAttribute(nIndex: SYSINT);
begin
  DefaultInterface.removeAttribute(nIndex);
end;

procedure TSAXAttributes40.setAttribute(nIndex: SYSINT; const strURI: WideString; 
                                        const strLocalName: WideString; const strQName: WideString; 
                                        const strType: WideString; const strValue: WideString);
begin
  DefaultInterface.setAttribute(nIndex, strURI, strLocalName, strQName, strType, strValue);
end;

procedure TSAXAttributes40.setAttributes(varAtts: OleVariant);
begin
  DefaultInterface.setAttributes(varAtts);
end;

procedure TSAXAttributes40.setLocalName(nIndex: SYSINT; const strLocalName: WideString);
begin
  DefaultInterface.setLocalName(nIndex, strLocalName);
end;

procedure TSAXAttributes40.setQName(nIndex: SYSINT; const strQName: WideString);
begin
  DefaultInterface.setQName(nIndex, strQName);
end;

procedure TSAXAttributes40.setType(nIndex: SYSINT; const strType: WideString);
begin
  DefaultInterface.setType(nIndex, strType);
end;

procedure TSAXAttributes40.setURI(nIndex: SYSINT; const strURI: WideString);
begin
  DefaultInterface.setURI(nIndex, strURI);
end;

procedure TSAXAttributes40.setValue(nIndex: SYSINT; const strValue: WideString);
begin
  DefaultInterface.setValue(nIndex, strValue);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TSAXAttributes40Properties.Create(AServer: TSAXAttributes40);
begin
  inherited Create;
  FServer := AServer;
end;

function TSAXAttributes40Properties.GetDefaultInterface: IMXAttributes;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

procedure TSAXAttributes60.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{88D96A0E-F192-11D4-A65F-0040963251E5}';
    IntfIID:   '{F10D27CC-3EC0-415C-8ED8-77AB1C5E7262}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TSAXAttributes60.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IMXAttributes;
  end;
end;

procedure TSAXAttributes60.ConnectTo(svrIntf: IMXAttributes);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TSAXAttributes60.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TSAXAttributes60.GetDefaultInterface: IMXAttributes;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TSAXAttributes60.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TSAXAttributes60Properties.Create(Self);
{$ENDIF}
end;

destructor TSAXAttributes60.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TSAXAttributes60.GetServerProperties: TSAXAttributes60Properties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TSAXAttributes60.addAttribute(const strURI: WideString; const strLocalName: WideString; 
                                        const strQName: WideString; const strType: WideString; 
                                        const strValue: WideString);
begin
  DefaultInterface.addAttribute(strURI, strLocalName, strQName, strType, strValue);
end;

procedure TSAXAttributes60.addAttributeFromIndex(varAtts: OleVariant; nIndex: SYSINT);
begin
  DefaultInterface.addAttributeFromIndex(varAtts, nIndex);
end;

procedure TSAXAttributes60.clear;
begin
  DefaultInterface.clear;
end;

procedure TSAXAttributes60.removeAttribute(nIndex: SYSINT);
begin
  DefaultInterface.removeAttribute(nIndex);
end;

procedure TSAXAttributes60.setAttribute(nIndex: SYSINT; const strURI: WideString; 
                                        const strLocalName: WideString; const strQName: WideString; 
                                        const strType: WideString; const strValue: WideString);
begin
  DefaultInterface.setAttribute(nIndex, strURI, strLocalName, strQName, strType, strValue);
end;

procedure TSAXAttributes60.setAttributes(varAtts: OleVariant);
begin
  DefaultInterface.setAttributes(varAtts);
end;

procedure TSAXAttributes60.setLocalName(nIndex: SYSINT; const strLocalName: WideString);
begin
  DefaultInterface.setLocalName(nIndex, strLocalName);
end;

procedure TSAXAttributes60.setQName(nIndex: SYSINT; const strQName: WideString);
begin
  DefaultInterface.setQName(nIndex, strQName);
end;

procedure TSAXAttributes60.setType(nIndex: SYSINT; const strType: WideString);
begin
  DefaultInterface.setType(nIndex, strType);
end;

procedure TSAXAttributes60.setURI(nIndex: SYSINT; const strURI: WideString);
begin
  DefaultInterface.setURI(nIndex, strURI);
end;

procedure TSAXAttributes60.setValue(nIndex: SYSINT; const strValue: WideString);
begin
  DefaultInterface.setValue(nIndex, strValue);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TSAXAttributes60Properties.Create(AServer: TSAXAttributes60);
begin
  inherited Create;
  FServer := AServer;
end;

function TSAXAttributes60Properties.GetDefaultInterface: IMXAttributes;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

procedure TMXNamespaceManager.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{88D969D5-F192-11D4-A65F-0040963251E5}';
    IntfIID:   '{C90352F5-643C-4FBC-BB23-E996EB2D51FD}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMXNamespaceManager.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IVBMXNamespaceManager;
  end;
end;

procedure TMXNamespaceManager.ConnectTo(svrIntf: IVBMXNamespaceManager);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMXNamespaceManager.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMXNamespaceManager.GetDefaultInterface: IVBMXNamespaceManager;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TMXNamespaceManager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMXNamespaceManagerProperties.Create(Self);
{$ENDIF}
end;

destructor TMXNamespaceManager.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMXNamespaceManager.GetServerProperties: TMXNamespaceManagerProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TMXNamespaceManager.Set_allowOverride(fOverride: WordBool);
begin
  DefaultInterface.Set_allowOverride(fOverride);
end;

function TMXNamespaceManager.Get_allowOverride: WordBool;
begin
    Result := DefaultInterface.allowOverride;
end;

procedure TMXNamespaceManager.reset;
begin
  DefaultInterface.reset;
end;

procedure TMXNamespaceManager.pushContext;
begin
  DefaultInterface.pushContext;
end;

procedure TMXNamespaceManager.pushNodeContext(const contextNode: IXMLDOMNode; fDeep: WordBool);
begin
  DefaultInterface.pushNodeContext(contextNode, fDeep);
end;

procedure TMXNamespaceManager.popContext;
begin
  DefaultInterface.popContext;
end;

procedure TMXNamespaceManager.declarePrefix(const prefix: WideString; const namespaceURI: WideString);
begin
  DefaultInterface.declarePrefix(prefix, namespaceURI);
end;

function TMXNamespaceManager.getDeclaredPrefixes: IMXNamespacePrefixes;
begin
  Result := DefaultInterface.getDeclaredPrefixes;
end;

function TMXNamespaceManager.getPrefixes(const namespaceURI: WideString): IMXNamespacePrefixes;
begin
  Result := DefaultInterface.getPrefixes(namespaceURI);
end;

function TMXNamespaceManager.getURI(const prefix: WideString): OleVariant;
begin
  Result := DefaultInterface.getURI(prefix);
end;

function TMXNamespaceManager.getURIFromNode(const strPrefix: WideString; 
                                            const contextNode: IXMLDOMNode): OleVariant;
begin
  Result := DefaultInterface.getURIFromNode(strPrefix, contextNode);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMXNamespaceManagerProperties.Create(AServer: TMXNamespaceManager);
begin
  inherited Create;
  FServer := AServer;
end;

function TMXNamespaceManagerProperties.GetDefaultInterface: IVBMXNamespaceManager;
begin
  Result := FServer.DefaultInterface;
end;

procedure TMXNamespaceManagerProperties.Set_allowOverride(fOverride: WordBool);
begin
  DefaultInterface.Set_allowOverride(fOverride);
end;

function TMXNamespaceManagerProperties.Get_allowOverride: WordBool;
begin
    Result := DefaultInterface.allowOverride;
end;

{$ENDIF}

procedure TMXNamespaceManager40.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{88D969D6-F192-11D4-A65F-0040963251E5}';
    IntfIID:   '{C90352F5-643C-4FBC-BB23-E996EB2D51FD}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMXNamespaceManager40.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IVBMXNamespaceManager;
  end;
end;

procedure TMXNamespaceManager40.ConnectTo(svrIntf: IVBMXNamespaceManager);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMXNamespaceManager40.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMXNamespaceManager40.GetDefaultInterface: IVBMXNamespaceManager;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TMXNamespaceManager40.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMXNamespaceManager40Properties.Create(Self);
{$ENDIF}
end;

destructor TMXNamespaceManager40.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMXNamespaceManager40.GetServerProperties: TMXNamespaceManager40Properties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TMXNamespaceManager40.Set_allowOverride(fOverride: WordBool);
begin
  DefaultInterface.Set_allowOverride(fOverride);
end;

function TMXNamespaceManager40.Get_allowOverride: WordBool;
begin
    Result := DefaultInterface.allowOverride;
end;

procedure TMXNamespaceManager40.reset;
begin
  DefaultInterface.reset;
end;

procedure TMXNamespaceManager40.pushContext;
begin
  DefaultInterface.pushContext;
end;

procedure TMXNamespaceManager40.pushNodeContext(const contextNode: IXMLDOMNode; fDeep: WordBool);
begin
  DefaultInterface.pushNodeContext(contextNode, fDeep);
end;

procedure TMXNamespaceManager40.popContext;
begin
  DefaultInterface.popContext;
end;

procedure TMXNamespaceManager40.declarePrefix(const prefix: WideString; 
                                              const namespaceURI: WideString);
begin
  DefaultInterface.declarePrefix(prefix, namespaceURI);
end;

function TMXNamespaceManager40.getDeclaredPrefixes: IMXNamespacePrefixes;
begin
  Result := DefaultInterface.getDeclaredPrefixes;
end;

function TMXNamespaceManager40.getPrefixes(const namespaceURI: WideString): IMXNamespacePrefixes;
begin
  Result := DefaultInterface.getPrefixes(namespaceURI);
end;

function TMXNamespaceManager40.getURI(const prefix: WideString): OleVariant;
begin
  Result := DefaultInterface.getURI(prefix);
end;

function TMXNamespaceManager40.getURIFromNode(const strPrefix: WideString; 
                                              const contextNode: IXMLDOMNode): OleVariant;
begin
  Result := DefaultInterface.getURIFromNode(strPrefix, contextNode);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMXNamespaceManager40Properties.Create(AServer: TMXNamespaceManager40);
begin
  inherited Create;
  FServer := AServer;
end;

function TMXNamespaceManager40Properties.GetDefaultInterface: IVBMXNamespaceManager;
begin
  Result := FServer.DefaultInterface;
end;

procedure TMXNamespaceManager40Properties.Set_allowOverride(fOverride: WordBool);
begin
  DefaultInterface.Set_allowOverride(fOverride);
end;

function TMXNamespaceManager40Properties.Get_allowOverride: WordBool;
begin
    Result := DefaultInterface.allowOverride;
end;

{$ENDIF}

procedure TMXNamespaceManager60.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{88D96A11-F192-11D4-A65F-0040963251E5}';
    IntfIID:   '{C90352F5-643C-4FBC-BB23-E996EB2D51FD}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMXNamespaceManager60.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IVBMXNamespaceManager;
  end;
end;

procedure TMXNamespaceManager60.ConnectTo(svrIntf: IVBMXNamespaceManager);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMXNamespaceManager60.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMXNamespaceManager60.GetDefaultInterface: IVBMXNamespaceManager;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface ist NULL. Die Komponente ist nicht mit dem Server verbunden. Sie müssen vor dieser Operation ''Connect'' oder ''ConnectTo'' aufrufen');
  Result := FIntf;
end;

constructor TMXNamespaceManager60.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMXNamespaceManager60Properties.Create(Self);
{$ENDIF}
end;

destructor TMXNamespaceManager60.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMXNamespaceManager60.GetServerProperties: TMXNamespaceManager60Properties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TMXNamespaceManager60.Set_allowOverride(fOverride: WordBool);
begin
  DefaultInterface.Set_allowOverride(fOverride);
end;

function TMXNamespaceManager60.Get_allowOverride: WordBool;
begin
    Result := DefaultInterface.allowOverride;
end;

procedure TMXNamespaceManager60.reset;
begin
  DefaultInterface.reset;
end;

procedure TMXNamespaceManager60.pushContext;
begin
  DefaultInterface.pushContext;
end;

procedure TMXNamespaceManager60.pushNodeContext(const contextNode: IXMLDOMNode; fDeep: WordBool);
begin
  DefaultInterface.pushNodeContext(contextNode, fDeep);
end;

procedure TMXNamespaceManager60.popContext;
begin
  DefaultInterface.popContext;
end;

procedure TMXNamespaceManager60.declarePrefix(const prefix: WideString; 
                                              const namespaceURI: WideString);
begin
  DefaultInterface.declarePrefix(prefix, namespaceURI);
end;

function TMXNamespaceManager60.getDeclaredPrefixes: IMXNamespacePrefixes;
begin
  Result := DefaultInterface.getDeclaredPrefixes;
end;

function TMXNamespaceManager60.getPrefixes(const namespaceURI: WideString): IMXNamespacePrefixes;
begin
  Result := DefaultInterface.getPrefixes(namespaceURI);
end;

function TMXNamespaceManager60.getURI(const prefix: WideString): OleVariant;
begin
  Result := DefaultInterface.getURI(prefix);
end;

function TMXNamespaceManager60.getURIFromNode(const strPrefix: WideString; 
                                              const contextNode: IXMLDOMNode): OleVariant;
begin
  Result := DefaultInterface.getURIFromNode(strPrefix, contextNode);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMXNamespaceManager60Properties.Create(AServer: TMXNamespaceManager60);
begin
  inherited Create;
  FServer := AServer;
end;

function TMXNamespaceManager60Properties.GetDefaultInterface: IVBMXNamespaceManager;
begin
  Result := FServer.DefaultInterface;
end;

procedure TMXNamespaceManager60Properties.Set_allowOverride(fOverride: WordBool);
begin
  DefaultInterface.Set_allowOverride(fOverride);
end;

function TMXNamespaceManager60Properties.Get_allowOverride: WordBool;
begin
    Result := DefaultInterface.allowOverride;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TmsDOMDocument, TmsDOMDocument26, TmsDOMDocument30, TDOMDocument40,
    TDOMDocument60, TmsFreeThreadedDOMDocument, TmsFreeThreadedDOMDocument26, TmsFreeThreadedDOMDocument30, TFreeThreadedDOMDocument40, 
    TFreeThreadedDOMDocument60, TmsXMLSchemaCache, TmsXMLSchemaCache26, TmsXMLSchemaCache30, TXMLSchemaCache40, 
    TXMLSchemaCache60, TmsXSLTemplate, TmsXSLTemplate26, TmsXSLTemplate30, TXSLTemplate40, 
    TXSLTemplate60, TmsXMLHTTP, TmsXMLHTTP26, TmsXMLHTTP30, TXMLHTTP40, 
    TXMLHTTP60, TmsServerXMLHTTP, TmsServerXMLHTTP30, TServerXMLHTTP40, TServerXMLHTTP60, 
    TmsSAXXMLReader, TmsSAXXMLReader30, TSAXXMLReader40, TSAXXMLReader60, TmsMXXMLWriter, 
    TmsMXXMLWriter30, TMXXMLWriter40, TMXXMLWriter60, TMXHTMLWriter, TMXHTMLWriter30, 
    TMXHTMLWriter40, TMXHTMLWriter60, TmsSAXAttributes, TmsSAXAttributes30, TSAXAttributes40, 
    TSAXAttributes60, TMXNamespaceManager, TMXNamespaceManager40, TMXNamespaceManager60]);
end;

end.
