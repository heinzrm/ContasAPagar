unit ContasAPagar.Controller.ControllerDAO;

interface

uses
  ContasAPagar.Controller.Intereface.ControllerDAO,
  ContasAPagar.Diversos.Enumerados,
  Data.DB;

type
  TControllerDao=class(TInterfacedObject,IControllerDAO)
  public
    constructor Create(pTela: TTelas);
    procedure Editar;
    procedure Alterar;
    procedure Pesquisar;
    procedure Excluir;
    procedure Salvar(pState: TDataSetState);
    procedure Cancelar;
  end;

implementation

{ TControllerDao }

procedure TControllerDao.Alterar;
begin

end;

procedure TControllerDao.Cancelar;
begin

end;

constructor TControllerDao.Create(pTela: TTelas);
begin
  inherited Create;
end;

procedure TControllerDao.Editar;
begin

end;

procedure TControllerDao.Excluir;
begin

end;

procedure TControllerDao.Pesquisar;
begin

end;

procedure TControllerDao.Salvar(pState: TDataSetState);
begin
  case pState of
    dsEdit: ;
    dsInsert: ;
  end;
end;

end.
