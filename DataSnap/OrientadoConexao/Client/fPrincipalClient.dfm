object frmPrincipalClient: TfrmPrincipalClient
  Left = 0
  Top = 0
  Caption = 'Cliente DS Orientado '#224' Conex'#227'o'
  ClientHeight = 427
  ClientWidth = 701
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object dbgPais: TDBGrid
    Left = 0
    Top = 0
    Width = 701
    Height = 209
    Align = alClient
    DataSource = dtsPais
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Visible = True
      end>
  end
  object pnlDados: TPanel
    Left = 0
    Top = 234
    Width = 701
    Height = 115
    Align = alBottom
    TabOrder = 2
    object lblCodigo: TLabel
      Left = 24
      Top = 8
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
      FocusControl = dbeCodigo
    end
    object lblNome: TLabel
      Left = 24
      Top = 48
      Width = 27
      Height = 13
      Caption = 'Nome'
      FocusControl = dbeNome
    end
    object dbeCodigo: TDBEdit
      Left = 24
      Top = 24
      Width = 134
      Height = 21
      DataField = 'ID'
      DataSource = dtsPais
      TabOrder = 0
    end
    object dbeNome: TDBEdit
      Left = 24
      Top = 64
      Width = 420
      Height = 21
      DataField = 'NOME'
      DataSource = dtsPais
      TabOrder = 1
    end
    object btnConexao: TButton
      Left = 528
      Top = 22
      Width = 145
      Height = 25
      Caption = 'Conex'#227'o'
      TabOrder = 2
      OnClick = btnConexaoClick
    end
    object btnPais: TButton
      Left = 528
      Top = 62
      Width = 145
      Height = 25
      Caption = 'Abrir Pa'#237'ses'
      TabOrder = 3
      OnClick = btnPaisClick
    end
    object btnAplicarManualmente: TButton
      Left = 328
      Top = 24
      Width = 145
      Height = 25
      Caption = 'Aplicar Delta Manualmente'
      TabOrder = 4
      OnClick = btnAplicarManualmenteClick
    end
  end
  object dbnPais: TDBNavigator
    Left = 0
    Top = 209
    Width = 701
    Height = 25
    DataSource = dtsPais
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbPost, nbCancel, nbRefresh, nbApplyUpdates, nbCancelUpdates]
    Align = alBottom
    TabOrder = 1
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 349
    Width = 701
    Height = 78
    Align = alBottom
    DataSource = dtsPaisPopulacao
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ANO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'POPULACAO'
        Visible = True
      end>
  end
  object conDS: TSQLConnection
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXDataSnap'
      'HostName=localhost'
      'Port=211'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=24.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'Filters={}')
    Left = 72
    Top = 48
  end
  object dspServerMethodsExemplo: TDSProviderConnection
    ServerClassName = 'TServerMethodsExemplo'
    SQLConnection = conDS
    Left = 72
    Top = 112
  end
  object cdsPais: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPais'
    RemoteServer = dspServerMethodsExemplo
    BeforeDelete = cdsPaisBeforeDelete
    OnNewRecord = cdsPaisNewRecord
    OnReconcileError = cdsPaisReconcileError
    Left = 72
    Top = 168
    object cdsPaisID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      OnGetText = cdsPaisIDGetText
    end
    object cdsPaisNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Origin = 'NOME'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 32
    end
    object cdsPaisqryPaisPopulacao: TDataSetField
      FieldName = 'qryPaisPopulacao'
    end
  end
  object dtsPais: TDataSource
    DataSet = cdsPais
    Left = 72
    Top = 224
  end
  object cdsPaisPopulacao: TClientDataSet
    Aggregates = <>
    DataSetField = cdsPaisqryPaisPopulacao
    Params = <>
    OnNewRecord = cdsPaisPopulacaoNewRecord
    Left = 144
    Top = 168
    object cdsPaisPopulacaoID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsPaisPopulacaoID_PAIS: TIntegerField
      FieldName = 'ID_PAIS'
      Origin = 'ID_PAIS'
      Required = True
    end
    object cdsPaisPopulacaoANO: TSmallintField
      DisplayLabel = 'Ano'
      FieldName = 'ANO'
      Origin = 'ANO'
      Required = True
    end
    object cdsPaisPopulacaoPOPULACAO: TLargeintField
      DisplayLabel = 'Popula'#231#227'o'
      FieldName = 'POPULACAO'
      Origin = 'POPULACAO'
      Required = True
      DisplayFormat = '0,'
    end
  end
  object dtsPaisPopulacao: TDataSource
    DataSet = cdsPaisPopulacao
    Left = 144
    Top = 224
  end
end
