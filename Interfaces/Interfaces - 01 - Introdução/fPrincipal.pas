unit fPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses
  uEmissorBoleto.Intf;

procedure TForm2.Button1Click(Sender: TObject);
var
  lStream: TStream;
begin
  lStream := TEmissorBoletoPadrao.Implementacao.Emitir(
    TEmissorBoletoPadrao
      .CriarBuilderParametro
      .SetCodigoBanco(001)
      .SetDadosEmitente('TMR')
      .SetDadosPagador('Tatu')
      .SetNossoNumero(123)
      .SetValor(400)
      .Build
    );

  try

  finally
    lStream.Free;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  Exit;

  TThread.CreateAnonymousThread(
    procedure
    var
      lStream: TStream;
    begin
      lStream := TEmissorBoletoPadrao.Implementacao.Emitir(
        TEmissorBoletoPadrao
          .CriarBuilderParametro
          .SetCodigoBanco(001)
          .SetDadosEmitente('TMR')
          .SetDadosPagador('Tatu')
          .SetNossoNumero(123)
          .SetValor(400)
          .Build
        );
    end).Start;
end;

end.
