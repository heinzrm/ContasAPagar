unit ContasAPagar.Model.Receitas;

interface

uses
  System.Generics.Collections,
  ContasAPagar.Dao.Generico,
  ContasAPagar.Model.Entity.Receita,
  ContasAPagar.Interfaces.Model.Crud,
  ContasAPagar.Model.Conexao,
  Data.DB,
  FireDAC.Comp.DataSet,
  ContasAPagar.Interfaces.Dao.Generico;

type
  TModelReceitas<T>= class(TInterfacedObject,ICrud<T>)
  private
    FDaoGenerico : IDaoGenerico<TReceita>;
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

constructor TModelReceitas<T>.Create;
begin
  inherited Create;

  FDaoGenerico := TDaoGenerico<TReceita>.Create('RECEITA');
end;

destructor TModelReceitas<T>.Destroy;
begin

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
