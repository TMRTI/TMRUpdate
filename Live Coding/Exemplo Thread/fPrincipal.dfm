object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 
    'Exemplo de thread para execu'#231#227'o autom'#225'tica e recorrente de funci' +
    'onalidade'
  ClientHeight = 505
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
  DesignSize = (
    852
    505)
  PixelsPerInch = 96
  TextHeight = 13
  object lblLog: TLabel
    Left = 16
    Top = 8
    Width = 21
    Height = 13
    Caption = 'Log:'
  end
  object mmoLog: TMemo
    Left = 16
    Top = 27
    Width = 481
    Height = 470
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
  end
  object btnExecutarAgora: TButton
    Left = 520
    Top = 27
    Width = 313
    Height = 51
    Action = actExecutarAgora
    Anchors = [akTop, akRight]
    TabOrder = 1
  end
  object mmoExplicacao: TMemo
    Left = 520
    Top = 96
    Width = 313
    Height = 401
    Anchors = [akTop, akRight, akBottom]
    Lines.Strings = (
      'O objetivo deste exemplo '#233' realizar a execu'#231#227'o programada'
      '(de tempos em tempos) de uma funcionalidade que n'#227'o deve'
      'travar a thread principal.'
      ''
      'Ainda assim, o usu'#225'rio tem a op'#231#227'o de solicitar explicitamente '
      'que a funcionalidade seja executada, antes de chegar o novo '
      'momento de execu'#231#227'o programada.'
      ''
      'Para isto, este exemplo utiliza um TEvent, de forma a bloquear '
      'a thread at'#233' que estoure o time out programado, ou, seja'
      'solicitado explicitamente a quebra do bloqueio da thread pelo '
      'usu'#225'rio, e em ambos os casos, a thread volta a executar o '
      'que estava programada para fazer.')
    ParentColor = True
    ReadOnly = True
    TabOrder = 2
  end
  object aclPrincipal: TActionList
    Left = 440
    Top = 8
    object actExecutarAgora: TAction
      Caption = 'Execurtar Agora'
      OnExecute = actExecutarAgoraExecute
      OnUpdate = actExecutarAgoraUpdate
    end
  end
end
