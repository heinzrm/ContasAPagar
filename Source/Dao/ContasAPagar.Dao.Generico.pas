unit ContasAPagar.Dao.Generico;

interface

uses
  ContasAPagar.Interfaces.Dao.Generico,
  ContasAPagar.Model.Conexao,

  System.SysUtils,
  FireDAC.Comp.DataSet;

type
  TDaoGenerico<T: class, constructor> = class(TInterfacedObject,IDaoGenerico<T>)
  private
    FConexao : TConexao;
    FTabela  : string;
  public
    constructor Create(pTabela : string);
    destructor Destroy; override;
    class function New(pTabela : string):IDaoGenerico<T>;
    function Select(pObject: TObject): IFDDataSetReference;
    procedure Delete(pObject: TObject; pChave: string);
    procedure Insert(pObject: TObject);
    procedure Update(pObject: TObject; pChave:string);
  end;

implementation

uses
  ContasAPagar.Diversos.RTTI;

{ TDaoGenerico }

constructor TDaoGenerico<T>.Create(pTabela : string);
begin
  inherited Create;

  FConexao := TConexao.Create;
  FTabela  := pTabela;
end;

procedure TDaoGenerico<T>.Delete(pObject: TObject; pChave: string);
begin
  try
    FConexao.PrepareStatment(Format('DELETE %s WHERE %s = %s',[FTabela, TClassRtti<T>.BuscaChavePrimaria(pObject), QuotedStr(pChave)]));
    FConexao.ExecSql;
  except
    on E:Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

destructor TDaoGenerico<T>.Destroy;
begin
  FreeAndNil(FConexao);
  inherited;
end;

procedure TDaoGenerico<T>.Insert(pObject: TObject);
begin
  FConexao.StartTransaction;
  try
    FConexao.PrepareStatment(TClassRtti<T>.MontarInsert(pObject,FTabela));
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

class function TDaoGenerico<T>.New(pTabela : string): IDaoGenerico<T>;
begin
  Result := Self.Create(pTabela);
end;

function TDaoGenerico<T>.Select(pObject: TObject): IFDDataSetReference;
begin
  FConexao.PrepareStatment(TClassRtti<T>.MontarSelect(pObject,FTabela));
  FConexao.Open;
  Result := FConexao.RetornaDados;
end;

procedure TDaoGenerico<T>.Update(pObject: TObject; pChave:string);
begin
  FConexao.PrepareStatment(TClassRtti<T>.MontarUpDate(pObject,FTabela, pChave));
  FConexao.ExecSql;
end;

end.
