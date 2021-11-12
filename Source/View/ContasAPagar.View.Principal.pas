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
  FMX.MultiView, ContasAPagar.View.Cartoes, FMX.Objects, FMX.StdCtrls;

type
  TfrmPrincipal = class(TForm)
    LayoutMain: TLayout;
    MultiView1: TMultiView;
    ListBox1: TListBox;
    ltbDashBoard: TListBoxItem;
    ltbCartoes: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    lytBase: TLayout;
    ListBoxItem1: TListBoxItem;
    lytTopo: TLayout;
    lytMestre: TLayout;
    Rectangle1: TRectangle;
    btnMasterbuttom: TButton;
    procedure ltbCartoesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ltbDashBoardClick(Sender: TObject);
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
  ContasAPagar.Diversos.LoadLayout;

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

procedure TfrmPrincipal.ltbCartoesClick(Sender: TObject);
begin
  AbrirFormulario(TfrmCartoes)
end;

procedure TfrmPrincipal.ltbDashBoardClick(Sender: TObject);
begin
  FecharFormulario;
end;

end.
