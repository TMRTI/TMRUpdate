unit uEmissorBoletoACBr.Impl;

interface

uses
  System.Classes,
  uEmissorBoleto.Intf;

type
  TEmissorBoletoACBr = class(TInterfacedObject, IEmissorBoleto)
  public
    function Emitir(pParametroEmissaoBoleto: IParametroEmissaoBoleto): TStream;
  end;

implementation

{ TEmissorBoletoACBr }

uses
  VCL.Dialogs;
//  ACBrBoleto;

function TEmissorBoletoACBr.Emitir(pParametroEmissaoBoleto: IParametroEmissaoBoleto): TStream;
begin
  TThread.Synchronize(nil,
    procedure
    begin
      ShowMessage('emitindo o boleto pelo ACBr para ' + pParametroEmissaoBoleto.GetDadosPagador);
    end);

  Result := TMemoryStream.Create;

  try
    //
  except
    Result.Free;
    raise;
  end;
end;

initialization
  TEmissorBoletoPadrao.Implementacao := TEmissorBoletoACBr.Create;

end.
