unit uServerMethodsUnit;

interface

uses
  System.SysUtils, System.Classes, System.Json, DataSnap.DSProviderDataModuleAdapter, Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Datasnap.Provider, FireDAC.Comp.DataSet, Datasnap.DBClient;

type
  TServerMethodsExemplo = class(TDSServerModule)
    conBD: TFDConnection;
    qryPais: TFDQuery;
    dspPais: TDataSetProvider;
    qryPaisID: TIntegerField;
    qryPaisNOME: TStringField;
    dtsPais: TDataSource;
    qryPaisPopulacao: TFDQuery;
    qryPaisPopulacaoID: TIntegerField;
    qryPaisPopulacaoID_PAIS: TIntegerField;
    qryPaisPopulacaoANO: TSmallintField;
    qryPaisPopulacaoPOPULACAO: TLargeintField;
    procedure dspPaisBeforeUpdateRecord(Sender: TObject; SourceDS: TDataSet; DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
      var Applied: Boolean);
  strict private
    FUltimoIDPais: Int32;
  private
    { Private declarations }
  public
    function GetDataHora: TDateTime;
  end;

implementation

{$R *.dfm}

{ TServerMethodsExemplo }

procedure TServerMethodsExemplo.dspPaisBeforeUpdateRecord(Sender: TObject; SourceDS: TDataSet; DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
  var Applied: Boolean);
var
  lFieldID: TField;
  lFieldIDPais: TField;
begin
  if UpdateKind = TUpdateKind.ukInsert then
  begin
    if SourceDS = qryPais then
    begin
      lFieldID := DeltaDS.FieldByName(qryPaisID.FieldName);
      FUltimoIDPais := conBD.ExecSQLScalar('select gen_id(GEN_PAIS_ID, 1) from RDB$DATABASE');
      lFieldID.NewValue := FUltimoIDPais;
    end else if SourceDS = qryPaisPopulacao then
    {#dica: todos as operações de dados (mestre e detalhe) passam pelo BeforeUpdateRecord do DSP,
      use o SourceDS para identificar qual o dataset que está sendo manipulado no momento.}
    begin
      lFieldID := DeltaDS.FieldByName(qryPaisPopulacaoID.FieldName);
      lFieldID.NewValue := conBD.ExecSQLScalar('select gen_id(GEN_PAIS_POPULACAO_ID, 1) from RDB$DATABASE');
      lFieldIDPais := DeltaDS.FieldByName(qryPaisPopulacaoID_PAIS.FieldName);

      if lFieldIDPais.AsInteger <= 0 then
      begin
        lFieldIDPais.NewValue := FUltimoIDPais;
      end;
    end;
  end;
end;

function TServerMethodsExemplo.GetDataHora: TDateTime;
begin
  Result := Now;
end;

end.

