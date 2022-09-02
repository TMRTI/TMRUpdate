unit uInjecoes;

interface

uses
  System.Generics.Collections;

type
  TInjecoes = class
  strict private
    FInjecoes: TDictionary<string, IInterface>;

    class var FInstanciaDefault: TInjecoes;

    class function GetInstanciaDefault: TInjecoes; static;
  private
    class procedure InicializarInstanciaDefault;
    class procedure LiberarInstanciaDefault;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Registrar<I: IInterface>(pImplementacao: I);
    function Obter<I: IInterface>: I;

    class property InstanciaDefault: TInjecoes read GetInstanciaDefault;
  end;

implementation

uses
  System.SysUtils,
  System.TypInfo;

{ TInjecoes }

constructor TInjecoes.Create;
begin
  inherited Create;

  FInjecoes := TDictionary<string, IInterface>.Create;
end;

destructor TInjecoes.Destroy;
begin
  FInjecoes.Free;

  inherited;
end;

class function TInjecoes.GetInstanciaDefault: TInjecoes;
begin
  if not Assigned(FInstanciaDefault) then
  begin
    raise Exception.Create('Instância default do TInjecoes não está disponivel.');
  end;

  Result := FInstanciaDefault;
end;

class procedure TInjecoes.InicializarInstanciaDefault;
begin
  if not Assigned(FInstanciaDefault) then
  begin
    FInstanciaDefault := Self.Create;
  end;
end;

class procedure TInjecoes.LiberarInstanciaDefault;
begin
  FreeAndNil(FInstanciaDefault);
end;

function TInjecoes.Obter<I>: I;
var
  lNomeTipo: string;
  lImplementacaoNaoTipada: IInterface;
begin
  lNomeTipo := GetTypeName(TypeInfo(I));

  if not FInjecoes.TryGetValue(lNomeTipo, lImplementacaoNaoTipada) or
    not Supports(lImplementacaoNaoTipada, GetTypeData(TypeInfo(I))^.GUID, Result) then
  begin
    raise Exception.Create('Não foi encontrada uma implementação para ' + lNomeTipo);
  end;
//
//  Result := I(lImplementacaoNaoTipada);
end;

procedure TInjecoes.Registrar<I>(pImplementacao: I);
var
  lNomeTipo: string;
begin
  lNomeTipo := GetTypeName(TypeInfo(I));

  if FInjecoes.ContainsKey(lNomeTipo) then
    raise Exception.Create('Já existe um registro para ' + lNomeTipo);

  FInjecoes.Add(lNomeTipo, pImplementacao);
end;

initialization
  Tinjecoes.InicializarInstanciaDefault;

finalization
  Tinjecoes.LiberarInstanciaDefault;

end.
