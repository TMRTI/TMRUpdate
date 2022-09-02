unit uCircuitoFechado;

interface

type
  ITitular = interface
    ['{9157EAD6-2B0B-4CAD-97E0-05D6C3101C36}']
  end;

  IDependente = interface
    ['{8C97D028-2AAC-4682-B0AA-D2D360B0EDAC}']
  end;

  TTitular = class(TInterfacedObject, ITitular)
  public
    FNome: string;
    FDataFiliacao: TDate;

    FDependente: IDependente;
  end;

  TDependente = class(TInterfacedObject, IDependente)
  public
    FNome: string;

    [weak] FTitular: ITitular;
  end;


implementation

end.
