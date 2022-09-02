object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 723
  ClientWidth = 617
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 504
    Width = 322
    Height = 17
    Caption = 'Label1'
  end
  object Button1: TButton
    Left = 376
    Top = 8
    Width = 233
    Height = 45
    Caption = 'Instanciar Validacao'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 376
    Top = 111
    Width = 233
    Height = 46
    Caption = 'Liberar Validacao'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 376
    Top = 59
    Width = 233
    Height = 46
    Caption = 'Usar Interface'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 376
    Top = 163
    Width = 233
    Height = 46
    Caption = 'Capturar FValidacao para FValidacao2'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 376
    Top = 215
    Width = 233
    Height = 50
    Caption = 'Liberar FValidacao2'
    TabOrder = 4
    OnClick = Button5Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 337
    Height = 481
    Lines.Strings = (
      'Memo1')
    TabOrder = 5
  end
  object Button6: TButton
    Left = 376
    Top = 271
    Width = 233
    Height = 46
    Caption = 'Capturar FValidacao para FValidacao3'
    TabOrder = 6
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 376
    Top = 323
    Width = 233
    Height = 50
    Caption = 'Liberar FValidacao3'
    TabOrder = 7
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 376
    Top = 379
    Width = 233
    Height = 54
    Caption = 'Disparar Exception'
    TabOrder = 8
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 376
    Top = 439
    Width = 233
    Height = 50
    Caption = 'Disparar EValidacao'
    TabOrder = 9
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 376
    Top = 495
    Width = 233
    Height = 50
    Caption = 'FValidacao > FValidacao3 com Supports'
    TabOrder = 10
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 224
    Top = 584
    Width = 233
    Height = 25
    Caption = 'Fazer Pedido'
    TabOrder = 11
    OnClick = Button11Click
  end
  object Timer1: TTimer
    Interval = 250
    OnTimer = Timer1Timer
    Left = 312
    Top = 496
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    Left = 88
    Top = 552
  end
end
