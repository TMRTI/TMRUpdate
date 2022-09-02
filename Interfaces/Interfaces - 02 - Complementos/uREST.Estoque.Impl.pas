unit uREST.Estoque.Impl;

interface

uses
  uEstoque.Intf;

type
  TGerenciadorEstoqueREST = class(TInterfacedObject, IGerenciadorEstoque)
  public
    function VerificarSeTemEstoque(const pIDProduto: Integer; const pQuantidadeDesejada: Double): Boolean;
  end;

implementation

uses
  System.SysUtils;

{ TGerenciadorEstoqueREST }

function TGerenciadorEstoqueREST.VerificarSeTemEstoque(const pIDProduto: Integer; const pQuantidadeDesejada: Double): Boolean;
begin
//  Result := True;
//
  raise Exception.Create('api não está disponível.');
  // aqui eu deveria ir na api e descobrir o estoque livre para o produto do ID passado por parâmetro
end;

end.
