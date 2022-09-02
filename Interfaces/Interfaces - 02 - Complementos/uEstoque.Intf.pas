unit uEstoque.Intf;

interface

type
  IGerenciadorEstoque = interface
    ['{ACD9C55C-D037-4CC1-B188-EB268EE6253C}']

    function VerificarSeTemEstoque(const pIDProduto: Int32; const pQuantidadeDesejada: Double): Boolean;
  end;

implementation

end.
