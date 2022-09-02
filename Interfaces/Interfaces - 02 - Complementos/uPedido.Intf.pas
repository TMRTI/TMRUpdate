unit uPedido.Intf;

interface

type
  IPedido = interface
    ['{B6B4AC68-E423-4D4A-A24C-647CF9A0A67C}']


  end;

  IGerenciadorPedido = interface
    ['{3E75792D-185D-41F9-BB2D-30867A24DAE8}']

    procedure ProcessarPedido(pPedido: IPedido);
  end;

implementation

end.
