unit ContasAPagar.Interfaces.Dao.Cartoes;

interface

uses
  ContasAPagar.Model.Entity.Cartoes,
  FireDAC.Comp.DataSet,
  System.Generics.Collections;

type
  IDaoCartoes<T> = interface
    ['{16D857F9-332F-43AA-81FF-B716B89015AB}']
    function Select(pCartoes: T): IFDDataSetReference;
    procedure Delete(pChave: string);
    procedure Insert(pCartoes: T);
    procedure Update(pCartoes: T; pChave: string);
  end;
implementation

end.
