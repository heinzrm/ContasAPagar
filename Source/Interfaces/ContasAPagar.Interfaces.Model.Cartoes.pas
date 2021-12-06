unit ContasAPagar.Interfaces.Model.Cartoes;

interface

uses
  ContasAPagar.Model.Entity.Cartoes,
  Data.DB, FireDAC.Comp.DataSet;

type
  ICartoes = interface
    ['{E14511D4-19B4-4977-BAE0-E538C276D177}']
    function Pesquisar(pObject: TCartoes): IFDDataSetReference;
    procedure Alterar;
    procedure Cancelar;
    procedure Editar;
    procedure Excluir(pChave: string);
    procedure Salvar(pState: TDataSetState;pObject: TCartoes; pChave: string);
  end;
implementation

end.
