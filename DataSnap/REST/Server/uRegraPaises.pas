unit uRegraPaises;

interface

uses
  System.Generics.Collections,
  uDadosPais;

type
  TRegraPaises = class
  public
    function GetLista: TObjectList<TDadosPais>;
    function GetPais(const pIDPais: Int32): TDadosPais;
    procedure Salvar(const pObjeto: TDadosPais; const pLiberarObjeto: Boolean = True);
  end;

implementation

uses
  System.SysUtils,
  Data.DB,
  FireDAC.Stan.Param,
  dConexaoBD;

{ TRegraPaises }

function TRegraPaises.GetLista: TObjectList<TDadosPais>;
begin
  Result := TObjectList<TDadosPais>.Create;

  try
    var lConexao := TdmdConexao.GetConexao;
    try
      var lQuery := lConexao.AbrirQuery('select ID, NOME from PAIS');

      while not lQuery.EOF do
      begin
        var lPais := TDadosPais.Create;
        Result.Add(lPais);

        lPais.ID := lQuery.FieldByName('ID').AsInteger;
        lPais.Nome := lQuery.FieldByName('NOME').AsString;

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

function TRegraPaises.GetPais(const pIDPais: Int32): TDadosPais;
begin
  var lConexao := TdmdConexao.GetConexao;
  try
    var lQuery := lConexao.AbrirQuery('select NOME from PAIS where ID = :ID',
      procedure(pParametros: TFDParams)
      begin
        pParametros.ParamByName('ID').AsInteger := pIDPais;
      end);

    if lQuery.IsEmpty then
    begin
      raise Exception.CreateFmt('País de código %d não encontrado.', [pIDPais]);
    end;

    Result := TDadosPais.Create;

    try
      Result.ID := pIDPais;
      Result.Nome := lQuery.FieldByName('NOME').AsString;
    except
      Result.Free;
      raise;
    end;
  finally
    TdmdConexao.LiberarConexao;
  end;
end;

procedure TRegraPaises.Salvar(const pObjeto: TDadosPais; const pLiberarObjeto: Boolean);
begin
  try
    var lConexao := TdmdConexao.GetConexao;
    try
      if lConexao.ExecutarQuery('update PAIS set NOME = :NOME where ID = :ID',
        procedure(pParametros: TFDParams)
        begin
          pParametros.ParamByName('ID').AsInteger := pObjeto.ID;
          pParametros.ParamByName('NOME').AsString := pObjeto.Nome;
        end) = 0 then
      begin
{#dica: lembrando que, pela filosofia do put idempotente, o ID já deve ser definido no client, aqui estou usando integer, mas,
  outros tipos de dados são comumente utilizados, como GUIDs}
        if lConexao.ExecutarQuery('insert into PAIS (ID, NOME) value (:ID, :NOME)',
          procedure(pParametros: TFDParams)
          begin
            pParametros.ParamByName('ID').AsInteger := pObjeto.ID;
            pParametros.ParamByName('NOME').AsString := pObjeto.Nome;
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

end.
