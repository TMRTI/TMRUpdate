unit uSMCadastros;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  Datasnap.DSServer,
  Datasnap.DSAuth;

type
{$METHODINFO ON}
{#dica: Como o nome dessa classe vai ser parte da URL, abrimos mão do padrão que sugere usar T como prefixo da classe}
  Cadastros = class(TComponent)
  private
    { Private declarations }
  public

{#dica: estes 4 métodos atendem a mesma url, exemplo: http://localhost:8080/datasnap/rest/Cadastros/Paises, porém, mapeando 4 verbos diferentes }
    function Paises(const pIDPais: Int32): TJSONValue; // verbo padrão = get
    procedure acceptPaises(const pObjeto: TJSONObject); // prefixo accept mapeia o verbo put
    function updatePaises(const pObjeto: TJSONObject): TJSONValue; // prefixo update mapeia o verbo post
    procedure cancelPaises(const pIDPais: UInt64); // prefixo cancel mapeia o verbo delete
  end;
{$METHODINFO OFF}

implementation

uses
  uJSON,
  uDadosPais,
  uRegraPaises;

{ Cadastros }

procedure Cadastros.acceptPaises(const pObjeto: TJSONObject);
begin
  var lRegraPaises := TRegraPaises.Create;

  try
    lRegraPaises.Salvar(TJSON.ConverterJSONParaObjeto<TDadosPais>(pObjeto));
  finally
    lRegraPaises.Free;
  end;
end;

procedure Cadastros.cancelPaises(const pIDPais: UInt64);
begin

end;

function Cadastros.Paises(const pIDPais: Int32): TJSONValue;
begin
{#dica: lembre de manter os server methods com a exclusividade única de gerar endpoints, interpretar e responder requisições.
  Regra de negócio e consultas a bancos de dados devem preferencialmente ficar isoladas para aumentar o reuso das mesmas. }
  var lRegraPaises := TRegraPaises.Create;

  try
{#dica: se o usuário da api passar um parâmetro para a url (get http://localhost:8080/datasnap/rest/Cadastros/Paises/1)
  o ID do país trará este valor, e podemos devolver o país solicitado, caso contrário, devolvemos todos os países (else deste if) }
    if pIDPais > 0 then
    begin
      Result := TJSON.ConverterObjetoParaJSON(lRegraPaises.GetPais(pIDPais));
    end else
    begin
      Result := TJSON.ConsumirListaComoArray<TDadosPais>(lRegraPaises.GetLista);
    end;
  finally
    lRegraPaises.Free;
  end;
end;

function Cadastros.updatePaises(const pObjeto: TJSONObject): TJSONValue;
begin

end;

end.

