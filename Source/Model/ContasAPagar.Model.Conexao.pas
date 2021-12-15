unit ContasAPagar.Model.Conexao;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.FMXUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  fmx.Forms,
  FireDAC.Phys.MSSQL,
  FireDAC.DApt,
  ContasAPagar.Diversos.Conexao,
  FireDAC.Stan.Param,
  FireDAC.Comp.DataSet;

type
  TConexao = class
    FConexao        : TFDConnection;
    FQuery          : TFDQuery;
    FConexaoInicial : TConexaoInicial;
  public
    constructor Create;
    destructor Destroy; override;
    function RetornaDados: IFDDataSetReference;
    procedure ConfigurarConexao;
    procedure PrepareStatment(pSql: string);
    procedure SetValue(pIndex: Integer; pValue: Variant);
    procedure ExecSql;
    procedure StartTransaction;
    procedure Commit;
    procedure RollBack;
    procedure Open;
  end;
implementation

uses
  System.SysUtils;

{ TConexao }

procedure TConexao.Commit;
begin
  FConexao.Commit;
end;

procedure TConexao.ConfigurarConexao;
begin
  try
    FConexaoInicial   := TConexaoInicial.Create(Format('%s\config.ini',[GetCurrentDir]),'Conexao');
    FConexaoInicial.Conectar(FConexao);
  except
    on E:exception do
    begin
      Application.Terminate;
      DisposeOf;
      raise Exception.Create(E.Message);
    end;
  end;
end;

constructor TConexao.Create;
begin
  inherited Create;

  FConexao := TFDConnection.Create(nil);
  FQuery   := TFDQuery.Create(nil);

  FQuery.Connection := FConexao;

  ConfigurarConexao;
end;

destructor TConexao.Destroy;
begin
  FreeAndNil(FQuery);
  FreeAndNil(FConexao);
  FreeAndNil(FConexaoInicial);
  inherited;
end;

procedure TConexao.ExecSql;
begin
  FQuery.ExecSQL;
end;

procedure TConexao.Open;
begin
  FQuery.Open;
end;

procedure TConexao.PrepareStatment(pSql: string);
begin
  FQuery.SQL.Clear;
  FQuery.SQL.Add(pSql);
end;

function TConexao.RetornaDados: IFDDataSetReference;
begin
  Result := FQuery.Data;
end;

procedure TConexao.RollBack;
begin
  FConexao.Rollback;
end;

procedure TConexao.SetValue(pIndex: Integer; pValue: Variant);
begin
  FQuery.Params.Add;
  FQuery.Params[pIndex].Value := pValue;
end;

procedure TConexao.StartTransaction;
begin
  FConexao.StartTransaction;
end;

end.
