program ServerOrientadoConexaoSA;

uses
  fPrincipalServer in 'fPrincipalServer.pas' {fmrPrincipalServer},
  IdHTTPWebBrokerBridge,
  uServerContainer in 'uServerContainer.pas' {dmdServerContainer: TDataModule},
  uServerMethodsUnit in 'uServerMethodsUnit.pas' {ServerMethodsExemplo: TDSServerModule},
  Vcl.Forms,
  Web.WebReq;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmrPrincipalServer, fmrPrincipalServer);
  Application.CreateForm(TdmdServerContainer, dmdServerContainer);
  Application.Run;
end.

