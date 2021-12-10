unit ContasAPagar.Controller.Cartoes;

interface

uses
  ContasAPagar.Interfaces.Controller.Cartoes,
  ContasAPagar.Diversos.Enumerados,
  ContasAPagar.Factory.FactoryPadrao,
  ContasAPagar.Interfaces.Model.Crud,
  Data.DB,
  ContasAPagar.Model.Conexao,
  system.Generics.Collections;

type
  TControllerCartoes<T> = class(TInterfacedObject,IControllerCartoes<T>)
  public
    constructor Create;
    class function New:IControllerCartoes<T>;
    function Tela(pTela: TTelas): ICrud<T>;
  end;

implementation

{ TControllerDao }

constructor TControllerCartoes<T>.Create;
begin
  inherited Create;
end;

class function TControllerCartoes<T>.New: IControllerCartoes<T>;
begin
  Result := Self.Create;
end;

function TControllerCartoes<T>.Tela(pTela: TTelas): ICrud<T>;
begin
  case  pTela of
    ttCartoes : Result := TFactory<T>.New.FactoryCartoes;
    ttReceitas: Result := TFactory<T>.New.FactoryCartoes;
  end;
end;

end.
