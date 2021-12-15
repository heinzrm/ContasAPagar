unit ContasAPagar.Factory.FactoryPadrao;

interface

uses
  ContasAPagar.Factory.Interfaces,
  ContasAPagar.Model.Cartoes,
  ContasAPagar.Interfaces.Model.Crud,
  ContasAPagar.Model.Conexao,
  ContasAPagar.Model.Despesas,
  ContasAPagar.Model.Receitas;

type
  TFactory<T>= class(TInterfacedObject, IFactory<T>)
  public
    Class function New:IFactory<T>;
    constructor Create;
    function FactoryCartoes: ICrud<T>;
    function FactoryReceitas: ICrud<T>;
    function FactoryDespesas: ICrud<T>;
    end;

implementation

{ TFactory }

constructor TFactory<T>.Create;
begin
  inherited Create;

end;

function TFactory<T>.FactoryCartoes: ICrud<T>;
begin
  Result := TModelCartoes<T>.New;
end;

function TFactory<T>.FactoryDespesas: ICrud<T>;
begin
  Result := TModelDespesas<T>.New
end;

function TFactory<T>.FactoryReceitas: ICrud<T>;
begin
  Result := TModelReceitas<T>.New;
end;

class function TFactory<T>.New: IFactory<T>;
begin
  Result := Self.Create;
end;

end.
