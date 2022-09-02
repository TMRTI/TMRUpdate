unit uValidacao.Intf;

interface

uses
  System.Classes;

type
  IValidacao = interface(IInterface)
    ['{A5281B84-996A-4ED4-93CB-E71B71BFFBBE}']

    function GetValidacoesFalhas: TStrings;

    property ValidacoesFalhas: TStrings read GetValidacoesFalhas;
  end;

implementation

end.
