unit ContasAPagar.View.Principal;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.ListBox,
  FMX.Layouts,
  FMX.Controls.Presentation,
  FMX.MultiView,
  ContasAPagar.View.Cartoes,
  FMX.Objects, FMX.StdCtrls;

type
  TfrmPrincipal = class(TForm)
    LayoutMain: TLayout;
    MultiView1: TMultiView;
    ListBox1: TListBox;
    ltbDashBoard: TListBoxItem;
    ltbCartoes: TListBoxItem;
    ltbEntrada: TListBoxItem;
    ltbSaida: TListBoxItem;
    lytBase: TLayout;
    ListBoxItem1: TListBoxItem;
    lytTopo: TLayout;
    lytMestre: TLayout;
    Rectangle1: TRectangle;
    btnMasterbuttom: TButton;
    Label1: TLabel;
    ltbConfigurações: TListBoxItem;
    procedure ltbCartoesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ltbDashBoardClick(Sender: TObject);
    procedure ListBoxItem1Click(Sender: TObject);
    procedure ltbEntradaClick(Sender: TObject);
    procedure ltbSaidaClick(Sender: TObject);
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
  ContasAPagar.View.Saidas;

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
  MultiView1.Mode := TMultiViewMode.Drawer;
end;

procedure TfrmPrincipal.ListBoxItem1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.ltbCartoesClick(Sender: TObject);
begin
  AbrirFormulario(TfrmCartoes)
end;

procedure TfrmPrincipal.ltbDashBoardClick(Sender: TObject);
begin
  AbrirFormulario(TfrmDashBoard);
end;

procedure TfrmPrincipal.ltbEntradaClick(Sender: TObject);
begin
  AbrirFormulario(TfrmEntrada)
end;

procedure TfrmPrincipal.ltbSaidaClick(Sender: TObject);
begin
  AbrirFormulario(TFrmSaidas);
end;

end.
