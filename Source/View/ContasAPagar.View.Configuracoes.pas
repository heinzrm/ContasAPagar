unit ContasAPagar.View.Configuracoes;

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
  FMX.StdCtrls,
  FMX.Objects,
  FMX.ListBox,
  FMX.Layouts,
  FMX.MultiView,
  FMX.Controls.Presentation;

type
  TfrmConfiguracoes = class(TForm)
    lytBase: TLayout;
    Layout2: TLayout;
    LayoutMain: TLayout;
    MultiView1: TMultiView;
    Rectangle2: TRectangle;
    ListBox1: TListBox;
    ltbCartoes: TListBoxItem;
    imgCartoes: TImage;
    lblCartoes: TLabel;
    ltbEntrada: TListBoxItem;
    imgReceitas: TImage;
    lblReceitas: TLabel;
    ltbDespesas: TListBoxItem;
    imgDespesas: TImage;
    lblDespesas: TLabel;
    lytMain: TLayout;
    ltbCategoria: TListBoxItem;
    imgCategoria: TImage;
    lblCategoria: TLabel;
    procedure ltbCartoesClick(Sender: TObject);
    procedure ltbDespesasClick(Sender: TObject);
    procedure ltbEntradaClick(Sender: TObject);
    procedure ltbCategoriaClick(Sender: TObject);
  private
    { Private declarations }
    procedure AbrirFormulario(pFormulario: TComponentClass);
  public
    { Public declarations }
  end;

var
  frmConfiguracoes: TfrmConfiguracoes;

implementation

uses
  ContasAPagar.Diversos.LoadLayout, ContasAPagar.View.Cartoes, ContasAPagar.View.TipoReceitas,
  ContasAPagar.View.TipoDespesas, ContasAPagar.View.Categoria;

{$R *.fmx}

{ TfrmConfiguracoes }

procedure TfrmConfiguracoes.AbrirFormulario(pFormulario: TComponentClass);
begin
  TClassLoad.LoadLayout(lytMain,pFormulario);
  MultiView1.HideMaster;
end;

procedure TfrmConfiguracoes.ltbCartoesClick(Sender: TObject);
begin
  AbrirFormulario(TFrmCartoes);
end;

procedure TfrmConfiguracoes.ltbCategoriaClick(Sender: TObject);
begin
  AbrirFormulario(TfrmCategoria);
end;

procedure TfrmConfiguracoes.ltbDespesasClick(Sender: TObject);
begin
  AbrirFormulario(TfrmTipoDespesas)
end;

procedure TfrmConfiguracoes.ltbEntradaClick(Sender: TObject);
begin
  AbrirFormulario(TfrmReceitas)
end;

end.
