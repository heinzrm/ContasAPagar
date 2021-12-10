unit ContasAPagar.Interfaces.Model.Crud;

interface

uses
  Data.DB,
  FireDAC.Comp.DataSet,
  System.Generics.Collections;

type
  ICrud<T> = interface
    ['{E956C7EC-51F6-4715-B7C3-4B55ACBE3806}']
    function Pesquisar(pObject: T): IFDDataSetReference;
    procedure Alterar;
    procedure Cancelar;
    procedure Editar;
    procedure Excluir(pChave: string);
    procedure Salvar(pState: TDataSetState;pObject: T; pChave: string);
  end;

implementation

end.
