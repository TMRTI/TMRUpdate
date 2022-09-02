program ExemploInterfaces;

uses
  Vcl.Forms,
  fPrincipal in 'fPrincipal.pas' {Form2},
  uPrimeiroExemplo.Intf in 'uPrimeiroExemplo.Intf.pas',
  uPrimeiroExemplo.Impl in 'uPrimeiroExemplo.Impl.pas',
  uEmissorBoleto.Intf in 'uEmissorBoleto.Intf.pas',
  uEmissorBoletoACBr.Impl in 'uEmissorBoletoACBr.Impl.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
