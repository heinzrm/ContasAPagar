unit ContasAPagar.Model.Categoria;

interface

uses
  System.Generics.Collections,
  ContasAPagar.Dao.Generico,
  ContasAPagar.Model.Entity.Cartoes,
  ContasAPagar.Interfaces.Model.Crud,
  ContasAPagar.Model.Conexao,
  Data.DB, FireDAC.Comp.DataSet,
  ContasAPagar.Interfaces.Dao.Generico;

type
  TModelCategoria<T>= class(TInterfacedObject,ICrud<T>)
  private
    FDaoGenerico : IDaoGenerico<TCartoes>;
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

constructor TModelCategoria<T>.Create;
begin
  inherited Create;

  FDaoGenerico := TDaoGenerico<TCartoes>.Create('CATEGORIA');
end;

destructor TModelCategoria<T>.Destroy;
begin

  inherited;
end;

procedure TModelCategoria<T>.Excluir(pObject: TObject; pChave: string);
begin
  FDaoGenerico.Delete(pObject,pChave)
end;

class function TModelCategoria<T>.New: ICrud<T>;
begin
  Result := Self.Create;
end;

function TModelCategoria<T>.Pesquisar(pObject: TObject): IFDDataSetReference;
begin
  Result:= FDaoGenerico.Select(pObject);
end;

procedure TModelCategoria<T>.Salvar(pState: TDataSetState; pObject: TObject; pChave: string);
begin
  case pState of
    dsEdit   : FDaoGenerico.Update(pObject, pChave);
    dsInsert : FDaoGenerico.Insert(pObject);
  end;
end;

end.
