unit dConexaoBD;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, System.SyncObjs, System.Generics.Collections,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.DApt, FireDAC.Stan.Param;

type
  TdmdConexao = class(TDataModule)
    FDConnection: TFDConnection;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    procedure FDConnectionBeforeConnect(Sender: TObject);
  strict private
    FChamadas: UInt16;

    procedure IncrementarChamadas;
    function DecrementarChamadas: Boolean;

    class var FSecaoCritica: TCriticalSection;
    class var FConexoesEmUso: TObjectDictionary<TThreadID, TdmdConexao>;
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;

    function GetQuery(const pSQL: string = ''): TFDQuery;
    function AbrirQuery(const pSQL: string; const pTratadorParametros: TProc<TFDParams>): TFDQuery; overload;
    function AbrirQuery(const pSQL: string): TFDQuery; overload;
    function AbrirScalar<T>(const pSQL: string): T;
    function ExecutarQuery(const pSQL: string; const pTratadorParametros: TProc<TFDParams>): Int64; overload;
    function ExecutarQuery(const pSQL: string): Int64; overload;

    class constructor Create;
    class destructor Destroy;

{#dica: esta classe tem um exemplo de uso do recurso de pool de conexão do FireDAC, bem como um controle de recursividade.
  Para simplificar este exemplo, utilizamos class methods, mas em produção, visando casos mais complexos, como conexão com duas
  bases de dados diferentes, uma abordagem mais dinâmica pode ser necessária.}
    class function GetConexao: TdmdConexao;
    class procedure LiberarConexao;

    class procedure UsarConexao(const pMetodoUsoConexao: TProc<TdmdConexao>);
  end;

var
  dmdConexao: TdmdConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  System.Rtti;

{ TdmdConexao }

function TdmdConexao.AbrirQuery(const pSQL: string): TFDQuery;
begin
  Result := AbrirQuery(pSQL, nil);
end;

function TdmdConexao.AbrirScalar<T>(const pSQL: string): T;
begin
  var lQuery := AbrirQuery(pSQL);

  try
    Result := TValue.FromVariant(lQuery.Fields[0].AsVariant).AsType<T>;
  finally
    lQuery.Free;
  end;
end;

function TdmdConexao.AbrirQuery(const pSQL: string; const pTratadorParametros: TProc<TFDParams>): TFDQuery;
begin
  Result := GetQuery(pSQL);

  try
    if Assigned(pTratadorParametros) then
    begin
      pTratadorParametros(Result.Params);
    end;

    Result.Open;
  except
    Result.Free;
    raise;
  end;
end;

class constructor TdmdConexao.Create;
{#dica: este método configura os metadados para conexões com a base de testes, baseadas no conceito de pool.}
var
  lParametros: TStringList;
begin
  lParametros := TStringList.Create;

  try
{#dica: lembre-se de mudar este endereço do banco de dados}
    lParametros.Values['Database'] := 'TATU-SERVER:E:\DADOS\SGBDs\FB\TMR.fdb';
    lParametros.Values['User_Name'] := 'SYSDBA';
    lParametros.Values['Password'] := 'masterkey';
    lParametros.Values['Pooled'] := 'True';
    FDManager.AddConnectionDef('Update', 'FB', lParametros);
  finally
    lParametros.Free;
  end;

  FSecaoCritica := TCriticalSection.Create;
  FConexoesEmUso := TObjectDictionary<TThreadID, TdmdConexao>.Create([doOwnsValues]);
end;

constructor TdmdConexao.Create(AOwner: TComponent);
begin
  inherited;

  FDConnection.Open;
end;

function TdmdConexao.DecrementarChamadas: Boolean;
begin
  if FChamadas = 0 then
  begin
    raise Exception.Create('Inconsistência no número de chamadas da conexão.');
  end;

  Dec(FChamadas);

  Result := FChamadas = 0;
end;

class destructor TdmdConexao.Destroy;
begin
  FConexoesEmUso.Free;
  FSecaoCritica.Free;
end;

function TdmdConexao.ExecutarQuery(const pSQL: string): Int64;
begin
  Result := ExecutarQuery(pSQL, nil);
end;

function TdmdConexao.ExecutarQuery(const pSQL: string; const pTratadorParametros: TProc<TFDParams>): Int64;
begin
  var lQuery := GetQuery(pSQL);

  try
    if Assigned(pTratadorParametros) then
    begin
      pTratadorParametros(lQuery.Params);
    end;

    lQuery.ExecSQL;
    Result := lQuery.RowsAffected;
  finally
    lQuery.Free;
  end;
end;

procedure TdmdConexao.FDConnectionBeforeConnect(Sender: TObject);
begin
  FDConnection.ConnectionDefName := 'Update';
end;

class function TdmdConexao.GetConexao: TdmdConexao;
var
  lThreadID: TThreadID;
begin
  lThreadID := TThread.Current.ThreadID;

  FSecaoCritica.Enter;
  try
    if not FConexoesEmUso.TryGetValue(lThreadID, Result) then
    begin
      Result := TdmdConexao.Create(nil);
      FConexoesEmUso.Add(lThreadID, Result);
    end;
  finally
    FSecaoCritica.Leave;
  end;

  Result.IncrementarChamadas;
end;

function TdmdConexao.GetQuery(const pSQL: string): TFDQuery;
begin
  Result := TFDQuery.Create(Self);

  try
    Result.Connection := FDConnection;
    Result.SQL.Text := pSQL;
  except
    Result.Free;
    raise;
  end;
end;

procedure TdmdConexao.IncrementarChamadas;
begin
  Inc(FChamadas);
end;

class procedure TdmdConexao.LiberarConexao;
var
  lConexao: TdmdConexao;
  lThreadID: TThreadID;
begin
  lThreadID := TThread.Current.ThreadID;

  FSecaoCritica.Enter;
  try
    if FConexoesEmUso.TryGetValue(lThreadID, lConexao) and lConexao.DecrementarChamadas then
    begin
      FConexoesEmUso.Remove(lThreadID);
    end;
  finally
    FSecaoCritica.Leave;
  end;
end;

class procedure TdmdConexao.UsarConexao(const pMetodoUsoConexao: TProc<TdmdConexao>);
var
  lConexao: TdmdConexao;
begin
  lConexao := GetConexao;

  try
    pMetodoUsoConexao(lConexao);
  finally
    LiberarConexao;
  end;
end;

end.
