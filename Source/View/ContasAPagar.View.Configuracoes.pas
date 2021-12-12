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
    Image2: TImage;
    lblCartoes: TLabel;
    ltbEntrada: TListBoxItem;
    Image3: TImage;
    lblReceitas: TLabel;
    ltbDespesas: TListBoxItem;
    Image4: TImage;
    lblDespesas: TLabel;
    ltbConfigurações: TListBoxItem;
    Image5: TImage;
    lblConfiguracoes: TLabel;
    lytMain: TLayout;
    procedure ltbCartoesClick(Sender: TObject);
    procedure ltbDespesasClick(Sender: TObject);
    procedure ltbEntradaClick(Sender: TObject);
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
  ContasAPagar.Diversos.LoadLayout, ContasAPagar.View.Cartoes, ContasAPagar.View.TipoReceitas;

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

procedure TfrmConfiguracoes.ltbDespesasClick(Sender: TObject);
begin
//  AbrirFormulario(Tfrmdepesas)
end;

procedure TfrmConfiguracoes.ltbEntradaClick(Sender: TObject);
begin
  AbrirFormulario(TfrmReceitas)
end;

end.
