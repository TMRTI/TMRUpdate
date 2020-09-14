program ServerRESTStandAlone;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  fPrincipalServer in 'fPrincipalServer.pas' {Form1},
  uSMVendas in 'uSMVendas.pas',
  dWebModule in 'dWebModule.pas' {WebModule1: TWebModule},
  uRegraClientes in 'uRegraClientes.pas',
  uDadosClientes in 'uDadosClientes.pas',
  dConexaoBD in 'dConexaoBD.pas' {dmdConexao: TDataModule},
  uJSON in 'uJSON.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TdmdConexao, dmdConexao);
  Application.Run;
end.
