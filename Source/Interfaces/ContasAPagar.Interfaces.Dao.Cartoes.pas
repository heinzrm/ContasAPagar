unit ContasAPagar.Interfaces.Dao.Cartoes;

interface

uses
  ContasAPagar.Model.Entity.Cartoes,
  FireDAC.Comp.DataSet;

type
  IDaoCartoes = interface
    ['{16D857F9-332F-43AA-81FF-B716B89015AB}']
    function Select(pCartoes: TCartoes): IFDDataSetReference;
    procedure Delete(pChave: string);
    procedure Insert(pCartoes: TCartoes);
    procedure Update(pCartoes: TCartoes; pChave: string);
  end;
implementation

end.
