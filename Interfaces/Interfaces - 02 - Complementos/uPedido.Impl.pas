unit uPedido.Impl;

interface

uses
  uPedido.Intf;

type
  TGerenciadorPedido = class(TInterfacedObject, IGerenciadorPedido)
  public
    procedure ProcessarPedido(pPedido: IPedido);
  end;

implementation

uses
  System.SysUtils,
  uInjecoes,
  uEstoque.Intf;

{ TGerenciadorPedido }

procedure TGerenciadorPedido.ProcessarPedido(pPedido: IPedido);
var
  lIDProduto: Int32;
  lGerenciadorEstoque: IGerenciadorEstoque;
begin
  // dentro do pedido vai ter uma lista de produtos e para cada produto eu preciso checar se tem estoque

  lGerenciadorEstoque := TInjecoes.InstanciaDefault.Obter<IGerenciadorEstoque>;
  // aqui eu estaria dentro do loop
  lIDProduto := 345;

//  Contexto.Registros.Get<IGerenciadorEstoque>.VerificarSeTemEstoque

  if not lGerenciadorEstoque.VerificarSeTemEstoque(lIDProduto, 10) then
    raise Exception.Create('Pedido xyz não tem estoque para o produto tal.');
end;

end.
