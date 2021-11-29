unit ContasAPagar.Controller.Intereface.ControllerDAO;

interface

uses
  Data.DB;

type
  IControllerDAO = interface
    ['{81FCF507-7E6E-483C-AACD-EF46C9BD4043}']
    procedure Editar;
    procedure Alterar;
    procedure Pesquisar;
    procedure Excluir;
    procedure Salvar(pState: TDataSetState);
    procedure Cancelar;
  end;
implementation

end.
