unit ContasAPagar.Diversos.Conexao;

interface
  uses System.IniFiles,System.SysUtils,Vcl.Forms,FireDAC.Comp.Client, Vcl.Dialogs;

type
  TConexao = class
    private
      FPath:string;
      FServidor:string;
      FPorta:Integer;
      FDatabase:string;
      FSenha:string;
      FUsuario:string;
      FDriver:string;
      FSecao:string;
      FNomeConexao: string;
      FAuthSistema: string;
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
      procedure LeIni();virtual;
      procedure GravaIni(Usuario,Senha,Servidor,Banco:string;Porta:Integer);virtual;
      procedure Conectar(var Conexao:TFDConnection);virtual;
  end;
implementation

{ TConexao }

procedure TConexao.Conectar(var Conexao: TFDConnection);
begin
  LeIni();
  try
    Conexao.Connected := False;
    Conexao.LoginPrompt := False;
    Conexao.Params.Clear;
    Conexao.Params.Add('Server='+ Servidor);
    Conexao.Params.Add('user_name='+ Usuario);
    Conexao.Params.Add('password='+ Senha);
    Conexao.Params.Add('port='+ IntToStr(Porta));
    Conexao.Params.Add('Database='+ Database);
    Conexao.Params.Add('DriverID='+ Driver);
    Conexao.Params.Add('ConnectionName='+NomeConexao);
    Conexao.Params.Add('OSAuthent='+AuthSistema);
  Except
    on E:Exception do
      ShowMessage('Erro ao carregar parâmetros de conexão!'#13#10 + E.Message);
  end;
end;

// Método construtor recebe o caminho do INI e nome da Seção para Leitura
constructor TConexao.Create(Path: string; Secao: string);
begin
  if FileExists(Path) then
  begin
     Self.Path := Path;
     Self.Secao := Secao;
  end
  else
     raise Exception.Create('Arquivo INI para configuração não encontrado.'#13#10'Aplicação será finalizada.');
end;

// Grava os parâmetros recebidos no arquivo INI
procedure TConexao.GravaINI(Usuario, Senha, Servidor, Banco: string; Porta: integer);
var
  ArqIni : TIniFile;
begin
  ArqIni := TIniFile.Create(Path);
  try
    ArqIni.WriteString(Secao, 'Usuario', Usuario);
    ArqIni.WriteString(Secao, 'Senha', Senha);
    ArqIni.WriteString(Secao, 'Database', Banco);
    ArqIni.WriteString(Secao, 'Servidor', Servidor);
    ArqIni.WriteInteger(Secao, 'Porta', Porta);
  finally
     ArqIni.Free;
  end;
end;

// Lê os parâmetros do arquivo INI e atribui para os atributos
procedure TConexao.LeINI();
var
  ArqIni : TIniFile;
begin
  ArqIni := TIniFile.Create(Path);
  try
    Servidor    := ArqIni.ReadString(Secao, 'Servidor', '');
    Porta       := ArqIni.ReadInteger(Secao, 'Porta', 0);
    Database    := ArqIni.ReadString(Secao, 'Database', '');
    Senha       := ArqIni.ReadString(Secao, 'Senha', '');
    Usuario     := ArqIni.ReadString(Secao, 'Usuario', '');
    Driver      := ArqIni.ReadString(Secao, 'DriverID', '');
    NomeConexao := ArqIni.ReadString(Secao, 'NomeConexao', '');
    AuthSistema := ArqIni.ReadString(Secao, 'OSAuthent', '');
  finally
     ArqIni.Free;
  end;
end;

end.
