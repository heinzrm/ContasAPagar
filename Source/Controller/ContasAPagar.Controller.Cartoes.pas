unit ContasAPagar.Controller.Cartoes;

interface

uses
  ContasAPagar.Interfaces.Controller.Cartoes,
  ContasAPagar.Diversos.Enumerados,
  ContasAPagar.Factory.FactoryPadrao,
  ContasAPagar.Interfaces.Model.Crud,
  Data.DB;

type
  TController<T> = class(TInterfacedObject,IControllerCartoes<T>)
  public
    constructor Create;
    class function New:IControllerCartoes<T>;
    function Tela(pTela: TTelas): ICrud<T>;
  end;

implementation

{ TControllerDao }

constructor TController<T>.Create;
begin
  inherited Create;
end;

class function TController<T>.New: IControllerCartoes<T>;
begin
  Result := Self.Create;
end;

function TController<T>.Tela(pTela: TTelas): ICrud<T>;
begin
  case  pTela of
    ttCartoes     : Result := TFactory<T>.New.FactoryCartoes;
    ttTipoReceitas: Result := TFactory<T>.New.FactoryReceitas;
    ttTipoDespesas: Result := TFactory<T>.New.FactoryDespesas;
  end;
end;

end.
