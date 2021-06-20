unit fPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.AppEvnts, Vcl.StdCtrls, uMensagens;

type
  TfrmPrincipal = class(TForm)
    mmoLog: TMemo;
    apePrincipal: TApplicationEvents;
    btnSendMessage: TButton;
    edtDestinatario: TEdit;
    edtMeuHandle: TEdit;
    edtWParam: TEdit;
    btnProcessar: TButton;
    btnPostMessage: TButton;
    edtNomeJanela: TEdit;
    btnAtualizarNomeJanela: TButton;
    btnProcurarJanela: TButton;
    edtHandleApplication: TEdit;
    btnTamanhosDosRecords: TButton;
    ckbLogarMensagensRecebidas: TCheckBox;
    lblMeuHandle: TLabel;
    lblHandleApplication: TLabel;
    lblWParam: TLabel;
    edtLParam: TEdit;
    lblLParam: TLabel;
    procedure apePrincipalMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnSendMessageClick(Sender: TObject);
    procedure btnPostMessageClick(Sender: TObject);
    procedure btnAtualizarNomeJanelaClick(Sender: TObject);
    procedure btnProcessarClick(Sender: TObject);
    procedure btnProcurarJanelaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnTamanhosDosRecordsClick(Sender: TObject);
  strict private
    FContador: Int32;
    procedure TratarMinhaMensagem(var pMensagem: TMessage); message WM_MINHA_PRIMEIRA_MENSAGEM;
    function TratarMensagemJanelaEscondida(var Message: TMessage): Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.apePrincipalMessage(var Msg: tagMSG; var Handled: Boolean);
begin
  if ckbLogarMensagensRecebidas.Checked then
    mmoLog.Lines.Add('Handle: ' + IntToStr(Msg.hwnd) + ' Mensagem: ' + Msg.message.ToString);
end;

procedure TfrmPrincipal.btnSendMessageClick(Sender: TObject);
begin
  var lRespostaRecebida := SendMessage(StrToInt(edtDestinatario.Text), WM_MINHA_PRIMEIRA_MENSAGEM,
    StrToInt(edtWParam.Text), StrToInt(edtLParam.Text));
  mmoLog.Lines.Add('Enviei uma mensagem e recebi ' + lRespostaRecebida.ToString + ' como resposta.');
end;

procedure TfrmPrincipal.btnPostMessageClick(Sender: TObject);
begin
  PostMessage(StrToInt(edtDestinatario.Text), WM_MINHA_PRIMEIRA_MENSAGEM, StrToInt(edtWParam.Text), StrToInt(edtLParam.Text));
  mmoLog.Lines.Add('Postei uma mensagem.');
end;

procedure TfrmPrincipal.btnProcessarClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 1 to 15 do
  begin
    Sleep(1000);
//    Application.ProcessMessages;
  end;
end;

procedure TfrmPrincipal.btnProcurarJanelaClick(Sender: TObject);
begin
  edtDestinatario.Text := IntToStr(FindWindow(nil, PChar(edtNomeJanela.Text)));
end;

procedure TfrmPrincipal.btnTamanhosDosRecordsClick(Sender: TObject);
begin
  mmoLog.Lines.Add('Tamanho do record de TMSHMouseWheel ' + SizeOf(TMSHMouseWheel).ToString);
  mmoLog.Lines.Add('Tamanho do record de TMessage ' + SizeOf(TMessage).ToString);
end;

procedure TfrmPrincipal.btnAtualizarNomeJanelaClick(Sender: TObject);
begin
  Self.Caption := edtNomeJanela.Text;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  edtMeuHandle.Text := IntToStr(Self.Handle);
  edtHandleApplication.Text := IntToStr(Application.Handle);

  Application.HookMainWindow(TratarMensagemJanelaEscondida);
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  Application.UnhookMainWindow(TratarMensagemJanelaEscondida);
end;

function TfrmPrincipal.TratarMensagemJanelaEscondida(var Message: TMessage): Boolean;
begin
  Result := False;

  if Message.Msg = WM_MINHA_PRIMEIRA_MENSAGEM then
  begin
    Result := True;
    mmoLog.Lines.Add('Hook de mensagem da janela escondida funcionando.');
  end;
end;

procedure TfrmPrincipal.TratarMinhaMensagem(var pMensagem: TMessage);
begin
  Inc(FContador);

  mmoLog.Lines.Add(FContador.ToString + ' Recebi a minha mensagem: ' + pMensagem.WParam.ToString + ' ' +
    pMensagem.LParam.ToString);

  pMensagem.Result := NativeInt(pMensagem.WParam) * pMensagem.LParam;
end;

end.
