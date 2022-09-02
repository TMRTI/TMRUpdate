program InterfacesII;

uses
  Vcl.Forms,
  fPrincipal in 'fPrincipal.pas' {Form2},
  uValidacao.Intf in 'uValidacao.Intf.pas',
  uValidacao.Impl in 'uValidacao.Impl.pas',
  uCircuitoFechado in 'uCircuitoFechado.pas',
  uInjecoes in 'uInjecoes.pas',
  uPedido.Intf in 'uPedido.Intf.pas',
  uEstoque.Intf in 'uEstoque.Intf.pas',
  uBD.Estoque.Impl in 'uBD.Estoque.Impl.pas',
  uPedido.Impl in 'uPedido.Impl.pas',
  fPedido in 'fPedido.pas' {Form1},
  uREST.Estoque.Impl in 'uREST.Estoque.Impl.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
