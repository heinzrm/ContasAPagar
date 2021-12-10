unit ContasAPagar.Interfaces.Dao.Receitas;

interface

uses
  ContasAPagar.Model.Entity.Receita,
  FireDAC.Comp.DataSet;

type
  IDaoReceitas = interface
    ['{16D857F9-332F-43AA-81FF-B716B89015AB}']
    function Select(pCartoes: TReceitas): IFDDataSetReference;
    procedure Delete(pChave: string);
    procedure Insert(pCartoes: TReceitas);
    procedure Update(pCartoes: TReceitas; pChave: string);
  end;
implementation

end.
