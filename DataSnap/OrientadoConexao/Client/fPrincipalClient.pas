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
    cdsPaisqryPaisPopulacao: TDataSetField;
    cdsPaisPopulacao: TClientDataSet;
    cdsPaisPopulacaoID: TIntegerField;
    cdsPaisPopulacaoID_PAIS: TIntegerField;
    cdsPaisPopulacaoANO: TSmallintField;
    cdsPaisPopulacaoPOPULACAO: TLargeintField;
    dtsPaisPopulacao: TDataSource;
    DBGrid1: TDBGrid;
    procedure cdsPaisIDGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure cdsPaisNewRecord(DataSet: TDataSet);
    procedure btnConexaoClick(Sender: TObject);
    procedure btnPaisClick(Sender: TObject);
    procedure cdsPaisReconcileError(DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
    procedure btnAplicarManualmenteClick(Sender: TObject);
    procedure cdsPaisPopulacaoNewRecord(DataSet: TDataSet);
    procedure cdsPaisBeforeDelete(DataSet: TDataSet);
  strict private
    FNovoID: Int32;

    function GetNovoID: Int32;
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
    // este é um dos poucos casos que eu conheço que deve ter um except vazio
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
    MessageDlg('Alguns registros não foram processados.', mtWarning, [mbOK], 0);
  end;
end;

procedure TfrmPrincipalClient.cdsPaisBeforeDelete(DataSet: TDataSet);
begin
  cdsPais.Edit;

  try
    while not cdsPaisPopulacao.IsEmpty do
    begin
      cdsPaisPopulacao.Delete;
    end;
    cdsPais.Post;
  except
    cdsPais.Cancel;
    raise;
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
  cdsPaisID.AsInteger := GetNovoID;
end;

procedure TfrmPrincipalClient.cdsPaisPopulacaoNewRecord(DataSet: TDataSet);
begin
  cdsPaisPopulacaoID.AsInteger := GetNovoID;
  cdsPaisPopulacaoID_PAIS.AsInteger := cdsPaisID.AsInteger;
end;

procedure TfrmPrincipalClient.cdsPaisReconcileError(DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  MessageDlg('Erro ao salvar registro.' + E.Message, mtError, [mbOK], 0);
  Action := TReconcileAction.raAbort;
end;

function TfrmPrincipalClient.GetNovoID: Int32;
begin
  Dec(FNovoID);
  Result := FNovoID;
end;

end.
