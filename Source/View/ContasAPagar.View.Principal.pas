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
  FMX.Objects, FMX.StdCtrls, System.ImageList, FMX.ImgList, System.Actions,
  FMX.ActnList;

type
  TfrmPrincipal = class(TForm)
    LayoutMain: TLayout;
    MultiView1: TMultiView;
    ListBox1: TListBox;
    ltbDashBoard: TListBoxItem;
    ltbCartoes: TListBoxItem;
    ltbEntrada: TListBoxItem;
    ltbDespesas: TListBoxItem;
    lytBase: TLayout;
    lytTopo: TLayout;
    lytMestre: TLayout;
    Rectangle1: TRectangle;
    btnMasterbuttom: TButton;
    Label1: TLabel;
    ltbConfigura��es: TListBoxItem;
    Rectangle2: TRectangle;
    Layout1: TLayout;
    sbSair: TSpeedButton;
    Layout2: TLayout;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    lblDashboard: TLabel;
    lblCartoes: TLabel;
    lblEntradas: TLabel;
    lblDespesas: TLabel;
    lblConfiguracoes: TLabel;
    Image6: TImage;
    lblSair: TLabel;
    procedure ltbCartoesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ltbDashBoardClick(Sender: TObject);
    procedure ltbEntradaClick(Sender: TObject);
    procedure ltbDespesasClick(Sender: TObject);
    procedure sbSairClick(Sender: TObject);
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
  ContasAPagar.View.Despesas;

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
  AbrirFormulario(TFrmDespesas);
end;

procedure TfrmPrincipal.sbSairClick(Sender: TObject);
begin
  Close;
end;

end.
