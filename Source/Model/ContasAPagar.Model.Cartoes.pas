unit ContasAPagar.Model.Cartoes;

interface

uses
  System.Generics.Collections,
  ContasAPagar.Dao.Cartoes,
  ContasAPagar.Model.Entity.Cartoes,
  ContasAPagar.Interfaces.Model.Crud,
  ContasAPagar.Model.Conexao,
  Data.DB, FireDAC.Comp.DataSet,
  ContasAPagar.Interfaces.Dao.Cartoes;

type
  TModelCartoes<T>= class(TInterfacedObject,ICrud<T>)
  private
//    FDaoCartoes : IDaoCartoes<?>;
  public
    Class function New:ICrud<T>;
    constructor Create;
    destructor Destroy; override;
    procedure Alterar;
    procedure Cancelar;
    procedure Editar;
    procedure Excluir(pChave: string);
    function Pesquisar(pObject: T): IFDDataSetReference;
    procedure Salvar(pState: TDataSetState; pObject: T; pChave: string);

  end;

implementation

uses
  System.SysUtils;

{ TCartoes }

procedure TModelCartoes<T>.Alterar;
begin

end;

procedure TModelCartoes<T>.Cancelar;
begin

end;

constructor TModelCartoes<T>.Create;
begin
  inherited Create;

//  FDaoCartoes := TDaoCartoes<T>.Create;
end;

destructor TModelCartoes<T>.Destroy;
begin

  inherited;
end;

procedure TModelCartoes<T>.Editar;
begin

end;

procedure TModelCartoes<T>.Excluir(pChave: string);
begin
//  FDaoCartoes.Delete(pChave)
end;

class function TModelCartoes<T>.New: ICrud<T>;
begin
  Result := Self.Create;
end;

function TModelCartoes<T>.Pesquisar(pObject: T): IFDDataSetReference;
begin
  Result:= TDaoCartoes<T>.New.Select(pObject);
end;

procedure TModelCartoes<T>.Salvar(pState: TDataSetState; pObject: T; pChave: string);
begin
//  case pState of
//    dsEdit   : FDaoCartoes.Update(pObject, pChave);
//    dsInsert : FDaoCartoes.Insert(pObject);
//  end;
end;

end.
