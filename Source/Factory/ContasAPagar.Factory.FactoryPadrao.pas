unit ContasAPagar.Factory.FactoryPadrao;

interface

uses
  ContasAPagar.Factory.Interfaces,
  ContasAPagar.Model.Cartoes,
  ContasAPagar.Interfaces.Model.Crud,
  ContasAPagar.Model.Conexao,
  ContasAPagar.Model.TipoDespesas,
  ContasAPagar.Model.TipoReceitas;

type
  TFactory<T>= class(TInterfacedObject, IFactory<T>)
  public
    Class function New:IFactory<T>;
    constructor Create;
    function FactoryCartoes: ICrud<T>;
    function FactoryTipoReceitas: ICrud<T>;
    function FactoryTipoDespesas: ICrud<T>;
    function FactoryCategoria: ICrud<T>;
    function FactoryDespesa: ICrud<T>;
    function FactoryReceitas: ICrud<T>;
    end;

implementation

uses
  ContasAPagar.Model.Categoria,
  ContasAPagar.Model.Despesas,
  ContasAPagar.Model.Receitas;

{ TFactory }

constructor TFactory<T>.Create;
begin
  inherited Create;

end;

function TFactory<T>.FactoryCartoes: ICrud<T>;
begin
  Result := TModelCartoes<T>.New;
end;

function TFactory<T>.FactoryCategoria: ICrud<T>;
begin
  Result := TModelCategoria<T>.New
end;

function TFactory<T>.FactoryDespesa: ICrud<T>;
begin
  Result := TModelDespesas<T>.New;
end;

function TFactory<T>.FactoryReceitas: ICrud<T>;
begin
  Result := TModelReceitas<T>.New;
end;

function TFactory<T>.FactoryTipoDespesas: ICrud<T>;
begin
  Result := TModelTipoDespesas<T>.New
end;

function TFactory<T>.FactoryTipoReceitas: ICrud<T>;
begin
  Result := TModelTipoReceitas<T>.New;
end;

class function TFactory<T>.New: IFactory<T>;
begin
  Result := Self.Create;
end;

end.
