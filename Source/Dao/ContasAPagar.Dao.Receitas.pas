unit ContasAPagar.Dao.Receitas;

interface

uses
  ContasAPagar.Interfaces.Dao.Receitas,
  ContasAPagar.Model.Conexao,
  ContasAPagar.Model.Entity.Receita,
  System.SysUtils, FireDAC.Comp.DataSet;

type
  TDaoReceitas = class(TInterfacedObject,IDaoReceitas)
  private
    FConexao : TConexao;
  public
    constructor Create;
    destructor Destroy; override;
    function Select(pCartoes: TReceitas): IFDDataSetReference;
    procedure Delete(pChave: string);
    procedure Insert(pCartoes: TReceitas);
    procedure Update(pCartoes: TReceitas; pChave:string);
  end;

implementation

uses
  ContasAPagar.Diversos.RTTI;

{ TDaoCartoes }
const
  Tabela = 'CARTOES';

constructor TDaoReceitas.Create;
begin
  inherited Create;

  FConexao := TConexao.Create;
end;

procedure TDaoReceitas.Delete(pChave: string);
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

destructor TDaoReceitas.Destroy;
begin
  FreeAndNil(FConexao);
  inherited;
end;

procedure TDaoReceitas.Insert(pCartoes: TReceitas);
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

function TDaoReceitas.Select(pCartoes: TReceitas): IFDDataSetReference;
begin
  FConexao.PrepareStatment(TClassRtti.MontarSelect(pCartoes,Tabela));
  FConexao.Open;
  Result := FConexao.RetornaDados;
end;

procedure TDaoReceitas.Update(pCartoes: TReceitas; pChave:string);
begin
  FConexao.PrepareStatment(TClassRtti.MontarUpDate(pCartoes,Tabela, pChave));
  FConexao.ExecSql;
end;

end.
