unit uBD.Estoque.Impl;

interface

uses
  uEstoque.Intf;

type
  TGerenciadorEstoqueBD = class(TInterfacedObject, IGerenciadorEstoque)
  public
    function VerificarSeTemEstoque(const pIDProduto: Integer; const pQuantidadeDesejada: Double): Boolean;
  end;

implementation

{ TGerenciadorEstoqueBD }

function TGerenciadorEstoqueBD.VerificarSeTemEstoque(const pIDProduto: Integer; const pQuantidadeDesejada: Double): Boolean;
begin
  Result := pQuantidadeDesejada >= 0;

  // aqui eu deveria ir no BD e descobrir o estoque livre para o produto do ID passado por parâmetro
end;

end.
