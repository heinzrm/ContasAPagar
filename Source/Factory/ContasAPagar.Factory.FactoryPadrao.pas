unit ContasAPagar.Factory.FactoryPadrao;

interface

uses
  ContasAPagar.Factory.Interfaces,
  ContasAPagar.Model.Cartoes,
  ContasAPagar.Interfaces.Model.Cartoes,
  ContasAPagar.Model.Conexao;

type
  TFactory= class(TInterfacedObject, IFactory)
  public
    Class function New:IFactory;
    constructor Create;
    function FactoryCartoes: ICartoes;
  end;
implementation

{ TFactory }

constructor TFactory.Create;
begin
  inherited Create;

end;

function TFactory.FactoryCartoes: ICartoes;
begin
  Result := TModelCartoes.New;
end;

class function TFactory.New: IFactory;
begin
  Result := Self.Create;
end;

end.
