unit ContasAPagar.Model.Cartoes;

interface

uses
  ContasAPagar.Dao.Cartoes,
  ContasAPagar.Model.Entity.Cartoes,
  ContasAPagar.Model.Interfaces.Cartoes,
  Data.DB,
  FireDAC.Comp.Client;

type
  TModelCartoes= class(TInterfacedObject,ICartoes)
  private
    FDaoCartoes : TDaoCartoes;
    FConexao : TFDConnection;
  public
    Class function New(pConexao: TFDConnection):ICartoes;
    constructor Create(pConexao: TFDConnection);
    destructor Destroy; override;
    procedure Alterar;
    procedure Cancelar;
    procedure Editar;
    procedure Excluir;
    procedure Pesquisar;
    procedure Salvar(pState: TDataSetState; pObject: TCartoes);
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

constructor TModelCartoes.Create(pConexao: TFDConnection);
begin
  inherited Create;
  FConexao := pConexao;

  FDaoCartoes := TDaoCartoes.Create(FConexao);
end;

destructor TModelCartoes.Destroy;
begin
  FreeAndNil(FDaoCartoes);
  inherited;
end;

procedure TModelCartoes.Editar;
begin

end;

procedure TModelCartoes.Excluir;
begin

end;

class function TModelCartoes.New(pConexao: TFDConnection): ICartoes;
begin
  Result := Self.Create(pConexao);
end;

procedure TModelCartoes.Pesquisar;
begin

end;

procedure TModelCartoes.Salvar(pState: TDataSetState; pObject: TCartoes);
begin
  case pState of
    dsEdit: FDaoCartoes.Update;
    dsInsert: FDaoCartoes.Insert(pObject);
  end;
end;

end.
