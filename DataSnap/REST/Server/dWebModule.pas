unit dWebModule;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Datasnap.DSHTTPCommon,
  Datasnap.DSHTTPWebBroker, Datasnap.DSServer,
  Datasnap.DSAuth, IPPeerServer, Datasnap.DSCommonServer, Datasnap.DSHTTP, System.JSON, Data.DBXCommon;

type
  TWebModule1 = class(TWebModule)
    DSHTTPWebDispatcher1: TDSHTTPWebDispatcher;
    DSServer1: TDSServer;
    DSServerClass1: TDSServerClass;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure DSHTTPWebDispatcher1FormatResult(Sender: TObject; var ResultVal: TJSONValue; const Command: TDBXCommand; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation


{$R *.dfm}

uses
  Web.WebReq,
  uSMVendas;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
{#dica: este é o html que é exibido ao acessar a raiz da url do server}
  Response.Content :=
    '<html>' +
    '<head><title>TMRT Update</title></head>' +
    '<body>TMR Update DataSnap Server</body>' +
    '</html>';
end;

procedure TWebModule1.DSHTTPWebDispatcher1FormatResult(Sender: TObject; var ResultVal: TJSONValue; const Command: TDBXCommand; var Handled: Boolean);
begin
{#dica: caso o método devolva somente um resultado, é possível reformatar o mesmo para que o resultado seja literal,
  fora do objeto padrão do Delphi para o result.

  IMPORTANTE: formatar o resultado desta maneira pode fazer o gerador de classes proxies do Delphi parar de funcionar.}

  Handled := ResultVal is TJSONArray;
  if Handled then
  begin
    var lJSONArray :=  TJSONArray(ResultVal);

    Handled := lJSONArray.Count = 1;

    if Handled then
    begin
      ResultVal := lJSONArray.Remove(0);
      lJSONArray.Free;
    end;
  end;
end;

procedure TWebModule1.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := uSMVendas.Vendas;
end;

initialization

finalization
  Web.WebReq.FreeWebModules;

end.

