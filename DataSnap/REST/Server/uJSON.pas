unit uJSON;

interface

uses
  System.TypInfo,
  System.Rtti,
  System.Generics.Collections,
  System.JSON;

type
  TJSON = class
  strict private
    class var FContextoRTTI: TRttiContext;
  public
    class constructor Create;
    class destructor Destroy;

    class function ConverterValorParaJSON(const pValue: TValue): TJSONValue; overload;
    class function ConverterValorParaJSON<T>(const pItem: T): TJSONValue; overload; inline;
    class function ConverterObjetoParaJSON(const pObjeto: TObject): TJSONValue;

    class function ConverterListaParaArray<T>(const pLista: TList<T>): TJSONArray;
    class function ConsumirListaComoArray<T>(const pLista: TList<T>): TJSONArray;

    class function ConverterJSONParaValor(const pTipoEsperado: PTypeInfo; const pValor: TJSONValue): TValue;
    class function ConverterJSONParaObjeto<T: class, constructor>(const pObjeto: TJSONValue): T;
  end;

implementation

uses
  System.SysUtils;

{ TJSON }

class function TJSON.ConsumirListaComoArray<T>(const pLista: TList<T>): TJSONArray;
begin
  try
    Result := ConverterListaParaArray<T>(pLista);
  finally
    pLista.Free;
  end;
end;

class function TJSON.ConverterValorParaJSON(const pValue: TValue): TJSONValue;
begin
  case pValue.Kind of
    tkClass:
      Result := ConverterObjetoParaJSON(pValue.AsObject);
    tkInteger:
      Result := TJSONNumber.Create(pValue.AsOrdinal);
    tkString, tkUString:
      Result := TJSONString.Create(pValue.AsString);
    tkRecord:
      if pValue.TypeInfo = TypeInfo(TGUID) then
      begin
        Result := TJSONString.Create(pValue.AsType<TGUID>.ToString);
      end else
      begin
        raise Exception.CreateFmt('Tipo não previsto ao converter record para JSON (%s).', [GetTypeName(pValue.TypeInfo)]);
      end;
    tkEnumeration:
      if pValue.TypeInfo = TypeInfo(Boolean) then
      begin
        if pValue.AsBoolean then
        begin
          Result := TJSONTrue.Create;
        end else
        begin
          Result := TJSONFalse.Create;
        end;
      end else
      begin
        raise Exception.CreateFmt('Tipo não previsto ao converter emnumerado para JSON (%s).', [GetTypeName(pValue.TypeInfo)]);
      end;
  else
    raise Exception.CreateFmt('Tipo não previsto ao converter item para JSON (%s).', [GetEnumname(TypeInfo(TTypeKind), Integer(pValue.Kind))]);
  end;
end;

class function TJSON.ConverterValorParaJSON<T>(const pItem: T): TJSONValue;
begin
  Result := ConverterValorParaJSON(TValue.From<T>(pItem));
end;

class function TJSON.ConverterJSONParaObjeto<T>(const pObjeto: TJSONValue): T;
var
  lField: TRttiField;
  lNomeField: string;
  lValorJSON: TJSONValue;
begin
  if pObjeto is TJSONNull then
  begin
    Result := nil;
  end else if pObjeto is TJSONObject then
  begin
    Result := T.Create;

    try
      for lField in FContextoRTTI.GetType(T).GetFields do
      begin
        lNomeField := lField.Name;
        if lNomeField.StartsWith('F') then
        begin
          lNomeField := lNomeField.Substring(1, lNomeField.Length - 1);
        end;

        if pObjeto.TryGetValue<TJSONValue>(lNomeField, lValorJSON) then
        begin
          lField.SetValue(Pointer(Result), ConverterJSONParaValor(lField.FieldType.Handle, lValorJSON));
        end;
      end;
    except
      Result.Free;
      raise;
    end;
  end else
  begin
    raise Exception.Create(pObjeto.ClassName + ' não é um tipo capaz de ser convertido em um objeto do tipo ' + T.QualifiedClassName + '.');
  end;
end;

class function TJSON.ConverterJSONParaValor(const pTipoEsperado: PTypeInfo; const pValor: TJSONValue): TValue;
begin
  case pTipoEsperado^.Kind of
    tkInteger:
      Result := TValue.From<Int32>((pValor as TJSONNumber).AsInt);
    tkString, tkUString:
      Result := TValue.From<string>((pValor as TJSONString).Value);
    tkRecord:
      if pTipoEsperado = TypeInfo(TGUID) then
      begin
        Result := TValue.From<TGUID>(TGUID.Create((pValor as TJSONString).Value))
      end else
      begin
        raise Exception.CreateFmt('Tipo de record (%s) não esperado ao converter um valor JSON.', [GetTypeName(pTipoEsperado)]);
      end;
    tkEnumeration:
      if pTipoEsperado = TypeInfo(Boolean) then
      begin
        Result := TValue.From<Boolean>(pValor is TJSONTrue);
      end else
      begin
        raise Exception.CreateFmt('Tipo de enumerado (%s) não esperado ao converter um valor JSON.', [GetTypeName(pTipoEsperado)]);
      end;
  else
    raise Exception.CreateFmt('Tipo de dado (%s) não esperado ao converter um valor JSON.', [GetTypeName(pTipoEsperado)]);
  end;
end;

class function TJSON.ConverterListaParaArray<T>(const pLista: TList<T>): TJSONArray;
var
  lItem: T;
begin
  Result := TJSONArray.Create;

  try
    for lItem in pLista do
    begin
      Result.AddElement(ConverterValorParaJSON<T>(lItem));
    end;
  except
    Result.Free;
    raise;
  end;
end;

class function TJSON.ConverterObjetoParaJSON(const pObjeto: TObject): TJSONValue;
var
  lField: TRttiField;
  lNomeField: string;
  lObjeto: TJSONObject;
begin
  if Assigned(pObjeto) then
  begin
    lObjeto := TJSONObject.Create;

    try
      for lField in FContextoRTTI.GetType(pObjeto.ClassType).GetFields do
      begin
        lNomeField := lField.Name;
        if lNomeField.StartsWith('F') then
        begin
          lNomeField := lNomeField.Substring(1, lNomeField.Length - 1);
        end;

        lObjeto.AddPair(lNomeField, ConverterValorParaJSON(lField.GetValue(pObjeto)));
      end;
    except
      lObjeto.Free;
      raise;
    end;

    Result := lObjeto;
  end else
  begin
    Result := TJSONNull.Create;
  end;
end;

class constructor TJSON.Create;
begin
  FContextoRTTI := TRttiContext.Create;
end;

class destructor TJSON.Destroy;
begin
  FContextoRTTI.Free;
end;

end.
