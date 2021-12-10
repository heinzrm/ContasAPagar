unit ContasAPagar.View.Principal;

interface

uses
  ContasAPagar.View.Cartoes,
  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.Dialogs,
  FMX.Forms,
  FMX.Graphics,
  FMX.ImgList,
  FMX.Layouts,
  FMX.ListBox,
  FMX.MultiView,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Types,
  System.Actions,
  System.Classes,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants;

type
  TfrmPrincipal = class(TForm)
    LayoutMain: TLayout;
    MultiView1: TMultiView;
    lytBase: TLayout;
    lytTopo: TLayout;
    lytMestre: TLayout;
    Rectangle1: TRectangle;
    btnMasterbuttom: TButton;
    Label1: TLabel;
    Layout2: TLayout;
    procedure ltbCartoesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ltbDashBoardClick(Sender: TObject);
    procedure ltbEntradaClick(Sender: TObject);
    procedure ltbDespesasClick(Sender: TObject);
    procedure sbSairClick(Sender: TObject);
    procedure ltbConfiguraçõesClick(Sender: TObject);
  private
    { Private declarations }
    procedure AbrirFormulario(pFormulario: TComponentClass);
    procedure FecharFormulario;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  ContasAPagar.Diversos.LoadLayout,
  ContasAPagar.View.Entradas,
  ContasAPagar.View.DashBoard,
//  ContasAPagar.View.Despesas,
  ContasAPagar.View.Configuracoes;

{$R *.fmx}

procedure TfrmPrincipal.AbrirFormulario(pFormulario: TComponentClass);
begin
  TClassLoad.LoadLayout(LayoutMain,pFormulario);
  MultiView1.HideMaster;
end;

procedure TfrmPrincipal.FecharFormulario;
begin
  TClassLoad.CloseLayout(LayoutMain);
  MultiView1.HideMaster;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  MultiView1.Mode := TMultiViewMode.PlatformBehaviour;
end;

procedure TfrmPrincipal.ltbCartoesClick(Sender: TObject);
begin
  AbrirFormulario(TfrmCartoes)
end;

procedure TfrmPrincipal.ltbConfiguraçõesClick(Sender: TObject);
begin
  AbrirFormulario(TfrmConfiguracoes);
end;

procedure TfrmPrincipal.ltbDashBoardClick(Sender: TObject);
begin
  AbrirFormulario(TfrmDashBoard);
end;

procedure TfrmPrincipal.ltbEntradaClick(Sender: TObject);
begin
  AbrirFormulario(TfrmEntrada)
end;

procedure TfrmPrincipal.ltbDespesasClick(Sender: TObject);
begin
//  AbrirFormulario(TFrmDespesas);
end;

procedure TfrmPrincipal.sbSairClick(Sender: TObject);
begin
  FecharFormulario;
  FreeAndNil(LayoutMain);
  Close;
end;

end.
