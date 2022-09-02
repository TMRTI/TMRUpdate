unit uValidacao.Impl;

interface

uses
  System.SysUtils,
  System.Classes,
  uValidacao.Intf;

type
//  TValidacao = class(TNoRefCountObject, IValidacao)
  TValidacao = class(TInterfacedObject, IValidacao)
  strict private
    FCallbackDestruicao: TProc;
    FValidacoes: TStringList;
  public
    constructor Create(pCallbackDestruicao: TProc);
    destructor Destroy; override;

    function GetValidacoesFalhas: TStrings;
  end;

  EValidacao = class(Exception, IValidacao)
  strict private
    FValidacoesFalhas: TStringList;

    FIntefaceAggreagate: TAggregatedObject;
  public
    constructor Create(const pMessage: string; const pValidacoesFalhas: string = '');
    destructor Destroy; override;

    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    function GetValidacoesFalhas: TStrings;
  end;

implementation

{ TValidacao }

constructor TValidacao.Create(pCallbackDestruicao: TProc);
begin
  inherited Create;

  FCallbackDestruicao := pCallbackDestruicao;
  FValidacoes := TStringList.Create;
end;

destructor TValidacao.Destroy;
begin
  if Assigned(FCallbackDestruicao) then
    FCallbackDestruicao();

  FValidacoes.Free;

  inherited;
end;

function TValidacao.GetValidacoesFalhas: TStrings;
begin
  Result := FValidacoes;
end;

{ EValidacao }

constructor EValidacao.Create(const pMessage: string; const pValidacoesFalhas: string = '');
begin
  inherited Create(pMessage);

  if not pValidacoesFalhas.IsEmpty then
  begin
    FValidacoesFalhas := TStringList.Create;
    FValidacoesFalhas.Add(pValidacoesFalhas);
  end;
end;

destructor EValidacao.Destroy;
begin
  FValidacoesFalhas.Free;

  inherited;
end;

function EValidacao.GetValidacoesFalhas: TStrings;
begin
  if not Assigned(FValidacoesFalhas) then
    FValidacoesFalhas := TStringList.Create;

  Result := FValidacoesFalhas;
end;

function EValidacao.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function EValidacao._AddRef: Integer;
begin
  Result := -1;
end;

function EValidacao._Release: Integer;
begin
  Result := -1;
end;

end.
