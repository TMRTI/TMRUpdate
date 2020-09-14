unit uSMVendas;

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
  Vendas = class(TComponent)
  private
    { Private declarations }
  public

{#dica: estes 4 métodos atendem a mesma url, exemplo: http://localhost:8080/datasnap/rest/vendas/clientes, porém, mapeando 4 verbos diferentes }
    function Clientes(const pIDCliente: string): TJSONValue; // verbo padrão = get
    procedure acceptClientes(const pObjeto: TJSONObject); // prefixo accept mapeia o verbo put
    function updateClientes(const pObjeto: TJSONObject): TJSONValue; // prefixo update mapeia o verbo post
    procedure cancelClientes(const pIDCliente: string); // prefixo cancel mapeia o verbo delete
  end;
{$METHODINFO OFF}

implementation

uses
  uJSON,
  uDadosClientes,
  uRegraClientes;

{ Vendas }

procedure Vendas.acceptClientes(const pObjeto: TJSONObject);
begin
  var lRegraClientes := TRegraClientes.Create;

  try
    lRegraClientes.Salvar(TJSON.ConverterJSONParaObjeto<TDadosCliente>(pObjeto));
  finally
    lRegraClientes.Free;
  end;
end;

procedure Vendas.cancelClientes(const pIDCliente: string);
begin
  var lRegraClientes := TRegraClientes.Create;

  try
    lRegraClientes.Excluir(TGUID.Create(pIDCliente));
  finally
    lRegraClientes.Free;
  end;
end;

function Vendas.Clientes(const pIDCliente: string): TJSONValue;
begin
{#dica: lembre de manter os server methods com a exclusividade única de gerar endpoints, interpretar e responder requisições.
  Regra de negócio e consultas a bancos de dados devem preferencialmente ficar isoladas para aumentar o reuso das mesmas. }
  var lRegraClientes := TRegraClientes.Create;

  try
(*#dica: se o usuário da api passar um parâmetro para a url
  (get http://localhost:8080/datasnap/rest/Vendas/Clientes/{A024164E-6EAD-4883-B782-42DC1DE5EBD2} (else deste if)
  o parêmtro pIDCliente trará este valor, e podemos devolver o cliente solicitado,
  caso contrário, devolvemos todos os clientes ativos (then deste if) *)
    if pIDCliente.IsEmpty then
    begin
      Result := TJSON.ConsumirListaComoArray<TDadosCliente>(lRegraClientes.GetLista);
    end else
    begin
      Result := TJSON.ConverterObjetoParaJSON(lRegraClientes.GetCliente(TGUID.Create(pIDCliente)));
    end;
  finally
    lRegraClientes.Free;
  end;
end;

function Vendas.updateClientes(const pObjeto: TJSONObject): TJSONValue;
begin
  var lRegraClientes := TRegraClientes.Create;

  try
    Result := TJSONString.Create(lRegraClientes.SalvarNovo(TJSON.ConverterJSONParaObjeto<TDadosCliente>(pObjeto)).ToString);
  finally
    lRegraClientes.Free;
  end;
end;

end.

