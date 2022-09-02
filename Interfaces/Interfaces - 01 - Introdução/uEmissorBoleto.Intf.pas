unit uEmissorBoleto.Intf;

interface

uses
  System.Classes;

type
  IParametroEmissaoBoleto = interface
    ['{BD4DB7B1-38BE-4CEA-A707-139C2BB5EC13}']

    function GetCodigoBanco: Int32;
    procedure SetCodigoBanco(const pValor: Int32);

    function GetDadosEmitente: string;
    procedure SetDadosEmitente(const pValor: string);

    function GetDadosPagador: string;
    procedure SetDadosPagador(const pValor: string);

    function GetNossoNumero: Int32;
    procedure SetNossoNumero(const pValor: Int32);

    function GetValor: Currency;
    procedure SetValor(const pValor: Currency);
  end;

  IBuilderParametroEmissaoBoleto = interface
    ['{B20E2826-BF84-4160-AD36-5EBAE467CE20}']

    function SetCodigoBanco(const pValor: Int32): IBuilderParametroEmissaoBoleto;
    function SetDadosEmitente(const pValor: string): IBuilderParametroEmissaoBoleto;
    function SetDadosPagador(const pValor: string): IBuilderParametroEmissaoBoleto;
    function SetNossoNumero(const pValor: Int32): IBuilderParametroEmissaoBoleto;
    function SetValor(const pValor: Currency): IBuilderParametroEmissaoBoleto;

    function Build: IParametroEmissaoBoleto;
  end;

  IEmissorBoleto = interface
    ['{2D0EDED6-F4EE-488C-9480-140310EEDDA6}']

    function Emitir(pParametroEmissaoBoleto: IParametroEmissaoBoleto): TStream;
  end;

  TEmissorBoletoPadrao = class
  strict private
    class var FImplementacao: IEmissorBoleto;

    class function GetImplementacao: IEmissorBoleto; static;
  public
    class function CriarBuilderParametro: IBuilderParametroEmissaoBoleto;
    class property Implementacao: IEmissorBoleto read GetImplementacao write FImplementacao;
  end;

  TParametroEmissaoBoleto = class(TInterfacedObject, IParametroEmissaoBoleto)
  strict private
    FCodigoBanco: Int32;
    FDadosEmitente: string;
    FDadosPagador: string;
    FNossoNumero: Int32;
    FValor: Currency;
  public
    function GetCodigoBanco: Int32;
    procedure SetCodigoBanco(const pValor: Int32);

    function GetDadosEmitente: string;
    procedure SetDadosEmitente(const pValor: string);

    function GetDadosPagador: string;
    procedure SetDadosPagador(const pValor: string);

    function GetNossoNumero: Int32;
    procedure SetNossoNumero(const pValor: Int32);

    function GetValor: Currency;
    procedure SetValor(const pValor: Currency);
  end;

  TBuilderParametroEmissaoBoleto = class(TInterfacedObject, IBuilderParametroEmissaoBoleto)
  strict private
    FParametroEmissaoBoleto: IParametroEmissaoBoleto;
  public
    constructor Create;

    function SetCodigoBanco(const pValor: Int32): IBuilderParametroEmissaoBoleto;
    function SetDadosEmitente(const pValor: string): IBuilderParametroEmissaoBoleto;
    function SetDadosPagador(const pValor: string): IBuilderParametroEmissaoBoleto;
    function SetNossoNumero(const pValor: Int32): IBuilderParametroEmissaoBoleto;
    function SetValor(const pValor: Currency): IBuilderParametroEmissaoBoleto;

    function Build: IParametroEmissaoBoleto;
  end;

implementation

uses
  System.SysUtils;

{ TEmissorBoletoPadrao }

class function TEmissorBoletoPadrao.CriarBuilderParametro: IBuilderParametroEmissaoBoleto;
begin
  Result := TBuilderParametroEmissaoBoleto.Create;
end;

class function TEmissorBoletoPadrao.GetImplementacao: IEmissorBoleto;
begin
  if not Assigned(FImplementacao) then
    raise Exception.Create('Implementação padrão do emissor de boleto não foi informada.');

  Result := FImplementacao;
end;

{ TBuilderParametroEmissaoBoleto }

function TBuilderParametroEmissaoBoleto.Build: IParametroEmissaoBoleto;
begin
  Result := FParametroEmissaoBoleto;
end;

constructor TBuilderParametroEmissaoBoleto.Create;
begin
  FParametroEmissaoBoleto := TParametroEmissaoBoleto.Create;
end;

function TBuilderParametroEmissaoBoleto.SetCodigoBanco(const pValor: Int32): IBuilderParametroEmissaoBoleto;
begin
  FParametroEmissaoBoleto.SetCodigoBanco(pValor);
  Result := Self;
end;

function TBuilderParametroEmissaoBoleto.SetDadosEmitente(const pValor: string): IBuilderParametroEmissaoBoleto;
begin
  FParametroEmissaoBoleto.SetDadosEmitente(pValor);
  Result := Self;
end;

function TBuilderParametroEmissaoBoleto.SetDadosPagador(const pValor: string): IBuilderParametroEmissaoBoleto;
begin
  FParametroEmissaoBoleto.SetDadosPagador(pValor);
  Result := Self;
end;

function TBuilderParametroEmissaoBoleto.SetNossoNumero(const pValor: Int32): IBuilderParametroEmissaoBoleto;
begin
  FParametroEmissaoBoleto.SetNossoNumero(pValor);
  Result := Self;
end;

function TBuilderParametroEmissaoBoleto.SetValor(const pValor: Currency): IBuilderParametroEmissaoBoleto;
begin
  FParametroEmissaoBoleto.SetValor(pValor);
  Result := Self;
end;

{ TParametroEmissaoBoleto }

function TParametroEmissaoBoleto.GetCodigoBanco: Int32;
begin

end;

function TParametroEmissaoBoleto.GetDadosEmitente: string;
begin

end;

function TParametroEmissaoBoleto.GetDadosPagador: string;
begin

end;

function TParametroEmissaoBoleto.GetNossoNumero: Int32;
begin

end;

function TParametroEmissaoBoleto.GetValor: Currency;
begin

end;

procedure TParametroEmissaoBoleto.SetCodigoBanco(const pValor: Int32);
begin

end;

procedure TParametroEmissaoBoleto.SetDadosEmitente(const pValor: string);
begin

end;

procedure TParametroEmissaoBoleto.SetDadosPagador(const pValor: string);
begin

end;

procedure TParametroEmissaoBoleto.SetNossoNumero(const pValor: Int32);
begin

end;

procedure TParametroEmissaoBoleto.SetValor(const pValor: Currency);
begin

end;

end.
