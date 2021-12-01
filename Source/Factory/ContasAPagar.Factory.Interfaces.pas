unit ContasAPagar.Factory.Interfaces;

interface

uses
  ContasAPagar.Model.Interfaces.Cartoes;

type
  IFactory = interface
    ['{99111A19-4D39-4CBE-997F-4149B667CC9C}']
    function FactoryCartoes:ICartoes;
  end;

implementation

end.
