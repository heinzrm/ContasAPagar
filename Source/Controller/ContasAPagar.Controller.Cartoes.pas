unit ContasAPagar.Controller.Cartoes;

interface

uses
  ContasAPagar.Interfaces.Controller.Cartoes,
  ContasAPagar.Diversos.Enumerados,
  ContasAPagar.Factory.FactoryPadrao,
  ContasAPagar.Interfaces.Model.Cartoes,
  Data.DB,
  ContasAPagar.Model.Conexao;

type
  TControllerCartoes=class(TInterfacedObject,IControllerCartoes)
  public
    constructor Create;
    class function New:IControllerCartoes;
    function Tela(pTela: TTelas): ICartoes;
  end;

implementation

{ TControllerDao }

constructor TControllerCartoes.Create;
begin
  inherited Create;
end;

class function TControllerCartoes.New: IControllerCartoes;
begin
  Result := Self.Create;
end;

function TControllerCartoes.Tela(pTela: TTelas): ICartoes;
begin
  case  pTela of
    ttCartoes : Result := TFactory.New.FactoryCartoes;
  end;
end;

end.
