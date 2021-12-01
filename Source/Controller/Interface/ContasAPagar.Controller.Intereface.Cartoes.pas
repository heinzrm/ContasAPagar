unit ContasAPagar.Controller.Intereface.Cartoes;

interface

uses
  Data.DB, ContasAPagar.Diversos.Enumerados,
  ContasAPagar.Model.Interfaces.Cartoes;

type
  IControllerCartoes = interface
    ['{81FCF507-7E6E-483C-AACD-EF46C9BD4043}']
    function Tela(pTEla: TTelas):ICartoes;
  end;
implementation

end.
