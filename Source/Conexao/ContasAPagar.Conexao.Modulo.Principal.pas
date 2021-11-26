unit ContasAPagar.Conexao.Modulo.Principal;

interface

uses
  System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client;

type
  TdmPrincipal = class(TDataModule)
    fdConexao: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmPrincipal: TdmPrincipal;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses
  ContasAPagar.Diversos.Conexao,
  ContasAPagar.Diversos.Variaveis,
  System.SysUtils;

{$R *.dfm}

procedure TdmPrincipal.DataModuleCreate(Sender: TObject);
begin
  FConexao := TConexao.Create(GetCurrentDir+'\config.ini','Conexao');
  FConexao.Conectar(fdConexao);
end;

end.
