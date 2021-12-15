unit ContasAPagar.Interfaces.Model.Crud;

interface

uses
  Data.DB,
  FireDAC.Comp.DataSet;

type
  ICrud<T> = interface
    ['{E956C7EC-51F6-4715-B7C3-4B55ACBE3806}']
    function Pesquisar(pObject: TObject): IFDDataSetReference;
    procedure Excluir(pObject: TObject; pChave: string);
    procedure Salvar(pState: TDataSetState;pObject: TObject; pChave: string);
  end;

implementation

end.
