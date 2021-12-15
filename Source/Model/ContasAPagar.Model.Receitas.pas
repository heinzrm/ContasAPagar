unit ContasAPagar.Model.Receitas;

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
  TModelReceitas<T>= class(TInterfacedObject,ICrud<T>)
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

constructor TModelReceitas<T>.Create;
begin
  inherited Create;

  FDaoGenerico := TDaoGenerico<TTipoReceitas>.Create('TipoReceitas');
end;

destructor TModelReceitas<T>.Destroy;
begin
  FreeAndNil(FDaoGenerico);
  inherited;
end;

procedure TModelReceitas<T>.Excluir(pObject: TObject; pChave: string);
begin
  FDaoGenerico.Delete(pObject,pChave)
end;

class function TModelReceitas<T>.New: ICrud<T>;
begin
  Result := Self.Create;
end;

function TModelReceitas<T>.Pesquisar(pObject: TObject): IFDDataSetReference;
begin
  Result:= FDaoGenerico.Select(pObject);
end;

procedure TModelReceitas<T>.Salvar(pState: TDataSetState; pObject: TObject; pChave: string);
begin
  case pState of
    dsEdit   : FDaoGenerico.Update(pObject, pChave);
    dsInsert : FDaoGenerico.Insert(pObject);
  end;
end;

end.