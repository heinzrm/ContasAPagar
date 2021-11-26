unit ContasAPagar.Conexao.Modulo.Principal;

interface

uses
  System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, fmx.Forms;

type
  TdmPrincipal = class(TDataModule)
    fdConexao: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  published
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
  try
    FConexao   := TConexao.Create(Format('%s\config.ini',[GetCurrentDir]),'Conexao');
    FConexao.Conectar(fdConexao);
  except
    on E:exception do
    begin
      Application.Terminate;
      DisposeOf;
      raise Exception.Create(E.Message);
    end;
  end;
end;

end.
