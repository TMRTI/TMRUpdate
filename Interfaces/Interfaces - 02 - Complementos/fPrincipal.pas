unit fPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uValidacao.Impl, uValidacao.Intf, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.AppEvnts;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Memo1: TMemo;
    Button6: TButton;
    Button7: TButton;
    Label1: TLabel;
    Timer1: TTimer;
    ApplicationEvents1: TApplicationEvents;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
  private
    FValidacao: IValidacao;
    FValidacao2: IValidacao;
//    [weak] FValidacao3: IValidacao;
    [unsafe] FValidacao3: IValidacao;

    procedure UsarValidacao(pValidacao: IValidacao);

    procedure RegistrarImplementacoes;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses uInjecoes, uBD.Estoque.Impl, uEstoque.Intf, uPedido.Impl, uPedido.Intf, fPedido, uREST.Estoque.Impl;

procedure TForm2.ApplicationEvents1Exception(Sender: TObject; E: Exception);
var
  lValidacao: IValidacao;
begin
  if Supports(E, IValidacao, lValidacao) then
    Memo1.Lines.Add('Erro de validação ' + E.Message + ': ' + lValidacao.ValidacoesFalhas.Text)
  else
    Memo1.Lines.Add('Erro genérico: ' + E.Message);
end;

procedure TForm2.Button10Click(Sender: TObject);
var
  lObjeto: TObject;
begin
  lObjeto := FValidacao as TObject;

  if Supports(lObjeto, IValidacao, FValidacao3) then
    Memo1.Lines.Add('converteu');
end;

procedure TForm2.Button11Click(Sender: TObject);
begin
  Form1.ShowModal;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  FValidacao := TValidacao.Create(
    procedure
    begin
      Memo1.Lines.Add('Destruindo objeto');
    end);
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  FValidacao := nil;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  UsarValidacao(FValidacao);
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  FValidacao2 := FValidacao;
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
  FValidacao2 := nil;
end;

procedure TForm2.Button6Click(Sender: TObject);
begin
  FValidacao3 := FValidacao;
end;

procedure TForm2.Button7Click(Sender: TObject);
begin
  FValidacao3 := nil;
end;

procedure TForm2.Button8Click(Sender: TObject);
begin
  raise Exception.Create('Erro customizado');
end;

procedure TForm2.Button9Click(Sender: TObject);
begin
  raise EValidacao.Create('Erro ao validar pessoa', 'Nome não foi preenchido');
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;

  RegistrarImplementacoes;
end;

procedure TForm2.RegistrarImplementacoes;
begin
  TInjecoes.InstanciaDefault.Registrar<IGerenciadorPedido>(TGerenciadorPedido.Create);
//  TInjecoes.InstanciaDefault.Registrar<IGerenciadorEstoque>(TGerenciadorEstoqueBD.Create);
  TInjecoes.InstanciaDefault.Registrar<IGerenciadorEstoque>(TGerenciadorEstoqueREST.Create);
end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
  if Assigned(FValidacao3) then
    Label1.Caption := 'Associado'
  else
    Label1.Caption := 'nil';
end;

procedure TForm2.UsarValidacao(pValidacao: IValidacao);
begin
  ShowMessage(pValidacao.ValidacoesFalhas.Text);
end;

end.
