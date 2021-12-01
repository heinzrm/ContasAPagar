unit ContasAPagar.Model.Interfaces.Cartoes;

interface

uses
  ContasAPagar.Model.Entity.Cartoes,
  Data.DB;

type
  ICartoes = interface
    ['{E14511D4-19B4-4977-BAE0-E538C276D177}']
    procedure Editar;
    procedure Alterar;
    procedure Pesquisar;
    procedure Excluir;
    procedure Salvar(pState: TDataSetState;pObject: TCartoes);
    procedure Cancelar;
  end;
implementation

end.
