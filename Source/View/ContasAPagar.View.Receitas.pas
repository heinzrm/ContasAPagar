unit ContasAPagar.View.Receitas;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  ContasAPagar.View.ModeloPrincipal,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FMX.TabControl,
  System.Actions,
  FMX.ActnList,
  System.ImageList,
  FMX.ImgList,
  FMX.Objects,
  FMX.Controls.Presentation,
  FMX.Layouts,
  FMX.Edit,
  ContasAPagar.Controller.Cartoes,
  ContasAPagar.Model.Entity.Receita,
  ContasAPagar.Interfaces.Controller.Cartoes, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView;

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
    Controller : IControllerCartoes<TReceitas>;
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
  Receitas : TReceitas;
begin
  inherited;
  Receitas := TReceitas.Create;
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
  Tela := ttReceitas;
  Controller := TControllerCartoes<TReceitas>.New;
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
