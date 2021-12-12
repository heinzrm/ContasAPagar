unit ContasAPagar.Dao.Cartoes;

interface

uses
  ContasAPagar.Interfaces.Dao.Cartoes,
  ContasAPagar.Model.Conexao,
  ContasAPagar.Model.Entity.Cartoes,
  System.SysUtils, FireDAC.Comp.DataSet,
  System.Generics.Collections;

type
  TDaoCartoes<T: class, constructor> = class(TInterfacedObject,IDaoCartoes<T>)
  private
    FConexao : TConexao;
  public
    constructor Create;
    destructor Destroy; override;
    class function New:IDaoCartoes<T>;
    function Select(pCartoes: T): IFDDataSetReference;
    procedure Delete(pChave: string);
    procedure Insert(pCartoes: T);
    procedure Update(pCartoes: T; pChave:string);
  end;

implementation

uses
  ContasAPagar.Diversos.RTTI;

{ TDaoCartoes }
//const
//  Tabela = 'CARTOES';

constructor TDaoCartoes<T>.Create;
begin
  inherited Create;

  FConexao := TConexao.Create;
end;

procedure TDaoCartoes<T>.Delete(pChave: string);
begin
//  try
//    FConexao.PrepareStatment(Format('DELETE %s WHERE IdCartoes = %s',[Tabela, QuotedStr(pChave)]));
//    FConexao.ExecSql;
//  except
//    on E:Exception do
//    begin
//      raise Exception.Create(E.Message);
//    end;
//  end;
end;

destructor TDaoCartoes<T>.Destroy;
begin
  FreeAndNil(FConexao);
  inherited;
end;

procedure TDaoCartoes<T>.Insert(pCartoes: T);
begin
//  FConexao.StartTransaction;
//  try
//    FConexao.PrepareStatment(TClassRtti.MontarInsert(pCartoes,Tabela));
//    FConexao.ExecSql;
//
//    FConexao.Commit;
//  except
//    on E:Exception do
//    begin
//      FConexao.RollBack;
//
//      raise Exception.Create(E.Message);
//    end;
//  end;
end;

class function TDaoCartoes<T>.New: IDaoCartoes<T>;
begin
  Result := Self.Create;
end;

function TDaoCartoes<T>.Select(pCartoes: T): IFDDataSetReference;
begin
//  FConexao.PrepareStatment(TClassRtti.MontarSelect(pCartoes,Tabela));
//  FConexao.Open;
//  Result := FConexao.RetornaDados;
end;

procedure TDaoCartoes<T>.Update(pCartoes: T; pChave:string);
begin
//  FConexao.PrepareStatment(TClassRtti.MontarUpDate(pCartoes,Tabela, pChave));
//  FConexao.ExecSql;
end;

end.
