unit ContasAPagar.Model.TipoReceitas;

interface

uses
  ContasAPagar.Model.Entity.TipoReceita,
  ContasAPagar.Interfaces.Model.Crud,
  ContasAPagar.Model.Conexao,
  Data.DB,
  FireDAC.Comp.DataSet,
  System.Generics.Collections,
  ContasAPagar.Dao.Generico;

type
  TModelTipoReceitas<T>= class(TInterfacedObject,ICrud<T>)
  private
    FDaoGenerico : TDaoGenerico<TTipoReceitas>;
  public
    Class function New: ICrud<T>;
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

{ TModelReceitas<T> }

constructor TModelTipoReceitas<T>.Create;
begin
  inherited Create;

  FDaoGenerico := TDaoGenerico<TTipoReceitas>.Create('TipoReceitas');
end;

destructor TModelTipoReceitas<T>.Destroy;
begin
  FreeAndNil(FDaoGenerico);
  inherited;
end;

procedure TModelTipoReceitas<T>.Excluir(pObject: TObject; pChave: string);
begin
  FDaoGenerico.Delete(pObject,pChave)
end;

class function TModelTipoReceitas<T>.New: ICrud<T>;
begin
  Result := Self.Create;
end;

function TModelTipoReceitas<T>.Pesquisar(pObject: TObject): IFDDataSetReference;
begin
  Result:= FDaoGenerico.Select(pObject);
end;

procedure TModelTipoReceitas<T>.Salvar(pState: TDataSetState; pObject: TObject; pChave: string);
begin
  case pState of
    dsEdit   : FDaoGenerico.Update(pObject, pChave);
    dsInsert : FDaoGenerico.Insert(pObject);
  end;
end;

end.
