unit ContasAPagar.Model.Despesas;

interface

uses
  System.Generics.Collections,
  ContasAPagar.Dao.Generico,
  ContasAPagar.Model.Entity.Despesa,
  ContasAPagar.Interfaces.Model.Crud,
  ContasAPagar.Model.Conexao,
  Data.DB,
  FireDAC.Comp.DataSet,
  ContasAPagar.Interfaces.Dao.Generico;

type
  TModelDespesas<T>= class(TInterfacedObject,ICrud<T>)
  private
    FDaoGenerico : IDaoGenerico<TDespesa>;
  public
    Class function New:ICrud<T>;
    constructor Create;
    destructor Destroy; override;
    procedure Excluir(pObject: TObject; pChave: string);
    function Pesquisar(pObject: TObject): IFDDataSetReference;
    procedure Salvar(pState: TDataSetState; pObject: TObject; pChave: string);

  end;

implementation

uses
  System.SysUtils;

{ TCartoes }

constructor TModelDespesas<T>.Create;
begin
  inherited Create;

  FDaoGenerico := TDaoGenerico<TDespesa>.Create('DESPESA');
end;

destructor TModelDespesas<T>.Destroy;
begin

  inherited;
end;

procedure TModelDespesas<T>.Excluir(pObject: TObject; pChave: string);
begin
  FDaoGenerico.Delete(pObject,pChave)
end;

class function TModelDespesas<T>.New: ICrud<T>;
begin
  Result := Self.Create;
end;

function TModelDespesas<T>.Pesquisar(pObject: TObject): IFDDataSetReference;
begin
  Result:= FDaoGenerico.Select(pObject);
end;

procedure TModelDespesas<T>.Salvar(pState: TDataSetState; pObject: TObject; pChave: string);
begin
  case pState of
    dsEdit   : FDaoGenerico.Update(pObject, pChave);
    dsInsert : FDaoGenerico.Insert(pObject);
  end;
end;
end.
