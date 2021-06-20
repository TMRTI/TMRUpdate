unit fPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.SyncObjs, System.Actions, Vcl.ActnList;

type
  TThreadDownloadFTP = class(TThread)
  private
    FExecutando: Boolean;
    FOnStart: TProc;
    FOnFinish: TProc;
    FOnError: TProc<string>;
    FCS: TCriticalSection;
    FTimeOut: Int32;

    FEvento: TEvent;

    procedure ExecutarOnStart;
    procedure ExecutarOnFinish;
    procedure ExecutarOnError(const pErro: string);
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Encerrar;

    procedure ExecutarAgora;

    procedure SetTimeOut(const pNovoTimeOut: Int32);

    property OnStart: TProc read FOnStart write FOnStart;
    property OnFinish: TProc read FOnFinish write FOnFinish;
    property OnError: TProc<string> read FOnError write FOnError;

    property Executando: Boolean read FExecutando;
  end;

  TfrmPrincipal = class(TForm)
    mmoLog: TMemo;
    btnExecutarAgora: TButton;
    aclPrincipal: TActionList;
    actExecutarAgora: TAction;
    lblLog: TLabel;
    mmoExplicacao: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actExecutarAgoraUpdate(Sender: TObject);
    procedure actExecutarAgoraExecute(Sender: TObject);
  private
    FThreadDownloadFTP: TThreadDownloadFTP;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

{ TThreadDownloadFTP }

constructor TThreadDownloadFTP.Create;
begin
  inherited Create(True);

  FEvento := TEvent.Create();
  FCS := TCriticalSection.Create;
  FTimeOut := 20000;
end;

destructor TThreadDownloadFTP.Destroy;
begin
  FCS.Free;
  FEvento.Free;

  inherited;
end;

procedure TThreadDownloadFTP.Encerrar;
begin
//  FIDFTP.Abortar;

  FEvento.SetEvent;
  Terminate;
  WaitFor;
end;

procedure TThreadDownloadFTP.ExecutarAgora;
begin
  FEvento.SetEvent;
end;

procedure TThreadDownloadFTP.ExecutarOnError(const pErro: string);
begin
  if Assigned(FOnError) then
  begin
    Synchronize(
      procedure
      begin
        FOnError(pErro);
      end);
  end;
end;

procedure TThreadDownloadFTP.ExecutarOnFinish;
begin
  if Assigned(FOnFinish) then
  begin
    Synchronize(
      procedure
      begin
        FOnFinish();
      end);
  end;
end;

procedure TThreadDownloadFTP.ExecutarOnStart;
begin
  if Assigned(FOnStart) then
  begin
    Synchronize(
      procedure
      begin
        FOnStart();
      end);
  end;
end;

procedure TThreadDownloadFTP.Execute;
begin
  inherited;

  Sleep(1000);

  while not Self.Terminated do
  begin
    FEvento.ResetEvent;

    FExecutando := True;

    try
      ExecutarOnStart;
      // faz o que tem que fazer
      Sleep(2000);

      if Random(2) = 0 then
        raise Exception.Create('Erro que aconteceu');

      ExecutarOnFinish;
    except
      on E: Exception do
      begin
        ExecutarOnError(E.Message);
      end;
    end;

    FExecutando := False;

    var lTimeOut: Int32;

    FCS.Enter;
    try
      lTimeOut := FTimeOut;
    finally
      FCS.Leave;
    end;

    FEvento.WaitFor(lTimeOut);
  end;
end;

procedure TThreadDownloadFTP.SetTimeOut(const pNovoTimeOut: Int32);
begin
  FCS.Enter;

  try
    FTimeOut := pNovoTimeOut;
  finally
    FCS.Leave;
  end;
end;

procedure TfrmPrincipal.actExecutarAgoraExecute(Sender: TObject);
begin
  FThreadDownloadFTP.ExecutarAgora;
end;

procedure TfrmPrincipal.actExecutarAgoraUpdate(Sender: TObject);
begin
  actExecutarAgora.Enabled := Assigned(FThreadDownloadFTP) and not FThreadDownloadFTP.Executando;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FThreadDownloadFTP := TThreadDownloadFTP.Create;
  FThreadDownloadFTP.OnStart :=
    procedure
    begin
      mmoLog.Lines.Add('começou');
    end;
  FThreadDownloadFTP.OnFinish :=
    procedure
    begin
      mmoLog.Lines.Add('terminou');
    end;
  FThreadDownloadFTP.OnError :=
    procedure(pErro: string)
    begin
      mmoLog.Lines.Add('erro: ' + pErro);
    end;
  FThreadDownloadFTP.FreeOnTerminate := False;
  FThreadDownloadFTP.Start;
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  if Assigned(FThreadDownloadFTP) then
  begin
    FThreadDownloadFTP.Encerrar;
    FThreadDownloadFTP.Free;
  end;
end;

end.
