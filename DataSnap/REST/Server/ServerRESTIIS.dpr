library ServerRESTIIS;

uses
  Winapi.ActiveX,
  System.Win.ComObj,
  Web.WebBroker,
  Web.Win.ISAPIApp,
  Web.Win.ISAPIThreadPool,
  Data.DBXCommon,
  Datasnap.DSSession,
  dWebModule in 'dWebModule.pas' {WebModule1: TWebModule},
  dConexaoBD in 'dConexaoBD.pas' {dmdConexao: TDataModule},
  uDadosClientes in 'uDadosClientes.pas',
  uJSON in 'uJSON.pas',
  uRegraClientes in 'uRegraClientes.pas',
  uSMVendas in 'uSMVendas.pas';

{$R *.res}

exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;

procedure TerminateThreads;
begin
  TDSSessionManager.Instance.Free;
  Data.DBXCommon.TDBXScheduler.Instance.Free;
end;

begin
  CoInitFlags := COINIT_MULTITHREADED;
  Application.Initialize;
  Application.WebModuleClass := WebModuleClass;
  TISAPIApplication(Application).OnTerminate := TerminateThreads;
  Application.CreateForm(TdmdConexao, dmdConexao);
  Application.Run;
end.
