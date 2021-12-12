unit ContasAPagar.View.TipoReceitas;

interface

uses
  ContasAPagar.Controller.Cartoes,
  ContasAPagar.Interfaces.Controller.Cartoes,
  ContasAPagar.Model.Entity.TipoReceita,
  ContasAPagar.View.ModeloPrincipal,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  FireDAC.DApt.Intf,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Error,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FMX.ActnList,
  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.Dialogs,
  FMX.Edit,
  FMX.Forms,
  FMX.Graphics,
  FMX.ImgList,
  FMX.Layouts,
  FMX.ListView.Adapters.Base,
  FMX.ListView.Appearances,
  FMX.ListView.Types,
  FMX.ListView,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.TabControl,
  FMX.Types,
  System.Actions,
  System.Classes,
  System.ImageList,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants;

type
  TfrmReceitas = class(TfrmModelo)
    Layout1: TLayout;
    edtDescricao: TEdit;
    lblDesc: TLabel;
    edtIdCartoes: TEdit;
    ListView1: TListView;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Controller : IControllerCartoes<TTipoReceitas>;
    procedure HabilitarBotoes(pHabilitar: Boolean);

  public
    { Public declarations }
    procedure BuscarDados; override;
   end;

var
  frmReceitas: TfrmReceitas;

implementation

uses
  ContasAPagar.Diversos.Enumerados;

{$R *.fmx}

{ TfrmModelo1 }

procedure TfrmReceitas.BuscarDados;
var
  Receitas : TTipoReceitas;
begin
  inherited;
  Receitas := TTipoReceitas.Create;
  try
    if FDConsulta.Active then
    begin
      FDConsulta.EmptyDataSet;
    end;
    FDConsulta.AppendData(Controller.Tela(Tela).Pesquisar(Receitas),True);
  finally
    FreeAndNil(Receitas);
  end;
end;

procedure TfrmReceitas.FormCreate(Sender: TObject);
begin
  Tela := ttTipoReceitas;
  Controller := TControllerCartoes<TTipoReceitas>.New;
  inherited;
  BuscarDados;
  TabControl1.ActiveTab := TabItem1;
end;

procedure TfrmReceitas.HabilitarBotoes(pHabilitar: Boolean);
begin
  case pHabilitar of
    True:
    begin
      edtIdCartoes.Enabled := True;
      edtDescricao.Enabled := True;
      btnSalvar.Visible    := True;
    end;
    False:
    begin
      edtIdCartoes.Enabled := False;
      edtDescricao.Enabled := False;
      btnSalvar.Visible    := False;
    end;
  end;
end;

end.
