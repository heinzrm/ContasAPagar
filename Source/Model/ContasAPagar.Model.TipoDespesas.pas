unit ContasAPagar.Model.TipoDespesas;

interface

uses
  ContasAPagar.Model.Entity.TipoDespesa,
  ContasAPagar.Interfaces.Model.Crud,
  ContasAPagar.Model.Conexao,
  Data.DB,
  FireDAC.Comp.DataSet,
  System.Generics.Collections,
  ContasAPagar.Dao.Generico;

type
  TModelTipoDespesas<T>= class(TInterfacedObject,ICrud<T>)
  private
    FDaoGenerico : TDaoGenerico<TTipoDespesas>;
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

{ TModelReceitas<T> }

constructor TModelTipoDespesas<T>.Create;
begin
  inherited Create;

  FDaoGenerico := TDaoGenerico<TTipoDespesas>.Create('TipoDespesas');
end;

destructor TModelTipoDespesas<T>.Destroy;
begin
  FreeAndNil(FDaoGenerico);
  inherited;
end;

procedure TModelTipoDespesas<T>.Excluir(pObject: TObject; pChave: string);
begin
  FDaoGenerico.Delete(pObject,pChave)
end;

class function TModelTipoDespesas<T>.New: ICrud<T>;
begin
  Result := Self.Create;
end;

function TModelTipoDespesas<T>.Pesquisar(pObject: TObject): IFDDataSetReference;
begin
  Result:= FDaoGenerico.Select(pObject);
end;

procedure TModelTipoDespesas<T>.Salvar(pState: TDataSetState; pObject: TObject; pChave: string);
begin
  case pState of
    dsEdit   : FDaoGenerico.Update(pObject, pChave);
    dsInsert : FDaoGenerico.Insert(pObject);
  end;
end;

end.
