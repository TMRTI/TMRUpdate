program ServerRESTStandAlone;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  fPrincipalServer in 'fPrincipalServer.pas' {Form1},
  uSMCadastros in 'uSMCadastros.pas',
  dWebModule in 'dWebModule.pas' {WebModule1: TWebModule},
  uRegraPaises in 'uRegraPaises.pas',
  uDadosPais in 'uDadosPais.pas',
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
