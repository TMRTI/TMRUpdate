unit uRegraClientes;

interface

uses
  System.Generics.Collections,
  uDadosClientes;

type
  TRegraClientes = class
  public
    function GetLista: TObjectList<TDadosCliente>;
    function GetCliente(const pIDCliente: TGUID): TDadosCliente;
    procedure Salvar(const pObjeto: TDadosCliente; const pLiberarObjeto: Boolean = True);
    function SalvarNovo(const pObjeto: TDadosCliente; const pLiberarObjeto: Boolean = True): TGUID;
    procedure Excluir(const pIDCliente: TGUID);
  end;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  Data.DB,
  FireDAC.Stan.Param,
  dConexaoBD;

{ TRegraClientes }

function TRegraClientes.GetLista: TObjectList<TDadosCliente>;
begin
  Result := TObjectList<TDadosCliente>.Create;

  try
    var lConexao := TdmdConexao.GetConexao;
    try
      var lQuery := lConexao.AbrirQuery('select ID, NOME from CLIENTE where ATIVO = ''S''');

      while not lQuery.EOF do
      begin
        var lCliente := TDadosCliente.Create;
        Result.Add(lCliente);

        lCliente.ID := lQuery.FieldByName('ID').AsGuid;
        lCliente.Nome := lQuery.FieldByName('NOME').AsString;
        lCliente.Ativo := True;

        lQuery.Next;
      end;
    finally
      TdmdConexao.LiberarConexao;
    end;
  except
    {#dica: lembre-se que, quando o resultado do método é um objeto, você deve inverter a proteção do try,
      somente liberando o objeto em caso de exceção, e provavelmente seja necessário dar um reraise na exception, como é o caso aqui.}
    Result.Free;
    raise;
  end;
end;

procedure TRegraClientes.Excluir(const pIDCliente: TGUID);
begin
  var lConexao := TdmdConexao.GetConexao;

  try
    lConexao.ExecutarQuery('delete from CLIENTE where ID = :ID',
      procedure(pParametros: TFDParams)
      begin
        pParametros.ParamByName('ID').AsGUID := pIDCliente;
      end);
  finally
    TdmdConexao.LiberarConexao;
  end;
end;

function TRegraClientes.GetCliente(const pIDCliente: TGUID): TDadosCliente;
begin
  var lConexao := TdmdConexao.GetConexao;
  try
    var lQuery := lConexao.AbrirQuery('select NOME, ATIVO from CLIENTE where ID = :ID',
      procedure(pParametros: TFDParams)
      begin
        pParametros.ParamByName('ID').AsGUID := pIDCliente;
      end);

    if lQuery.IsEmpty then
    begin
      raise Exception.CreateFmt('Cliente de código %s não encontrado.', [pIDCliente.ToString]);
    end;

    Result := TDadosCliente.Create;

    try
      Result.ID := pIDCliente;
      Result.Nome := lQuery.FieldByName('NOME').AsString;
      Result.Ativo := lQuery.FieldByName('ATIVO').AsString = 'S';
    except
      Result.Free;
      raise;
    end;
  finally
    TdmdConexao.LiberarConexao;
  end;
end;

procedure TRegraClientes.Salvar(const pObjeto: TDadosCliente; const pLiberarObjeto: Boolean);
begin
  try
    var lConexao := TdmdConexao.GetConexao;
    try
{#dica: lembrando que este método foi escrito visando atender a idempotência do comando put, onde o ID do objeto já é informado junto com o objeto,
  independentemente do mesmo ser novo, e neste usamos, utilizamos GUIDs como ID.}
      if lConexao.ExecutarQuery('update CLIENTE set NOME = :NOME, ATIVO = :ATIVO where ID = :ID',
        procedure(pParametros: TFDParams)
        begin
          pParametros.ParamByName('ID').AsGUID := pObjeto.ID;
          pParametros.ParamByName('NOME').AsString := pObjeto.Nome;
          pParametros.ParamByName('ATIVO').AsString := IfThen(pObjeto.Ativo, 'S', 'N');
        end) = 0 then
      begin
        if lConexao.ExecutarQuery('insert into CLIENTE (ID, NOME, ATIVO) values (:ID, :NOME, :ATIVO)',
          procedure(pParametros: TFDParams)
          begin
            pParametros.ParamByName('ID').AsGUID := pObjeto.ID;
            pParametros.ParamByName('NOME').AsString := pObjeto.Nome;
            pParametros.ParamByName('ATIVO').AsString := IfThen(pObjeto.Ativo, 'S', 'N');
          end) = 0 then
        begin
          raise Exception.Create('Não foi possível salvar o registro.');
        end;
      end;
    finally
      TdmdConexao.LiberarConexao;
    end;
  finally
    if pLiberarObjeto then
    begin
      pObjeto.Free;
    end;
  end;
end;

function TRegraClientes.SalvarNovo(const pObjeto: TDadosCliente; const pLiberarObjeto: Boolean): TGUID;
begin
  try
    var lConexao := TdmdConexao.GetConexao;
    try
{#dica: lembrando que este método foi escrito visando atender a idempotência do comando put, onde o ID do objeto já é informado junto com o objeto,
  independentemente do mesmo ser novo, e neste usamos, utilizamos GUIDs como ID.}
      Result := TGUID.NewGuid;

      pObjeto.ID := Result;

      if lConexao.ExecutarQuery('insert into CLIENTE (ID, NOME, ATIVO) values (:ID, :NOME, :ATIVO)',
        procedure(pParametros: TFDParams)
        begin
          pParametros.ParamByName('ID').AsGUID := pObjeto.ID;
          pParametros.ParamByName('NOME').AsString := pObjeto.Nome;
          pParametros.ParamByName('ATIVO').AsString := IfThen(pObjeto.Ativo, 'S', 'N');
        end) = 0 then
      begin
        raise Exception.Create('Não foi possível salvar o registro.');
      end;
    finally
      TdmdConexao.LiberarConexao;
    end;
  finally
    if pLiberarObjeto then
    begin
      pObjeto.Free;
    end;
  end;
end;

end.
