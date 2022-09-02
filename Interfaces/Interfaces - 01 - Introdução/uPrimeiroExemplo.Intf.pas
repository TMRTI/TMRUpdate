unit uPrimeiroExemplo.Intf;

interface

type
//  IMinhaPrimeiraInterface = interface
  IMinhaPrimeiraInterface = interface(IInterface)
    ['{82353B8A-5B5E-45C8-9DE1-D162C5F20A58}']

    procedure Teste1;
  end;

  IMinhaInterfaceEstendida = interface(IMinhaPrimeiraInterface)
    ['{C24CFF11-B6D0-4F33-9DFD-C724CF5EDC00}']

//    function SetQuantidadeTentativas(const pValor: Int32): IMinhaInterfaceEstendida;
  end;

//  IInterfaceQueNinguemImplementou =

implementation

end.
