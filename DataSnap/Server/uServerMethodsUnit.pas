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
    procedure dspPaisBeforeUpdateRecord(Sender: TObject; SourceDS: TDataSet; DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
      var Applied: Boolean);
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
begin
  if UpdateKind = TUpdateKind.ukInsert then
  begin
    lFieldID := DeltaDS.FieldByName(qryPaisID.FieldName);
    lFieldID.NewValue := conBD.ExecSQLScalar('select gen_id(GEN_PAIS_ID, 1) from RDB$DATABASE');
  end;
end;

function TServerMethodsExemplo.GetDataHora: TDateTime;
begin
  Result := Now;
end;

end.

