unit ContasAPagar.Dao.Cartoes;

interface

uses
  ContasAPagar.Interfaces.Dao.Cartoes,
  ContasAPagar.Model.Conexao,
  ContasAPagar.Model.Entity.Cartoes,
  System.SysUtils, FireDAC.Comp.DataSet;

type
  TDaoCartoes = class(TInterfacedObject,IDaoCartoes)
  private
    FConexao : TConexao;
  public
    constructor Create;
    destructor Destroy; override;
    function Select(pCartoes: TCartoes): IFDDataSetReference;
    procedure Delete(pChave: string);
    procedure Insert(pCartoes: TCartoes);
    procedure Update(pCartoes: TCartoes; pChave:string);
  end;

implementation

uses
  ContasAPagar.Diversos.RTTI;

{ TDaoCartoes }
const
  Tabela = 'CARTOES';

constructor TDaoCartoes.Create;
begin
  inherited Create;

  FConexao := TConexao.Create;
end;

procedure TDaoCartoes.Delete(pChave: string);
begin
  try
    FConexao.PrepareStatment(Format('DELETE %s WHERE IdCartoes = %s',[Tabela, QuotedStr(pChave)]));
    FConexao.ExecSql;
  except
    on E:Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

destructor TDaoCartoes.Destroy;
begin
  FreeAndNil(FConexao);
  inherited;
end;

procedure TDaoCartoes.Insert(pCartoes: TCartoes);
begin
  FConexao.StartTransaction;
  try
    FConexao.PrepareStatment(TClassRtti.MontarInsert(pCartoes,Tabela));
    FConexao.ExecSql;

    FConexao.Commit;
  except
    on E:Exception do
    begin
      FConexao.RollBack;

      raise Exception.Create(E.Message);
    end;
  end;
end;

function TDaoCartoes.Select(pCartoes: TCartoes): IFDDataSetReference;
begin
  FConexao.PrepareStatment(TClassRtti.MontarSelect(pCartoes,Tabela));
  FConexao.Open;
  Result := FConexao.RetornaDados;
end;

procedure TDaoCartoes.Update(pCartoes: TCartoes; pChave:string);
begin
  FConexao.PrepareStatment(TClassRtti.MontarUpDate(pCartoes,Tabela, pChave));
  FConexao.ExecSql;
end;

end.
