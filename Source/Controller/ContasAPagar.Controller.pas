unit ContasAPagar.Controller;

interface

uses
  ContasAPagar.Interfaces.Controller,
  ContasAPagar.Diversos.Enumerados,
  ContasAPagar.Factory.FactoryPadrao,
  ContasAPagar.Interfaces.Model.Crud,
  Data.DB;

type
  TController<T> = class(TInterfacedObject,IController<T>)
  public
    constructor Create;
    class function New:IController<T>;
    function Tela(pTela: TTelas): ICrud<T>;
  end;

implementation

{ TControllerDao }

constructor TController<T>.Create;
begin
  inherited Create;
end;

class function TController<T>.New: IController<T>;
begin
  Result := Self.Create;
end;

function TController<T>.Tela(pTela: TTelas): ICrud<T>;
begin
  case  pTela of
    ttCartoes     : Result := TFactory<T>.New.FactoryCartoes;
    ttTipoReceitas: Result := TFactory<T>.New.FactoryTipoReceitas;
    ttTipoDespesas: Result := TFactory<T>.New.FactoryTipoDespesas;
    ttCategoria   : Result := TFactory<T>.New.FactoryCategoria;
    ttDespesa     : Result := TFactory<T>.New.FactoryDespesa;
    ttReceita     : Result := TFactory<T>.New.FactoryReceitas;
  end;
end;

end.
