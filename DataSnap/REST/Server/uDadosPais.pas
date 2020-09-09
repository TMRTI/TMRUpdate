unit uDadosPais;

interface

type
  TDadosPais = class
  private
    FID: Int32;
    FNome: string;
  public
    property ID: Int32 read FID write FID;
    property Nome: string read FNome write FNome;
  end;

implementation

end.
