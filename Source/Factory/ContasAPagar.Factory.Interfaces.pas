unit ContasAPagar.Factory.Interfaces;

interface

uses
  ContasAPagar.Interfaces.Model.Crud,
  system.Generics.Collections;

type
  IFactory<T> = interface
    ['{99111A19-4D39-4CBE-997F-4149B667CC9C}']
    function FactoryCartoes:ICrud<T>;
    function FactoryReceitas:ICrud<T>;
  end;

implementation

end.
