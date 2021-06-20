object ServerMethodsExemplo: TServerMethodsExemplo
  OldCreateOrder = False
  Height = 357
  Width = 554
  object conBD: TFDConnection
    Params.Strings = (
      'Database=TATU-SERVER:E:\DADOS\SGBDs\FB\TMR.FDB'
      'Password=masterkey'
      'User_Name=SYSDBA'
      'DriverID=FB')
    LoginPrompt = False
    Left = 72
    Top = 48
  end
  object qryPais: TFDQuery
    Connection = conBD
    SQL.Strings = (
      'select'
      '  ID'
      ' ,NOME'
      'from'
      '  PAIS')
    Left = 72
    Top = 112
    object qryPaisID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryPaisNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 32
    end
  end
  object dspPais: TDataSetProvider
    DataSet = qryPais
    Options = [poPropogateChanges, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    BeforeUpdateRecord = dspPaisBeforeUpdateRecord
    Left = 72
    Top = 176
  end
  object dtsPais: TDataSource
    DataSet = qryPais
    Left = 144
    Top = 112
  end
  object qryPaisPopulacao: TFDQuery
    IndexFieldNames = 'ID_PAIS'
    MasterSource = dtsPais
    MasterFields = 'ID'
    DetailFields = 'ID_PAIS'
    Connection = conBD
    SQL.Strings = (
      'select'
      '  ID'
      ' ,ID_PAIS'
      ' ,ANO'
      ' ,POPULACAO'
      'FROM'
      '  PAIS_POPULACAO')
    Left = 144
    Top = 176
    object qryPaisPopulacaoID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryPaisPopulacaoID_PAIS: TIntegerField
      FieldName = 'ID_PAIS'
      Origin = 'ID_PAIS'
      Required = True
    end
    object qryPaisPopulacaoANO: TSmallintField
      FieldName = 'ANO'
      Origin = 'ANO'
      Required = True
    end
    object qryPaisPopulacaoPOPULACAO: TLargeintField
      FieldName = 'POPULACAO'
      Origin = 'POPULACAO'
      Required = True
    end
  end
end
