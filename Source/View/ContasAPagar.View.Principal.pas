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
    procedure ListBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  ContasAPagar.Diversos.LoadLayout;

{$R *.fmx}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  MultiView1.Mode := TMultiViewMode.Drawer;
end;

procedure TfrmPrincipal.ListBox1Change(Sender: TObject);
begin
  MultiView1.HideMaster;
end;

procedure TfrmPrincipal.ltbCartoesClick(Sender: TObject);
begin
  TClassLoad.LoadLayout(LayoutMain,TfrmCartoes);
end;

end.
