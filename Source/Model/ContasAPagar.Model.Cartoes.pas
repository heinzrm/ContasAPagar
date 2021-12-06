unit ContasAPagar.Model.Cartoes;

interface

uses
  ContasAPagar.Dao.Cartoes,
  ContasAPagar.Model.Entity.Cartoes,
  ContasAPagar.Interfaces.Model.Cartoes,
  ContasAPagar.Model.Conexao,
  Data.DB, FireDAC.Comp.DataSet;

type
  TModelCartoes= class(TInterfacedObject,ICartoes)
  private
    FDaoCartoes : TDaoCartoes;
  public
    Class function New:ICartoes;
    constructor Create;
    destructor Destroy; override;
    function Pesquisar(pObject: TCartoes): IFDDataSetReference;
    procedure Alterar;
    procedure Cancelar;
    procedure Editar;
    procedure Excluir(pChave: string);
    procedure Salvar(pState: TDataSetState; pObject: TCartoes; pChave: string);
   end;

implementation

uses
  System.SysUtils;

{ TCartoes }

procedure TModelCartoes.Alterar;
begin

end;

procedure TModelCartoes.Cancelar;
begin

end;

constructor TModelCartoes.Create;
begin
  inherited Create;

  FDaoCartoes := TDaoCartoes.Create;
end;

destructor TModelCartoes.Destroy;
begin
  FreeAndNil(FDaoCartoes);
  inherited;
end;

procedure TModelCartoes.Editar;
begin

end;

procedure TModelCartoes.Excluir(pChave: string);
begin
  FDaoCartoes.Delete(pChave)
end;

class function TModelCartoes.New: ICartoes;
begin
  Result := Self.Create;
end;

function TModelCartoes.Pesquisar(pObject: TCartoes): IFDDataSetReference;
begin
  Result:= FDaoCartoes.Select(pObject);
end;

procedure TModelCartoes.Salvar(pState: TDataSetState; pObject: TCartoes; pChave: string);
begin
  case pState of
    dsEdit   : FDaoCartoes.Update(pObject, pChave);
    dsInsert : FDaoCartoes.Insert(pObject);
  end;
end;

end.
