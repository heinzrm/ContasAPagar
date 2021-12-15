unit ContasAPagar.Interfaces.Dao.Generico;

interface

uses

  FireDAC.Comp.DataSet;

type
  IDaoGenerico<T> = interface
    ['{16D857F9-332F-43AA-81FF-B716B89015AB}']
    function Select(pObject: TObject): IFDDataSetReference;
    procedure Delete(pObject: TObject; pChave: string);
    procedure Insert(pObject: TObject);
    procedure Update(pObject: TObject; pChave: string);
  end;
implementation

end.
