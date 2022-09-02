unit uPrimeiroExemplo.Impl;

interface

uses
  uPrimeiroExemplo.Intf;

type
  TClasseQueImplementaAPrimeiraInterface = class(TInterfacedObject, IMinhaPrimeiraInterface)
  public
    procedure Teste1;
  end;

implementation

{ TClasseQueImplementaAPrimeiraInterface }

procedure TClasseQueImplementaAPrimeiraInterface.Teste1;
begin

end;

end.
