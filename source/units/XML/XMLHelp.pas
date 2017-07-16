{$I ..\..\CompilerSwitches.inc}

unit XMLHelp;

interface

uses
  MSXML2_TLB_Light;

function HasAttribute(const Node: IXMLDOMNode; const Name: WideString): Boolean;

procedure SetAttribute(const Node: IXMLDOMNode; const Name: WideString;
  const Value: OleVariant); overload;

function GetAttribute(const Node: IXMLDOMNode;
  const Name: WideString): OleVariant;

procedure SetAttribute(const Source, Dest: IXMLDOMNode;
  const Name: WideString); overload;

procedure RemoveAttribute(const Node: IXMLDOMNode; const Name: WideString);

function CreateXML(WithHeader: Boolean;
  const Root: WideString = ''): IXMLDOMDocument;

function CreateXML3(WithHeader: Boolean;
  const Root: WideString = ''): IXMLDOMDocument3;

function CreateXML2(WithHeader: Boolean;
  const Root: WideString = ''): IXMLDOMDocument2;

function AddChildNode(const Parent: IXMLDOMNode;
  const NodeName: WideString): IXMLDOMNode;

function ExtractAttrValue(const AttrName, AttrLine: WideString): WideString;

function IsValidXML(const S: WideString; const Root: WideString = ''): Boolean;

function CreateFromString(const S: WideString): IXMLDOMDocument;

function CreateFromFile(const FileName: WideString): IXMLDOMDocument;

function IsValidType(const XML: IXMLDOMDocument;
  const Root: WideString): Boolean;

function IsMSXML6Installed: Boolean;

implementation

uses
  MSXML2_TLB;

function HasAttribute(const Node: IXMLDOMNode; const Name: WideString): Boolean;
begin
  Result := Assigned(Node.attributes.getNamedItem(Name));
end;

procedure SetAttribute(const Node: IXMlDOMNode; const Name: WideString;
  const Value: OleVariant);
var
  Attribute: IXMLDOMAttribute;
begin
  if Assigned(Node.attributes.getNamedItem(Name)) then
    Node.attributes.getNamedItem(Name).nodeValue := Value
  else
  begin
    Attribute := Node.ownerDocument.createAttribute(Name);
    Attribute.nodeValue := Value;
    Node.attributes.setNamedItem(Attribute);
  end;
end;

function GetAttribute(const Node: IXMLDOMNode;
  const Name: WideString): OleVariant;
begin
  if HasAttribute(Node, Name) then
    Result := Node.attributes.getNamedItem(Name).nodeValue
  else
    Result := varEmpty;
end;

procedure SetAttribute(const Source, Dest: IXMlDOMNode;
  const Name: WideString);
begin
  if HasAttribute(Source, Name) then
    SetAttribute(Dest, Name, Source.attributes.getNamedItem(Name).nodeValue);
end;

procedure RemoveAttribute(const Node: IXMLDOMNode; const Name: WideString);
begin
  Node.attributes.removeNamedItem(Name);
end;

function CreateXML(WithHeader: Boolean;
  const Root: WideString = ''): IXMLDOMDocument;
begin
  if IsMSXML6Installed then
    Result := CreateXML3(WithHeader, Root)
  else
    Result := CreateXML2(WithHeader, Root);
end;

function CreateXML3(WithHeader: Boolean;
  const Root: WideString = ''): IXMLDOMDocument3;
var
  Node: IXMLDOMNode;
begin
  try
    Result := CoDOMDocument60.Create;
    Result.setProperty('NewParser', True);
    Result.setProperty('ProhibitDTD', False);
    Result.validateOnParse := False;
    Result.resolveExternals := False;

    if WithHeader then
    begin
      Node := Result.createProcessingInstruction('xml',
        'version="1.0" encoding="UTF-8"');
      Result.appendChild(Node);
    end;

    if Root <> '' then
    begin
      Node := Result.createElement(Root);
      Result.appendChild(Node);
    end;
  except
    Result := nil;
  end;
end;

function CreateXML2(WithHeader: Boolean;
  const Root: WideString = ''): IXMLDOMDocument2;
var
  Node: IXMLDOMNode;
begin
  try
    Result := CoDOMDocument40.Create;
    Result.setProperty('NewParser', True);
    Result.validateOnParse := False;
    Result.resolveExternals := False;

    if WithHeader then
    begin
      Node := Result.createProcessingInstruction('xml',
        'version="1.0" encoding="UTF-8"');
      Result.appendChild(Node);
    end;

    if Root <> '' then
    begin
      Node := Result.createElement(Root);
      Result.appendChild(Node);
    end;
  except
    Result := nil;
  end;
end;

function AddChildNode(const Parent: IXMLDOMNode;
  const NodeName: WideString): IXMLDOMNode;
var
  XML: IXMLDOMDocument;
begin
  if Assigned(Parent) then
  begin
    XML := Parent.ownerDocument;
    if Assigned(XML) then
    begin
      Result := XML.createElement(NodeName);
      Parent.appendChild(Result);
    end else
      Result := nil;
  end else
    Result := nil;
end;

function ExtractAttrValue(const AttrName, AttrLine: WideString): WideString;
var
  LineLen, ItemPos, ItemEnd: Integer;
begin
  ItemPos := Pos(AttrName, AttrLine);
  LineLen := Length(AttrLine);
  if ItemPos > 0 then
  begin
    Inc(ItemPos, Length(AttrName));
    while (ItemPos < LineLen) and
          not ((AttrLine[ItemPos] = '''') or (AttrLine[ItemPos] = '"')) do
      Inc(ItemPos);
    if ItemPos < LineLen then
    begin
      ItemEnd := ItemPos + 1;
      while (ItemEnd < LineLen) and
            not ((AttrLine[ItemEnd] = '''') or (AttrLine[ItemEnd] = '"')) do
        Inc(ItemEnd);
      Result := Copy(AttrLine, ItemPos + 1, ItemEnd - ItemPos - 1);
    end;
  end else
    Result := '';
end;

function IsValidXML(const S: WideString; const Root: WideString = ''): Boolean;
var
  XML: IXMLDOMDocument;
begin
  XML := CreateFromString(S);
  Result := IsValidType(XML, Root);
end;

function CreateFromString(const S: WideString): IXMLDOMDocument;
var
  XML: IXMLDOMDocument;
begin
  XML := CreateXML(True);
  if Assigned(XML) and XML.loadXML(S) then
    Result := XML
  else
    Result := nil;
end;

function CreateFromFile(const FileName: WideString): IXMLDOMDocument;
var
  XML: IXMLDOMDocument;
begin
  XML := CreateXML(False);
  if XML.load(FileName) then
    Result := XML
  else
    Result := nil;
end;

function IsValidType(const XML: IXMLDOMDocument;
  const Root: WideString): Boolean;
begin
  Result := Assigned(XML);
  if Result and (Root <> '') then
    Result := Assigned(XML.documentElement) and
      (XML.documentElement.nodeName = Root);
end;

function IsMSXML6Installed: Boolean;
var
  XML: IXMLDOMDocument3;
begin
  try
    XML := CoDOMDocument60.Create;
    Result := Assigned(XML);
  except
    Result := False;
  end;
end;


end.
