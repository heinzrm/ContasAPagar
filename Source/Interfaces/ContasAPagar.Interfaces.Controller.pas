unit ContasAPagar.Interfaces.Controller;

interface

uses
  Data.DB,
  ContasAPagar.Diversos.Enumerados,
  ContasAPagar.Interfaces.Model.Crud;

type
  IController<T> = interface
    ['{81FCF507-7E6E-483C-AACD-EF46C9BD4043}']
    function Tela(pTEla: TTelas):ICrud<T>;
  end;

implementation

end.
