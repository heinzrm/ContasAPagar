unit ContasAPagar.Dao.Cartoes;

interface

uses
  ContasAPagar.Interfaces.Dao.Cartoes,
  FireDAC.Comp.Client, ContasAPagar.Model.Entity.Cartoes, System.SysUtils,
  FireDAC.DApt;

type
  TDaoCartoes = class(TInterfacedObject,IDaoCartoes)
  private
    FConexao : TFDConnection;
  public
    constructor Create(pConexao: TFDConnection);
    procedure Select;
    procedure Delete;
    procedure Insert(pCartoes: TCartoes);
    procedure Update;
  end;

implementation

uses
  ContasAPagar.Diversos.RTTI;

{ TDaoCartoes }

constructor TDaoCartoes.Create(pConexao: TFDConnection);
begin
  inherited Create;

  FConexao := pConexao;
end;

procedure TDaoCartoes.Delete;
begin

end;

procedure TDaoCartoes.Insert(pCartoes: TCartoes);
var
  Qry : TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConexao;
    Qry.Open('select * from cartoes');

    TClassRtti.MontarInsert(pCartoes,'CARTOES');
//    Qry.Insert;
//    TClassRtti.AlimentaDataSet(Qry.DataSource.DataSet,pCartoes);
//    Qry.Post;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TDaoCartoes.Select;
begin

end;

procedure TDaoCartoes.Update;
begin

end;

end.
