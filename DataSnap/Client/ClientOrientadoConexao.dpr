program ClientOrientadoConexao;

uses
  Vcl.Forms,
  fPrincipalClient in 'fPrincipalClient.pas' {frmPrincipalClient};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipalClient, frmPrincipalClient);
  Application.Run;
end.
