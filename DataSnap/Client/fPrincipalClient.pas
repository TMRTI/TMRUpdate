unit fPrincipalClient;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.SqlExpr, Data.DBXDataSnap, Data.DBXCommon, IPPeerClient, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, Datasnap.DSConnect;

type
  TfrmPrincipalClient = class(TForm)
    conDS: TSQLConnection;
    dspServerMethodsExemplo: TDSProviderConnection;
    cdsPais: TClientDataSet;
    cdsPaisID: TIntegerField;
    cdsPaisNOME: TStringField;
    dbgPais: TDBGrid;
    dtsPais: TDataSource;
    pnlDados: TPanel;
    dbnPais: TDBNavigator;
    lblCodigo: TLabel;
    dbeCodigo: TDBEdit;
    lblNome: TLabel;
    dbeNome: TDBEdit;
    btnConexao: TButton;
    btnPais: TButton;
    btnAplicarManualmente: TButton;
    procedure cdsPaisIDGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure cdsPaisNewRecord(DataSet: TDataSet);
    procedure btnConexaoClick(Sender: TObject);
    procedure btnPaisClick(Sender: TObject);
    procedure cdsPaisReconcileError(DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
    procedure btnAplicarManualmenteClick(Sender: TObject);
  strict private
    FNovoID: Int32;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipalClient: TfrmPrincipalClient;

implementation

{$R *.dfm}

uses
  System.UITypes;

procedure TfrmPrincipalClient.btnConexaoClick(Sender: TObject);
begin
  try
    conDS.Close;
  except
    // este � um dos poucos casos que eu conhe�o que deve ter um except vazio
  end;

  conDS.Open;
end;

procedure TfrmPrincipalClient.btnPaisClick(Sender: TObject);
begin
  cdsPais.Close;
  cdsPais.Open;
end;

procedure TfrmPrincipalClient.btnAplicarManualmenteClick(Sender: TObject);
begin
  if cdsPais.ApplyUpdates(0) <> 0 then
  begin
    MessageDlg('Alguns registros n�o foram processados.', mtWarning, [mbOK], 0);
  end;
end;

procedure TfrmPrincipalClient.cdsPaisIDGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.AsInteger <= 0 then
  begin
    Text := '';
  end else
  begin
    Text := Sender.AsString;
  end;
end;

procedure TfrmPrincipalClient.cdsPaisNewRecord(DataSet: TDataSet);
begin
  Dec(FNovoID);
  cdsPaisID.AsInteger := FNovoID;
end;

procedure TfrmPrincipalClient.cdsPaisReconcileError(DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  MessageDlg('Erro ao salvar registro.' + E.Message, mtError, [mbOK], 0);
  Action := TReconcileAction.raAbort;
end;

end.