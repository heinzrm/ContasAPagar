unit ContasAPagar.Diversos.Conexao;

interface

uses
  FireDAC.Comp.Client;

type
  TConexao = class
    private
      FServidor: string;
      FDriver: string;
      FPath: string;
      FAuthSistema: string;
      FSenha: string;
      FDatabase: string;
      FNomeConexao: string;
      FUsuario: string;
      FPorta: Integer;
      FSecao: string;
    public
      property Path:string read FPath write FPath;
      property Servidor:string read FServidor write FServidor;
      property Porta:Integer read FPorta write FPorta;
      property Database:string read FDatabase write FDatabase;
      property Senha:string read FSenha write FSenha;
      property Usuario:string read FUsuario write FUsuario;
      property Driver:string read FDriver write FDriver;
      property Secao:string read FSecao write FSecao;
      property NomeConexao:string read FNomeConexao write FNomeConexao;
      property AuthSistema:string read FAuthSistema write FAuthSistema;

      constructor Create(Path:string;Secao:string);
      procedure LeIni();
      procedure GravaIni(Usuario,Senha,Servidor,Banco:string;Porta:Integer);
      function Conectar(var Conexao: TFDConnection): Boolean;
  end;

implementation

uses
  System.SysUtils, System.IniFiles;

{ TConexao }

function TConexao.Conectar(var Conexao: TFDConnection): Boolean;
begin
  LeIni();
  try
    Conexao.Connected := False;
    Conexao.LoginPrompt := False;
    Conexao.Params.Clear;
    Conexao.ConnectionName := FNomeConexao;
    Conexao.DriverName := FDriver;
    Conexao.Params.Add(Format('HostName=%s',[FServidor]));
    Conexao.Params.Add(Format('user_name= %s',[FUsuario]));
    Conexao.Params.Add(Format('password= %s',[FSenha]));
    Conexao.Params.Add(Format('port= %s',[FPorta.ToString]));
    Conexao.Params.Add(Format('Database= %s',[FDatabase]));
    Conexao.Params.Add(Format('DriverName= %s',[FDriver]));
    Conexao.Params.Add(Format('OSAuthent= %s',[FAuthSistema]));
    Conexao.Open;
    Result := True;
  except
    on E:Exception do
    begin
      Result := False;
      raise Exception.Create('Erro ao carregar parâmetros de conexão!'#13#10 + E.Message);
    end;
  end;
end;

constructor TConexao.Create(Path, Secao: string);
begin
  if FileExists(Path) then
  begin
     Self.FPath  := Path;
     Self.FSecao := Secao;
  end
  else
  begin
    raise Exception.Create('Arquivo INI para configuração não encontrado.'#13#10'Aplicação será finalizada.');
  end;
end;

procedure TConexao.GravaIni(Usuario, Senha, Servidor, Banco: string;
  Porta: Integer);
var
  ArqIni : TIniFile;
begin
  ArqIni := TIniFile.Create(Path);
  try
    ArqIni.WriteString(Secao, 'Usuario', FUsuario);
    ArqIni.WriteString(Secao, 'Senha', FSenha);
    ArqIni.WriteString(Secao, 'Database', FDatabase);
    ArqIni.WriteString(Secao, 'Servidor', FServidor);
    ArqIni.WriteInteger(Secao, 'Porta', FPorta);
  finally
     ArqIni.Free;
  end;
end;

procedure TConexao.LeIni;
var
  ArqIni : TIniFile;
begin
  ArqIni := TIniFile.Create(Path);
  try
    FServidor    := ArqIni.ReadString(Secao, 'Servidor', '');
    FPorta       := ArqIni.ReadInteger(Secao, 'Porta', 0);
    FDatabase    := ArqIni.ReadString(Secao, 'Database', '');
    FSenha       := ArqIni.ReadString(Secao, 'Senha', '');
    FUsuario     := ArqIni.ReadString(Secao, 'Usuario', '');
    FDriver      := ArqIni.ReadString(Secao, 'Driver', '');
    FNomeConexao := ArqIni.ReadString(Secao, 'NomeConexao', '');
    FAuthSistema := ArqIni.ReadString(Secao, 'OSAuthent', '');
  finally
     ArqIni.Free;
  end;
end;

end.
