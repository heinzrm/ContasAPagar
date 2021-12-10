unit ContasAPagar.Interfaces.Model.Receitas;

interface

uses
  ContasAPagar.Model.Entity.Receita,
  Data.DB,
  FireDAC.Comp.DataSet,
  System.Generics.Collections;

type
  IReceita = interface
    ['{E14511D4-19B4-4977-BAE0-E538C276D177}']
    function Pesquisar(pObject: TReceitas): IFDDataSetReference;
    procedure Alterar;
    procedure Cancelar;
    procedure Editar;
    procedure Excluir(pChave: string);
    procedure Salvar(pState: TDataSetState;pObject: TReceitas; pChave: string);
  end;
implementation

end.

