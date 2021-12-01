unit ContasAPagar.View.Cartoes;

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
  FMX.ListBox,
  FMX.Layouts,
  FMX.Controls.Presentation,
  FMX.Edit,
  ContasAPagar.View.ModeloPrincipal,
  FMX.TabControl,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ListView,
  System.Actions,
  FMX.ActnList,
  System.ImageList,
  FMX.ImgList,
  ContasAPagar.Controller.Cartoes, ContasAPagar.Diversos.Enumerados,
  ContasAPagar.Diversos.RTTI;

type
  TfrmCartoes = class(TfrmModelo)
    ListView1: TListView;
    Layout1: TLayout;
    edtDescricao: TEdit;
    lblDesc: TLabel;
    lblCodigo: TLabel;
    edtID: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCartoes: TfrmCartoes;

implementation

{$R *.fmx}

uses
  ContasAPagar.Diversos.Procedimentos, Data.DB,
  ContasAPagar.Model.Entity.Cartoes;

procedure TfrmCartoes.btnSalvarClick(Sender: TObject);
var
  Cartoes : Tcartoes;
begin
  inherited;
  Cartoes := TCartoes.Create;
  try
    TClassRtti.getClassDoForm(Layout1,Cartoes);
    Controller.Tela(ttCartoes).Salvar(FState,Cartoes);
  finally
    FreeAndNil(Cartoes)
  end;

end;

procedure TfrmCartoes.FormCreate(Sender: TObject);
begin
  Tela := ttCartoes;
  inherited;
  TabControl1.ActiveTab := TabItem1;
  TProcedimentos.SetarFoco(edtDescricao);
end;

end.
