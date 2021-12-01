unit ContasAPagar.Interfaces.Dao.Cartoes;

interface

uses
  ContasAPagar.Model.Entity.Cartoes;

type
  IDaoCartoes = interface
    ['{16D857F9-332F-43AA-81FF-B716B89015AB}']
    procedure Select;
    procedure Delete;
    procedure Insert(pCartoes: TCartoes);
    procedure Update();
  end;
implementation

end.
