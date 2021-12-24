unit ContasAPagar.Factory.Interfaces;

interface

uses
  ContasAPagar.Interfaces.Model.Crud;

type
  IFactory<T> = interface
    ['{99111A19-4D39-4CBE-997F-4149B667CC9C}']
    function FactoryCartoes:ICrud<T>;
    function FactoryReceitas:ICrud<T>;
    function FactoryTipoDespesas:ICrud<T>;
    function FactoryCategoria:ICrud<T>;
    function FactoryDespesa:ICrud<T>;
  end;

implementation

end.
