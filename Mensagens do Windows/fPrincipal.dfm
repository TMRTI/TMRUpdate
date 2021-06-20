object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Mensagens do Windows'
  ClientHeight = 573
  ClientWidth = 852
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblMeuHandle: TLabel
    Left = 432
    Top = 53
    Width = 75
    Height = 13
    Caption = 'Handle do Form'
  end
  object lblHandleApplication: TLabel
    Left = 607
    Top = 53
    Width = 194
    Height = 13
    Caption = 'Handle da janela escondida (Application)'
  end
  object lblWParam: TLabel
    Left = 432
    Top = 213
    Width = 40
    Height = 13
    Caption = 'WParam'
  end
  object lblLParam: TLabel
    Left = 607
    Top = 213
    Width = 35
    Height = 13
    Caption = 'LParam'
  end
  object mmoLog: TMemo
    Left = 24
    Top = 24
    Width = 377
    Height = 521
    TabOrder = 0
  end
  object btnSendMessage: TButton
    Left = 607
    Top = 114
    Width = 161
    Height = 33
    Caption = 'Send Message'
    TabOrder = 5
    OnClick = btnSendMessageClick
  end
  object edtDestinatario: TEdit
    Left = 432
    Top = 120
    Width = 169
    Height = 21
    TabOrder = 4
    Text = 'Destinat'#225'rio'
  end
  object edtMeuHandle: TEdit
    Left = 432
    Top = 72
    Width = 169
    Height = 21
    ParentColor = True
    ReadOnly = True
    TabOrder = 2
  end
  object edtWParam: TEdit
    Left = 432
    Top = 232
    Width = 169
    Height = 21
    TabOrder = 7
    Text = '10'
  end
  object btnProcessar: TButton
    Left = 432
    Top = 379
    Width = 344
    Height = 33
    Caption = 'Processar'
    TabOrder = 12
    OnClick = btnProcessarClick
  end
  object btnPostMessage: TButton
    Left = 607
    Top = 153
    Width = 161
    Height = 33
    Caption = 'Post Message'
    TabOrder = 6
    OnClick = btnPostMessageClick
  end
  object edtNomeJanela: TEdit
    Left = 432
    Top = 272
    Width = 169
    Height = 21
    TabOrder = 9
    Text = 'Nome Janela'
  end
  object btnAtualizarNomeJanela: TButton
    Left = 616
    Top = 270
    Width = 161
    Height = 25
    Caption = 'Atualizar Nome Janela'
    TabOrder = 10
    OnClick = btnAtualizarNomeJanelaClick
  end
  object btnProcurarJanela: TButton
    Left = 616
    Top = 301
    Width = 161
    Height = 25
    Caption = 'Procurar Janela'
    TabOrder = 11
    OnClick = btnProcurarJanelaClick
  end
  object edtHandleApplication: TEdit
    Left = 607
    Top = 72
    Width = 169
    Height = 21
    ParentColor = True
    ReadOnly = True
    TabOrder = 3
  end
  object btnTamanhosDosRecords: TButton
    Left = 432
    Top = 431
    Width = 344
    Height = 34
    Caption = 'Tamanhos dos Records'
    TabOrder = 13
    OnClick = btnTamanhosDosRecordsClick
  end
  object ckbLogarMensagensRecebidas: TCheckBox
    Left = 432
    Top = 26
    Width = 265
    Height = 17
    Caption = 'Logar Mensagens Recebidas'
    TabOrder = 1
  end
  object edtLParam: TEdit
    Left = 607
    Top = 232
    Width = 169
    Height = 21
    TabOrder = 8
    Text = '5'
  end
  object apePrincipal: TApplicationEvents
    OnMessage = apePrincipalMessage
    Left = 320
    Top = 48
  end
end
