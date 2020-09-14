unit uDadosClientes;

interface

type
  TDadosCliente = class
  private
    FID: TGUID;
    FNome: string;
    FAtivo: Boolean;
  public
    property ID: TGUID read FID write FID;
    property Nome: string read FNome write FNome;
    property Ativo: Boolean read FAtivo write FAtivo;
  end;

implementation

end.
